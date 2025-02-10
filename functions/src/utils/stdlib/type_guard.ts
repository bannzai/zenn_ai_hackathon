import type z from "zod";

// 実際に遭遇したケース。safeParseでは、指定した型の新しいparseされたインスタンスが返却されるのでtype guardを用意する
//
// export const TaskPreparedSchema = z
//   .object({
//     status: z.literal("prepared"),
//     preparedDateTime: FirestoreTimestampSchema,
//   })
// .....
//   const updateTask: z.infer<typeof updateTaskSchema> = {
//     status: "prepared",
//     preparedDateTime: Timestamp.now(),
//     serverUpdatedDateTime: Timestamp.now(),
//   };

//   const taskSnapshot = await database
//     .doc(`/users/${userID}/tasks/${taskID}`)
//     .get();
//   const task = TaskPreparedSchema.safeParse({
//     ...(taskSnapshot.data() ?? {}),
//     ...updateTask,
//   }).data;
//   if (!task) {
//     // 用意できなかったプロパティがあると判断するのでRetryする
//     functions.logger.info("task not fullfilled", {
//       taskLoading,
//     });
//     throw new Error("task not fullfilled");
//   }

export function zodTypeGuard<T extends z.ZodTypeAny>(
  schema: T,
  data: unknown
): data is z.infer<T> {
  const result = schema.safeParse(data);
  if (process.env.APP_ENV === "local") {
    if (!result.success) {
      console.error(result.error);
    }
  }
  return result.success;
}
