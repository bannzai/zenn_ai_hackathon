import { z } from "zod";
import { UserRequestSchema } from "../../entity/userRequest";

export const FillTODOLocationSchema = z.object({
  taskID: z.string(),
  todoID: z.string(),
  userLocation: z.object({
    name: z.string(),
  }),
  userRequest: UserRequestSchema,
});
