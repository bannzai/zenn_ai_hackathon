import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:todomaker/components/error/error_alert.dart';

class AIPlanningDialog extends HookWidget {
  const AIPlanningDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();

    return AlertDialog(
      title: const Column(
        children: [
          Text('🤖'),
          Text('AIで予定を組む'),
        ],
      ),
      content: Column(
        children: [
          const Text('タスクの達成のために、AIが予定を組んでくれます。現在地を把握して最適な経路を提案したいので出発地点を入力してください'),
          Row(
            children: [
              TextFormField(
                focusNode: focusNode,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  enabledBorder: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(),
                  hintText: '東京都千代田区永田町1-7-1',
                  labelText: '出発地点',
                ),
                onFieldSubmitted: (value) async {
                  focusNode.unfocus();

                  List<Location> locations = await locationFromAddress(value);
                  final location = locations.first;

                  debugPrint(location.toString());
                },
              ),
              TextButton(
                onPressed: () async {
                  focusNode.unfocus();

                  try {
                    final permission = await Geolocator.requestPermission();
                    if (permission == LocationPermission.denied) {
                      throw const FormatException('位置情報の許可が必要です');
                    }
                    final position = await Geolocator.getCurrentPosition();

                    debugPrint(position.toString());
                  } catch (e) {
                    if (context.mounted) {
                      showErrorAlert(context, e.toString());
                    }
                  }
                },
                child: const Text('現在地を使用'),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('キャンセル'),
        ),
      ],
    );
  }
}
