import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:todomaker/utils/picker/toolbar.dart';

class AppTimeOfDay {
  final int hour;
  final int minute;

  AppTimeOfDay({required this.hour, required this.minute});

  static AppTimeOfDay fromSeconds(int seconds) {
    final hour = seconds ~/ 3600;
    final minute = (seconds % 3600) ~/ 60;
    return AppTimeOfDay(hour: hour, minute: minute);
  }
}

class AppTimePicker extends StatelessWidget {
  final AppTimeOfDay initialTime;

  const AppTimePicker({
    super.key,
    required this.initialTime,
  });

  @override
  Widget build(BuildContext context) {
    var hour = initialTime.hour;
    var minute = initialTime.minute;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        PickerToolbar(
          done: (() {
            Navigator.pop(context, AppTimeOfDay(hour: hour, minute: minute));
          }),
          cancel: (() => Navigator.pop(context, null)),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 3,
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CupertinoPicker(
                    itemExtent: 1,
                    scrollController: FixedExtentScrollController(
                      initialItem: hour,
                    ),
                    onSelectedItemChanged: (int value) {
                      hour = value;
                    },
                    children: List.generate(24, (index) => Text('${index + 1}時')),
                  )),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CupertinoPicker(
                  itemExtent: 1,
                  scrollController: FixedExtentScrollController(
                    initialItem: minute,
                  ),
                  onSelectedItemChanged: (int value) {
                    minute = value;
                  },
                  children: List.generate(60, (index) => Text('$index分')),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Future<AppTimeOfDay?> showAppTimePicker(BuildContext context, {required AppTimeOfDay initialTime}) {
  return showModalBottomSheet(
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      return AppTimePicker(initialTime: initialTime);
    },
  );
}
