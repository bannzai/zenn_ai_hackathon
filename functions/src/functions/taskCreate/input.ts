import { z } from "zod";
import { UserRequestSchema } from "../../entity/userRequest";

export const TaskCreateSchema = z.object({
  taskID: z.string(),
  question: z.string(),
  userRequest: UserRequestSchema,
});
