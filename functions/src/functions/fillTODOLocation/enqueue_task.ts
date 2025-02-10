import { z } from "zod";
import { FillTODOLocationSchema } from "./input";
import { DataResponseSchema, ErrorResponseSchema } from "../../entity/response";
import { getFunctions } from "firebase-admin/functions";
import { getFunctionURL } from "../../utils/firebase/gcp";
import { onFlow } from "@genkit-ai/firebase/functions";
import { genkitAI } from "../../utils/ai/ai";
import { appAuthPolicy } from "../../utils/ai/authPolicy";
import { database } from "../../utils/firebase/firebase";
import { TODOSchema } from "../../entity/todo";
import { zodTypeGuard } from "../../utils/stdlib/type_guard";
import { FillLocationSchema } from "../fillLocation/input";

const ResponseSchema = z.union([
  DataResponseSchema.extend({
    data: z.object({
      taskID: z.string(),
    }),
  }),
  ErrorResponseSchema,
]);

export const enqueueFillTODOLocation = onFlow(
  genkitAI,
  {
    name: "enqueueFillTODOLocation",
    inputSchema: FillTODOLocationSchema,
    outputSchema: ResponseSchema,
    authPolicy: appAuthPolicy("enqueueFillTODOLocation"),
  },
  async (input) => {
    const queue = getFunctions().taskQueue("executeFillTODOLocation");
    const executeFillTODOLocationURL = await getFunctionURL(
      "executeFillTODOLocation"
    );
    await queue.enqueue(input, {
      uri: executeFillTODOLocationURL,
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

export const enqueueFillTODOLocations = genkitAI.defineTool(
  {
    name: "enqueueFillTODOLocations",
    description: "enqueueFillTODOLocations",
    inputSchema: FillLocationSchema,
    outputSchema: ResponseSchema,
  },
  async (input) => {
    const queue = getFunctions().taskQueue("executeFillTODOLocation");
    const executeFillTODOLocationURL = await getFunctionURL(
      "executeFillTODOLocation"
    );

    const todosCollectionRef = database.collection(
      `/users/${input.userRequest.userID}/tasks/${input.taskID}/todos`
    );
    const todoDocRefs = await todosCollectionRef.listDocuments();
    for (const todoDocRef of todoDocRefs) {
      const todoDoc = await todoDocRef.get();
      const todo = todoDoc.data();
      if (!zodTypeGuard(TODOSchema, todo)) {
        continue;
      }

      const taskInput: z.infer<typeof FillTODOLocationSchema> = {
        ...input,
        todoID: todo.id,
      };
      await queue.enqueue(taskInput, {
        uri: executeFillTODOLocationURL,
        headers: {
          "Content-Type": "application/json",
        },
      });
    }

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
