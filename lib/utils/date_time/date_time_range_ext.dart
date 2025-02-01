import 'package:flutter/material.dart';
import 'package:todomaker/utils/date_time/date_time_ext.dart';

extension DateTimeRangeExtension on DateTimeRange {
  bool containsInDay(DateTime date) {
    final isBefore = start.isBefore(date) || isSameDay(start, date);
    final isAfter = end.isAfter(date) || isSameDay(end, date);
    return isBefore && isAfter;
  }
}
