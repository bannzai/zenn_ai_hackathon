import { z } from "genkit";
import { genkitAI } from "../../utils/ai/ai";
import { TODOSchema } from "../../entity/todo";
import { database } from "../../utils/firebase/firebase";
import {
  DataResponseSchema,
  errorResponse,
  ErrorResponseSchema,
} from "../../entity/response";
import { GroundingDataSchema } from "../../entity/grounding";
import { zodTypeGuard } from "../../utils/stdlib/type_guard";
import { TaskPreparedSchema } from "../../entity/task";
import { LocationSchema } from "../../entity/location";
import { queryLocation } from "../../utils/queryLocation";
import { FillTODOLocationSchema } from "./input";
import { TaskRetryError } from "../../utils/error/taskRetry";
import { errorMessage } from "../../utils/error/message";

const TODOResponseSchema = TODOSchema.extend({
  locations: z.array(LocationSchema),
  locationsAITextResponse: z.string(),
  locationsGroundings: z.array(GroundingDataSchema),
});
const ResponseSchema = z.union([
  DataResponseSchema.extend({
    data: z.object({
      todo: TODOResponseSchema,
    }),
  }),
  ErrorResponseSchema,
]);

// このflowはCloud Taskから使用されるのでエラーハンドリングは慎重に
export const fillTODOLocation = genkitAI.defineFlow(
  {
    name: "fillTODOLocation",
    inputSchema: FillTODOLocationSchema,
    outputSchema: ResponseSchema,
  },
  async (input) => {
    console.log(`#fillTODOLocation: ${JSON.stringify({ input }, null, 2)}`);
    try {
      const {
        taskID,
        todoID,
        userLocation,
        userRequest: { userID },
      } = input;

      const taskDocRef = database
        .collection(`/users/${userID}/tasks`)
        .doc(taskID);
      const taskSnapshot = await taskDocRef.get();
      const task = taskSnapshot.data();
      if (!zodTypeGuard(TaskPreparedSchema, task)) {
        return errorResponse(
          new Error(`task prepared parse error. taskPrepared: ${task}`)
        );
      }

      const todoDocRef = await database.doc(
        `/users/${userID}/tasks/${taskID}/todos/${todoID}`
      );
      const todoDocSnapshot = await todoDocRef.get();
      const todo = todoDocSnapshot.data();
      if (!zodTypeGuard(TODOSchema, todo)) {
        return errorResponse(
          new Error(`todo loading parse error. todoLoading: ${todo}`)
        );
      }
      // e.g) 杉並区成田東4丁目周辺 確定申告に関して、次の文章に対する問い合わせ先を教えてください「申告方法の選択: e-Taxを利用するか、郵送または税務署への持参するか決定します」
      const { aiTextResponse, groundings, locations } = await queryLocation({
        query: `${userLocation.name}周辺 ${task.question}に関して、次の文章に対する問い合わせ先を教えてください「${todo.content}: ${todo.supplement ?? ""}」`,
      }).catch((err) => {
        throw new TaskRetryError(`queryLocation failed. ${errorMessage(err)}`);
      });

      const todoUpdate: z.infer<typeof TODOResponseSchema> = {
        ...todo,
        locations: locations,
        locationsAITextResponse: aiTextResponse,
        locationsGroundings: groundings,
      };
      await todoDocRef.set(todoUpdate, { merge: true });

      const response: z.infer<typeof ResponseSchema> = {
        result: "OK",
        statusCode: 200,
        data: {
          todo: todoUpdate,
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
