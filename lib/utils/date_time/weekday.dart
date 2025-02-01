// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:todomaker/style/color.dart';

enum Weekday {
  @JsonKey(name: 'Sunday')
  Sunday,
  @JsonKey(name: 'Monday')
  Monday,
  @JsonKey(name: 'Tuesday')
  Tuesday,
  @JsonKey(name: 'Wednesday')
  Wednesday,
  @JsonKey(name: 'Thursday')
  Thursday,
  @JsonKey(name: 'Friday')
  Friday,
  @JsonKey(name: 'Saturday')
  Saturday,
}

extension WeekdayFunctions on Weekday {
  static Weekday weekdayFromDate(DateTime date) {
    var weekdayIndex = date.weekday;
    var weekdays = Weekday.values;
    var sunday = weekdays.first;
    weekdays = weekdays.sublist(1)
      ..addAll(weekdays.sublist(0, weekdays.length))
      ..insert(0, sunday);
    return weekdays[weekdayIndex];
  }

  static List<Weekday> weekdaysForFirstWeekday(Weekday firstWeekday) {
    return Weekday.values.sublist(firstWeekday.index)..addAll(Weekday.values.sublist(0, firstWeekday.index));
  }

  static List<String> weekdays() {
    return DateFormat.EEEE(Platform.localeName).dateSymbols.WEEKDAYS;
  }

  String weekdayString() {
    return weekdays()[index];
  }

  // [日月火水木金土]
  static List<String> shortWeekdays() {
    return DateFormat.E(Platform.localeName).dateSymbols.SHORTWEEKDAYS;
  }

  String weekdayShortString() {
    return shortWeekdays()[index];
  }

  Color weekdayColor() {
    switch (this) {
      case Weekday.Sunday:
        return AppColors.sunday;
      case Weekday.Monday:
        return AppColors.weekday;
      case Weekday.Tuesday:
        return AppColors.weekday;
      case Weekday.Wednesday:
        return AppColors.weekday;
      case Weekday.Thursday:
        return AppColors.weekday;
      case Weekday.Friday:
        return AppColors.weekday;
      case Weekday.Saturday:
        return AppColors.saturday;
      default:
        throw ArgumentError.notNull('');
    }
  }
}
