import { z } from "zod";
import { FillLocationSchema } from "./input";
import { DataResponseSchema, ErrorResponseSchema } from "../../entity/response";
import { getFunctions } from "firebase-admin/functions";
import { getFunctionURL } from "../../utils/firebase/gcp";
import { onFlow } from "@genkit-ai/firebase/functions";
import { genkitAI } from "../../utils/ai/ai";
import { appAuthPolicy } from "../../utils/ai/authPolicy";
import { enqueueFillTODOLocations } from "../fillTODOLocation/enqueue_task";

const ResponseSchema = z.union([
  DataResponseSchema.extend({
    data: z.object({
      taskID: z.string(),
    }),
  }),
  ErrorResponseSchema,
]);

export const enqueueFillLocation = onFlow(
  genkitAI,
  {
    name: "enqueueFillLocation",
    inputSchema: FillLocationSchema,
    outputSchema: ResponseSchema,
    authPolicy: appAuthPolicy("enqueueFillLocation"),
  },
  async (input) => {
    const queue = getFunctions().taskQueue("executeFillLocation");
    const executeFillLocationURL = await getFunctionURL("executeFillLocation");
    await queue.enqueue(input, {
      uri: executeFillLocationURL,
      headers: {
        "Content-Type": "application/json",
      },
    });

    await enqueueFillTODOLocations(input);

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
