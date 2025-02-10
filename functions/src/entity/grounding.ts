import { z } from "zod";

export const GroundingDataSchema = z.object({
  url: z.string().optional(),
  title: z.string().optional(),
  index: z.number().optional(),
});

export type GroundingData = z.infer<typeof GroundingDataSchema>;
