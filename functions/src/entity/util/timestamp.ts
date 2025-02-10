import { Timestamp } from "firebase-admin/firestore";
import { z } from "zod";

export const FirestoreTimestampSchema = z.object({
  seconds: z.number(),
  nanoseconds: z.number(),
});

export type FirestoreTimestamp = z.infer<typeof FirestoreTimestampSchema>;

// 動作未確認
export function rawFirsetoreTimestamp(
  timestamp: FirestoreTimestamp
): Timestamp {
  return new Timestamp(timestamp.seconds, timestamp.nanoseconds);
}

// NOTE: Firestore の Timestamp を JSON に変換する。z.instanceOf(Timestamp)をそのままスキーマとして使い、JSONで返却すると { _seconds, _nanoseconds } という形式になるため、この関数を使って変換する
export function firestoreTimestampJSON(
  timestamp: Timestamp
): FirestoreTimestamp {
  return {
    seconds: timestamp.seconds,
    nanoseconds: timestamp.nanoseconds,
  };
}

export const ServerTimestampSchema = z.object({
  serverCreatedDateTime: FirestoreTimestampSchema,
  serverUpdatedDateTime: FirestoreTimestampSchema,
});

export type ServerTimestamp = z.infer<typeof ServerTimestampSchema>;
