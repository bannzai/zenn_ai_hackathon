import { z } from "zod";
import { GroundingDataSchema } from "./grounding";
import { ServerTimestampSchema } from "./util/timestamp";
import { LocationSchema } from "./location";

export const TODOSchema = z
  .object({
    id: z.string(),
    userID: z.string(),
    taskID: z.string(),
    content: z.string().describe("TODOの内容"),
    supplement: z.string().describe("補足情報"),
    aiTextResponseMarkdown: z.string().nullable(),
    groundings: z.array(GroundingDataSchema).nullable(),
    // TODOの代表的な場所
    // 未処理の場合はnull。処理完了の場合は空配列の可能性がある
    locations: z.array(LocationSchema).nullable(),
    locationsAITextResponse: z.string().nullable(),
    locationsGroundings: z.array(GroundingDataSchema).nullable(),

    // 所要時間(秒)
    timeRequired: z.number().describe("所要時間(秒)").nullish(),
    timeRequiredAITextResponse: z.string().nullish(),
    timeRequiredGroundings: z.array(GroundingDataSchema).nullish(),
  })
  .merge(ServerTimestampSchema);

export type TODO = z.infer<typeof TODOSchema>;
