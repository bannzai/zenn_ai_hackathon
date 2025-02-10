import { z } from "genkit";
import { genkitAI } from "../../utils/ai/ai";
import { database } from "../../utils/firebase/firebase";
import {
  DataResponseSchema,
  errorResponse,
  ErrorResponseSchema,
} from "../../entity/response";
import { GroundingDataSchema } from "../../entity/grounding";
import { zodTypeGuard } from "../../utils/stdlib/type_guard";
import { FillLocationSchema } from "./input";
import { TaskPreparedSchema } from "../../entity/task";
import { LocationSchema } from "../../entity/location";
import { queryLocation } from "../../utils/queryLocation";
import { TaskRetryError } from "../../utils/error/taskRetry";
import { errorMessage } from "../../utils/error/message";

const TaskResponseSchema = TaskPreparedSchema.extend({
  locations: z.array(LocationSchema),
  locationsAITextResponse: z.string(),
  locationsGroundings: z.array(GroundingDataSchema),
});
const ResponseSchema = z.union([
  DataResponseSchema.extend({
    data: z.object({
      task: TaskResponseSchema,
    }),
  }),
  ErrorResponseSchema,
]);

// このflowはCloud Taskから使用されるのでエラーハンドリングは慎重に
export const fillTaskLocation = genkitAI.defineFlow(
  {
    name: "fillTaskLocation",
    inputSchema: FillLocationSchema,
    outputSchema: ResponseSchema,
  },
  async (input) => {
    console.log(`#fillTaskLocation: ${JSON.stringify({ input }, null, 2)}`);

    try {
      const {
        taskID,
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

      // e.g) 杉並区成田東4丁目周辺 確定申告に関しての問い合わせ先を教えてください「申告方法の選択: e-Taxを利用するか、郵送または税務署への持参するか決定します
      const { aiTextResponse, groundings, locations } = await queryLocation({
        query: `${userLocation.name}周辺 ${task.question}に関しての問い合わせ先を教えてください`,
      }).catch((err) => {
        throw new TaskRetryError(`queryLocation failed. ${errorMessage(err)}`);
      });

      const taskUpdate: z.infer<typeof TaskResponseSchema> = {
        ...task,
        locations: locations,
        locationsAITextResponse: aiTextResponse,
        locationsGroundings: groundings,
      };

      await taskDocRef.set(taskUpdate, { merge: true });

      const response: z.infer<typeof ResponseSchema> = {
        result: "OK",
        statusCode: 200,
        data: {
          task: taskUpdate,
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
