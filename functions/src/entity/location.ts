import { z } from "zod";

export const LocationSchema = z.object({
  name: z.string().describe("場所の名称"),
  postalCode: z.string().nullable().describe("郵便番号"),
  address: z.string().nullable().describe("住所。郵便番号を除く"),
  tel: z.string().nullable().describe("電話番号"),
  email: z.string().nullable().describe("メールアドレス"),
});
