import * as z from "zod";
import { errorMessage } from "../utils/error/message";

export const DataResponseSchema = z.object({
  result: z.literal("OK"),
  statusCode: z.number().optional(),
  data: z.unknown(),
});

export const ErrorResponseSchema = z.object({
  result: z.literal("NG"),
  statusCode: z.number().optional(),
  error: z.object({
    message: z.string(),
  }),
});

export const AppResponseSchema = z.union([
  DataResponseSchema,
  ErrorResponseSchema,
]);

export type DataResponse = z.infer<typeof DataResponseSchema>;
export type ErrorResponse = z.infer<typeof ErrorResponseSchema>;
export type AppResponse = z.infer<typeof AppResponseSchema>;

export function errorResponse(error: unknown): ErrorResponse {
  return {
    result: "NG",
    statusCode: 500,
    error: { message: errorMessage(error) },
  };
}
