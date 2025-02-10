import { z } from "zod";
import { UserRequestSchema } from "../../entity/userRequest";

export const TODOPrepareSchema = z.object({
  taskID: z.string(),
  todoID: z.string(),
  question: z.string(),
  taskTopic: z.string(),
  content: z.string(),
  supplement: z.string(),
  userRequest: UserRequestSchema,
});
