import 'package:freezed_annotation/freezed_annotation.dart';

part 'location.g.dart';
part 'location.freezed.dart';

@freezed
class AppLocation with _$AppLocation {
  const AppLocation._();
  @JsonSerializable(explicitToJson: true)
  const factory AppLocation({
    required String name,
    required String? postalCode,
    required String? address,
    required String? tel,
    required String? email,
  }) = _AppLocation;

  factory AppLocation.fromJson(Map<String, dynamic> json) => _$AppLocationFromJson(json);
}

/*
import { z } from "zod";

export const LocationSchema = z.object({
  name: z.string().describe("場所の名称"),
  postalCode: z.string().nullable().describe("郵便番号"),
  address: z.string().nullable().describe("住所。郵便番号を除く"),
  tel: z.string().nullable().describe("電話番号"),
  email: z.string().nullable().describe("メールアドレス"),
});
*/
