import { z } from "zod";
import { DataResponseSchema, ErrorResponseSchema } from "../../entity/response";
import { getFunctions } from "firebase-admin/functions";
import { getFunctionURL } from "../../utils/firebase/gcp";
import { genkitAI } from "../../utils/ai/ai";
import { TODOPrepareSchema } from "./input";

const ResponseSchema = z.union([
  DataResponseSchema.extend({
    data: z.object({
      taskID: z.string(),
    }),
  }),
  ErrorResponseSchema,
]);

export const enqueueTODOPrepare = genkitAI.defineTool(
  {
    name: "enqueueTODOPrepare",
    description: "enqueueTODOPrepare",
    inputSchema: TODOPrepareSchema,
    outputSchema: ResponseSchema,
  },
  async (input) => {
    const queue = getFunctions().taskQueue("executeTODOPrepare");
    const executeTODOPrepareURL = await getFunctionURL("executeTODOPrepare");
    await queue.enqueue(input, {
      uri: executeTODOPrepareURL,
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
