/* eslint-disable @typescript-eslint/no-var-requires */

import { initializeApp } from "firebase-admin/app";

initializeApp({
  serviceAccountId:
    process.env.GOOGLE_APPLICATION_CREDENTIALS_SERVICE_ACCOUNT_ID,
});

export const enqueueTaskCreate =
  require("./functions/taskCreate/enqueue_task").enqueueTaskCreate;
export const executeTaskCreate =
  require("./functions/taskCreate/execute_task").executeTaskCreate;

export const enqueueTODOPrepare =
  require("./functions/todoPrepare/enqueue_task").enqueueTODOPrepare;
export const executeTODOPrepare =
  require("./functions/todoPrepare/execute_task").executeTODOPrepare;

export const enqueueFillLocation =
  require("./functions/fillLocation/enqueue_task").enqueueFillLocation;
export const executeFillLocation =
  require("./functions/fillLocation/execute_task").executeFillLocation;

export const enqueueFillTODOLocation =
  require("./functions/fillTODOLocation/enqueue_task").enqueueFillTODOLocation;
export const executeFillTODOLocation =
  require("./functions/fillTODOLocation/execute_task").executeFillTODOLocation;
