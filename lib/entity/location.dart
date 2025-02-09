import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todomaker/entity/grounding_data.dart';
import 'package:todomaker/entity/timestamp.dart';

part 'location.g.dart';
part 'location.freezed.dart';

@freezed
class Location with _$Location {
  const Location._();
  @JsonSerializable(explicitToJson: true)
  const factory Location({
    required String name,
    required String? postalCode,
    required String? address,
    required String? tel,
    required String? email,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
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
