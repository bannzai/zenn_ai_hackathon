import 'dart:async';

import 'package:todomaker/entity/todo.dart';
import 'package:device_calendar/device_calendar.dart';

Future<bool> grandPermission({required DeviceCalendarPlugin deviceCalendarPlugin}) async {
  var permissionsGranted = await deviceCalendarPlugin.requestPermissions();
  return permissionsGranted.isSuccess && permissionsGranted.data == true;
}

Future<List<Calendar>> retrieveCalendars({
  required DeviceCalendarPlugin deviceCalendarPlugin,
}) async {
  var calendarsResult = await deviceCalendarPlugin.retrieveCalendars();
  if (calendarsResult.isSuccess && calendarsResult.data != null) {
    return calendarsResult.data!;
  }
  return [];
}

/// 予定の読み出し（例：過去30日～未来30日）
Future<List<Event>> calendarEvents({
  required Todo todo,
  required DeviceCalendarPlugin deviceCalendarPlugin,
  required Calendar calendar,
}) async {
  final eventIDs = todo.calendarSchedules.map((e) => e.calendarEventID).toList();
  var eventsResult = await deviceCalendarPlugin.retrieveEvents(
    calendar.id,
    RetrieveEventsParams(eventIds: eventIDs),
  );
  final eventResultData = eventsResult.data;
  if (eventsResult.isSuccess && eventResultData != null) {
    return eventResultData;
  }
  return [];
}
