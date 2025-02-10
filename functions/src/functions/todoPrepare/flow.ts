import { z } from "genkit";
import { genkitAI, googleSearchGroundingData } from "../../utils/ai/ai";
import { TODO, TODOSchema } from "../../entity/todo";
import { database } from "../../utils/firebase/firebase";
import {
  DataResponseSchema,
  errorResponse,
  ErrorResponseSchema,
} from "../../entity/response";
import { Timestamp } from "firebase-admin/firestore";
import { TODOPrepareSchema } from "./input";
import { GroundingData, GroundingDataSchema } from "../../entity/grounding";
import { zodTypeGuard } from "../../utils/stdlib/type_guard";
import { GroundingChunk } from "@google/generative-ai";
import { TaskRetryError } from "../../utils/error/taskRetry";
import { errorMessage } from "../../utils/error/message";

const todoWithGrounding = genkitAI.defineTool(
  {
    name: "todoWithGrounding",
    description: "todoWithGrounding",
    inputSchema: z.object({
      question: z.string(),
      content: z.string(),
      supplement: z.string().optional(),
    }),
    outputSchema: z.object({
      aiTextResponse: z.string(),
      groundings: z.array(GroundingDataSchema),
    }),
  },
  async (input) => {
    console.log(`#todoWithGrounding: ${JSON.stringify(input, null, 2)}`);
    const { question, content, supplement } = input;

    if (!supplement) {
      const { aiTextResponse, groundings } = await googleSearchGroundingData(
        `「${question}」に関する 「${content}」 に関して詳細に説明してください。出力はmarkdown形式にしてください`
      );

      return {
        aiTextResponse,
        groundings,
      };
    } else {
      const { aiTextResponse, groundings } = await googleSearchGroundingData(
        `「${question}」に関する 「${content}。${supplement}」 に関して詳細に説明してください。出力はmarkdown形式にしてください`
      );

      return {
        aiTextResponse,
        groundings,
      };
    }
  }
);

export const ResponseSchema = z.union([
  DataResponseSchema.extend({
    data: z.object({
      todo: TODOSchema,
    }),
  }),
  ErrorResponseSchema,
]);

// このflowはCloud Taskから使用されるのでエラーハンドリングは慎重に
export const todoPrepare = genkitAI.defineFlow(
  {
    name: "todoPrepare",
    inputSchema: TODOPrepareSchema,
    outputSchema: ResponseSchema,
  },
  async (input) => {
    console.log(`#todoPrepare: ${JSON.stringify({ input }, null, 2)}`);
    try {
      const {
        taskID,
        todoID,
        question,
        content,
        supplement,
        userRequest: { userID },
      } = input;

      const todoDocRef = database
        .collection(`/users/${userID}/tasks/${taskID}/todos`)
        .doc(todoID);
      const todoSnapshot = await todoDocRef.get();
      const todo = todoSnapshot.data();
      if (!zodTypeGuard(TODOSchema, todo)) {
        return errorResponse(
          new Error(`todo loading parse error. todoLoading: ${todo}`)
        );
      }

      if (
        todo.groundings != null &&
        todo.aiTextResponseMarkdown != null &&
        todo.timeRequired != null
      ) {
        const response: z.infer<typeof ResponseSchema> = {
          result: "OK",
          statusCode: 200,
          data: { todo },
        };
        return response;
      }

      if (todo.aiTextResponseMarkdown == null || todo.groundings == null) {
        const { aiTextResponse, groundings } = await todoWithGrounding({
          question,
          content,
          supplement,
        }).catch((err) => {
          throw new TaskRetryError(
            `todoWithGrounding failed. ${errorMessage(err)}`
          );
        });
        const updateTodoSchema = TODOSchema.pick({
          aiTextResponseMarkdown: true,
          groundings: true,
          serverUpdatedDateTime: true,
        });
        const updatedTodo: z.infer<typeof updateTodoSchema> = {
          aiTextResponseMarkdown: aiTextResponse,
          groundings,
          serverUpdatedDateTime: Timestamp.now(),
        };

        await todoDocRef.set(
          {
            ...todo,
            ...updatedTodo,
          },
          { merge: true }
        );
      }

      if (todo.timeRequired == null) {
        const {
          timeRequired,
          aiTextResponse: timeRequiredAITextResponse,
          groundings: timeRequiredGroundings,
        } = await todoTimeRequired({
          taskTopic: input.taskTopic,
          content,
          supplement,
        }).catch((err) => {
          throw new TaskRetryError(
            `todoTimeRequired failed. ${errorMessage(err)}`
          );
        });

        const updateTodoSchema = TODOSchema.pick({
          timeRequired: true,
          timeRequiredAITextResponse: true,
          timeRequiredGroundings: true,
          serverUpdatedDateTime: true,
        });
        const updatedTodo: z.infer<typeof updateTodoSchema> = {
          timeRequired,
          timeRequiredAITextResponse,
          timeRequiredGroundings,
          serverUpdatedDateTime: Timestamp.now(),
        };

        await todoDocRef.set(
          {
            ...todo,
            ...updatedTodo,
          },
          { merge: true }
        );
      }

      const newTODODoc = await database
        .collection(`/users/${userID}/tasks/${taskID}/todos`)
        .doc(todoID)
        .get();
      const newTodo = newTODODoc.data() as TODO;

      const response: z.infer<typeof ResponseSchema> = {
        result: "OK",
        statusCode: 200,
        data: {
          todo: newTodo,
        },
      };

      return response;
    } catch (error) {
      if (error instanceof TaskRetryError) {
        throw error;
      }
      return errorResponse(error);
    }
  }
);

