import { firebaseAuth } from "@genkit-ai/firebase/auth";
import { FunctionFlowAuth, noAuth } from "@genkit-ai/firebase/functions";
import * as z from "zod";

export function appAuthPolicy<I extends z.ZodTypeAny>(
  fn: string
): FunctionFlowAuth<I> {
  if (process.env.ENV === "local") {
    return noAuth();
  }
  // 他のonFlowからrunFlow経由で呼び出す場合は、FUNCTION_NAMEが一致しないため、noAuthを返す
  if (process.env.FUNCTION_NAME !== fn) {
    return noAuth();
  }
  return firebaseAuth((user, input) => {
    if (user.exp * 1000 < Date.now()) {
      throw new Error("User token is expired");
    }

    if (process.env.APP_ENV === "dev") {
      console.log(
        "[DEBUG] User ID: ",
        user.uid,
        "Input: ",
        JSON.stringify(input)
      );
    }
    if (
      input.userRequest?.userID != null &&
      input.userRequest.userID !== user.uid
    ) {
      throw new Error("User ID is not matched");
    }
  });
}
