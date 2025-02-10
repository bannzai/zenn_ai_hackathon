import { z } from "zod";
import { UserRequestSchema } from "../../entity/userRequest";

export const FillLocationSchema = z.object({
  taskID: z.string(),
  userLocation: z.object({
    name: z.string(),
  }),
  userRequest: UserRequestSchema,
});
