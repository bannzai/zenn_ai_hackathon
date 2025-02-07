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
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('タスクの達成のために、AIが予定を組んでくれます。現在地を把握して最適な経路を提案したいので出発地点を入力してください'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  child: TextFormField(
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      enabledBorder: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(),
                      hintText: '東京都千代田区永田町1-7-1',
                      labelText: '出発地点',
                      contentPadding: EdgeInsets.zero,
                    ),
                    onFieldSubmitted: (value) async {
                      focusNode.unfocus();

                      List<Location> locations = await locationFromAddress(value);

                      debugPrint(locations.toString());
                    },
                  ),
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

                      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

                      debugPrint(placemarks.toString());
                    } catch (e) {
                      debugPrint(e.toString());
                      if (context.mounted) {
                        showErrorAlert(context, e.toString());
                      }
                    }
                  },
                  child: const Text('現在地を使用', style: TextStyle(fontSize: 10)),
                ),
              ],
            ),
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
