import { z } from "zod";

export const UserRequestSchema = z.object({
  userID: z.string(),
});

export type UserRequest = z.infer<typeof UserRequestSchema>;
