import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp json) {
    return json.toDate();
  }

  @override
  Timestamp toJson(DateTime dateTime) {
    return Timestamp.fromDate(dateTime);
  }
}

class NullableTimestampConverter
    implements JsonConverter<DateTime?, Timestamp?> {
  const NullableTimestampConverter();

  @override
  DateTime? fromJson(Timestamp? json) {
    return json?.toDate();
  }

  @override
  Timestamp? toJson(DateTime? dateTime) {
    if (dateTime == null) {
      return null;
    }
    return Timestamp.fromDate(dateTime);
  }
}

class ClientCreatedTimestamp implements JsonConverter<DateTime?, Timestamp?> {
  const ClientCreatedTimestamp();

  @override
  DateTime? fromJson(Timestamp? timestamp) {
    return timestamp?.toDate();
  }

  @override
  Timestamp toJson(DateTime? dateTime) {
    if (dateTime == null) return Timestamp.fromDate(DateTime.now());
    return Timestamp.fromDate(dateTime);
  }
}

class ClientUpdatedTimestamp implements JsonConverter<DateTime?, Timestamp?> {
  const ClientUpdatedTimestamp();

  @override
  DateTime? fromJson(Timestamp? timestamp) {
    return timestamp?.toDate();
  }

  @override
  Timestamp? toJson(DateTime? date) {
    if (date == null) return null;
    return Timestamp.fromDate(date);
  }
}

class ServerCreatedTimestamp implements JsonConverter<DateTime?, dynamic> {
  const ServerCreatedTimestamp();

  @override
  DateTime? fromJson(dynamic timestamp) {
    timestamp as Timestamp?;
    return timestamp?.toDate();
  }

  @override
  dynamic toJson(DateTime? dateTime) {
    if (dateTime == null) return FieldValue.serverTimestamp();
    return dateTime;
  }
}

class ServerUpdatedTimestamp implements JsonConverter<DateTime?, dynamic> {
  const ServerUpdatedTimestamp();

  @override
  DateTime? fromJson(dynamic timestamp) {
    timestamp as Timestamp?;
    return timestamp?.toDate();
  }

  @override
  dynamic toJson(DateTime? date) {
    return FieldValue.serverTimestamp();
  }
}
