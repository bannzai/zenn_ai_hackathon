import * as z from "zod";

// NOTE: .partial() だと undefined にしかならない
export function nullable<TSchema extends z.AnyZodObject>(schema: TSchema) {
  const entries = Object.entries(schema.shape) as [
    keyof TSchema["shape"],
    z.ZodTypeAny,
  ][];

  const newProps = entries.reduce(
    (acc, [key, value]) => {
      acc[key] = value.nullable();
      return acc;
    },
    {} as {
      [key in keyof TSchema["shape"]]: z.ZodNullable<TSchema["shape"][key]>;
    }
  );

  return z.object(newProps);
}

export const nonNullable = <T>(value: T): value is NonNullable<T> =>
  value != null;
