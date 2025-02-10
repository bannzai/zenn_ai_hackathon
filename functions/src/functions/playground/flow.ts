import { z } from "genkit";
import { genkitAI } from "../../utils/ai/ai";
import { GroundingData, GroundingDataSchema } from "../../entity/grounding";
import { GroundingChunk } from "@google/generative-ai";
import { database } from "../../utils/firebase/firebase";
import { Task } from "../../entity/task";

export const playground = genkitAI.defineFlow(
  {
    name: "playground",
    inputSchema: z.object({
      question: z.string(),
    }),
    outputSchema: z.object({
      answer: z.string(),
      groundings: z.array(GroundingDataSchema),
      json: z.any(),
    }),
  },
  async (input) => {
    console.log(`#playground: ${JSON.stringify({ input }, null, 2)}`);
    if (process.env.APP_ENV !== "local") {
      return {
        answer: "localのみ実行できます",
        groundings: [],
        json: "",
      };
    }
    const response = await genkitAI.generate({
      prompt: input.question,
    });
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

    // const jsonResponse = await genkitAI.generate({
    //   prompt: input.question,
    //   output: {
    //     schema: z.array(
    //       z.object({
    //         location: z.object({
    //           name: z.string(),
    //           postalCode: z.string().nullable(),
    //           address: z.string().nullable().describe("住所。郵便番号を除く"),
    //           tel: z.string().nullable().describe("電話番号"),
    //           email: z.string().nullable().describe("メールアドレス"),
    //         }),
    //       })
    //     ),
    //   },
    // });

    const jsonResponse = await genkitAI.generate({
      prompt: input.question,
      output: {
        schema: z.object({
          noDueDate: z.boolean().describe("制限なし"),
          dueDate: z.object({
            begin: z.date().describe("開始日"),
            end: z.date().describe("終了日"),
          }),
        }),
      },
    });
    const json = jsonResponse.output ?? null;

    return {
      answer: response.text ?? "",
      groundings,
      json,
    };
  }
);

export const playground2 = genkitAI.defineFlow(
  {
    name: "playground2",
    inputSchema: z.object({
      taskDocPath: z.string(),
      dueDate: z.string().describe("期日"),
    }),
    outputSchema: z.object({
      answer: z.string(),
      groundings: z.array(GroundingDataSchema),
      json: z.any(),
    }),
  },
  async (input) => {
    console.log(`#playground2: ${JSON.stringify({ input }, null, 2)}`);
    if (process.env.APP_ENV !== "local") {
      return {
        answer: "localのみ実行できます",
        groundings: [],
        json: "",
      };
    }

    const taskDocSnapshot = await database.doc(input.taskDocPath).get();
    const task = taskDocSnapshot.data() as Task;

    const todoCollectionSnapshot = await database
      .collection(`${input.taskDocPath}/todos`)
      .get();
    const todos = todoCollectionSnapshot.docs.map((doc) => doc.data());
    const todoPrompt = todos
      .map((todo) => `- ${todo.content}: ${todo.supplement ?? ""}`)
      .join("\n");

    const prompt = `
    タスク: 「${task.topic}」を終了したいです。
    下記の手順が存在します。それぞれのタスクに対しての所要時間を教えてください。単位は秒です。
    ${todoPrompt}
    `;
    console.log(`#playground2: ${prompt}`);
    const response = await genkitAI.generate({
      prompt,
    });
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
        schema: z.array(
          z.object({
            taskName: z.string().describe("タスク名"),
            seconds: z.number().describe("所要時間(秒)"),
          })
        ),
      },
    });
    const json = jsonResponse.output ?? null;

    return {
      answer: response.text ?? "",
      groundings,
      json,
    };
  }
);
