import * as functions from "firebase-functions";
import { z } from "zod";
import { onTaskDispatched } from "firebase-functions/tasks";
import { errorMessage } from "../../utils/error/message";
import { FillTODOLocationSchema } from "../fillTODOLocation/input";
import { fillTODOLocation } from "../fillTODOLocation/flow";
import { TaskRetryError } from "../../utils/error/taskRetry";

export const executeFillTODOLocation = onTaskDispatched(
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
    console.log("#executeFillTODOLocation");
    try {
      const input = req.data as z.infer<typeof FillTODOLocationSchema>;
      const fillTODOLocationResponse = await fillTODOLocation(input);
      console.log({ fillTODOLocationResponse });
    } catch (err) {
      functions.logger.error(errorMessage(err));
      if (err instanceof TaskRetryError) {
        throw err;
      }
    }
  }
);
