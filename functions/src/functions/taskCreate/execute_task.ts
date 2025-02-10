import * as functions from "firebase-functions";
import { z } from "zod";
import { onTaskDispatched } from "firebase-functions/tasks";
import { taskCreate } from "./flow";
import { TaskCreateSchema } from "./input";
import { errorMessage } from "../../utils/error/message";
import { TaskRetryError } from "../../utils/error/taskRetry";

export const executeTaskCreate = onTaskDispatched(
  {
    retryConfig: {
      maxAttempts: 10,
      minBackoffSeconds: 60,
    },
    rateLimits: {
      maxConcurrentDispatches: 3,
    },
    timeoutSeconds: 10 * 60,
    memory: "1GiB",
  },
  async (req) => {
    console.log("#executeTaskCreate");
    try {
      const input = req.data as z.infer<typeof TaskCreateSchema>;
      const response = await taskCreate(input);
      console.log(response);
    } catch (err) {
      functions.logger.error(errorMessage(err));
      if (err instanceof TaskRetryError) {
        throw err;
      }
    }
  }
);
