import 'package:todomaker/utils/picker/time.dart';

class TimeOfDayFormatter {
  static String format(AppTimeOfDay timeOfDay) {
    final hour = timeOfDay.hour;
    final minute = timeOfDay.minute;
    final String hourString;
    final String minuteString;
    if (hour < 10) {
      hourString = '0$hour';
    } else {
      hourString = hour.toString();
    }
    if (minute < 10) {
      minuteString = '0$minute';
    } else {
      minuteString = minute.toString();
    }
    return '$hourString:$minuteString';
  }
}
