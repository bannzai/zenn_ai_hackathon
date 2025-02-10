import { z } from "zod";

// Firestore schema definitions using zod
export const UserSchema = z.object({
  uid: z.string(),
  createdAt: z.string().datetime(),
  lastLogin: z.string().datetime(),
});

export type User = z.infer<typeof UserSchema>;