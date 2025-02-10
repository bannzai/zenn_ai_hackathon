import * as functions from "firebase-functions";
import { GoogleAuth } from "google-auth-library";

// ref: https://firebase.google.com/docs/functions/task-functions?gen=2nd
export async function getFunctionURL(name: string): Promise<string> {
  const auth = new GoogleAuth({
    scopes: "https://www.googleapis.com/auth/cloud-platform",
  });
  const projectId = await auth.getProjectId();

  // NOTE: [CloudTask:Region] "asia-northeast1" を使いたいが、なぜか us-central1 じゃないと動かないため明示的に指定する
  const location = "us-central1";
  const url =
    "https://cloudfunctions.googleapis.com/v2/" +
    `projects/${projectId}/locations/${location}/functions/${name}`;

  functions.logger.log(`Getting function URL for ${name} at ${url}`);

  const client = await auth.getClient();
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const res = await client.request<any>({ url });
  const uri = res.data?.serviceConfig?.uri;
  if (!uri) {
    throw new Error(`Unable to retreive uri for function at ${url}`);
  }
  return uri;
}
