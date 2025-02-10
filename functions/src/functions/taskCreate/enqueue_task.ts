import { z } from "zod";
import { TaskCreateSchema } from "./input";
import { DataResponseSchema, ErrorResponseSchema } from "../../entity/response";
import { getFunctions } from "firebase-admin/functions";
import { getFunctionURL } from "../../utils/firebase/gcp";
import { onFlow } from "@genkit-ai/firebase/functions";
import { genkitAI } from "../../utils/ai/ai";
import { appAuthPolicy } from "../../utils/ai/authPolicy";

const ResponseSchema = z.union([
  DataResponseSchema.extend({
    data: z.object({
      taskID: z.string(),
    }),
  }),
  ErrorResponseSchema,
]);

export const enqueueTaskCreate = onFlow(
  genkitAI,
  {
    name: "enqueueTaskCreate",
    inputSchema: TaskCreateSchema.pick({
      taskID: true,
      question: true,
      userRequest: true,
    }),
    outputSchema: ResponseSchema,
    authPolicy: appAuthPolicy("enqueueTaskCreate"),
  },
  async (input) => {
    const queue = getFunctions().taskQueue("executeTaskCreate");
    const executeTaskCreateURL = await getFunctionURL("executeTaskCreate");
    await queue.enqueue(input, {
      uri: executeTaskCreateURL,
      headers: {
        "Content-Type": "application/json",
      },
    });

    const response: z.infer<typeof ResponseSchema> = {
      result: "OK",
      statusCode: 200,
      data: {
        taskID: input.taskID,
      },
    };

    return response;
  }
);