const todoTimeRequired = genkitAI.defineTool(
  {
    name: "todoTimeRequired",
    description: "todoTimeRequired",
    inputSchema: z.object({
      taskTopic: z.string(),
      content: z.string(),
      supplement: z.string().optional(),
    }),
    outputSchema: z.object({
      timeRequired: z.number().nullable(),
      aiTextResponse: z.string().nullable(),
      groundings: z.array(GroundingDataSchema).nullable(),
    }),
  },
  async (input) => {
    const { taskTopic, content, supplement } = input;
    const todoPrompt = `- ${content}: ${supplement ?? ""}`;
    const prompt = `
    タスク: 「${taskTopic}」があります。関連した小タスクに下記があります。所要時間を教えてください。単位は「秒」です
    ${todoPrompt}
    `;
    const response = await genkitAI.generate({
      prompt,
    });
    const aiTextResponse = response.text;
    const responseCustom = response.custom as any;
    const candidates = responseCustom.candidates;
    const groundings: GroundingData[] = [];
    if (candidates) {
      for (const candidate of candidates) {
        const groudingMetadata = candidate?.groundingMetadata;
        const index = candidate?.index;
        const anyGroudingMetadata = groudingMetadata as any;
        // typo: https://github.com/google-gemini/generative-ai-js/issues/323
        const groundingChunks = anyGroudingMetadata[
          "groundingChunks"
        ] as GroundingChunk[];
        const web = groundingChunks?.[0].web;
        const title = web?.title;
        const url = web?.uri;
        // console.log(JSON.stringify({ groundingChunks: groundingChunks }));
        // console.log(JSON.stringify({ web: web }, null, 2));
        // console.log(JSON.stringify({ title: title }, null, 2));
        // console.log(JSON.stringify({ url: url }, null, 2));
        groundings.push({ title, url, index });
      }
    }

    const jsonResponse = await genkitAI.generate({
      prompt,
      output: {
        schema: z.object({
          seconds: z.number().describe("所要時間(秒)"),
        }),
      },
    });
    const json = jsonResponse.output ?? null;
    if (json) {
      const timeRequired = json.seconds;
      return { timeRequired, aiTextResponse, groundings };
    }
    return { timeRequired: null, aiTextResponse, groundings };
  }
);
