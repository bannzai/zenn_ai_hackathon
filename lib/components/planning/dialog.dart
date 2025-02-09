import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:todomaker/components/error/error_alert.dart';
import 'package:todomaker/utils/functions/firebase_functions.dart';

class AIPlanningDialog extends HookWidget {
  final String taskID;
  const AIPlanningDialog({super.key, required this.taskID});

  @override
  Widget build(BuildContext context) {
    final geoInfo = useState<(Placemark, Location)?>(null);
    final geoInfoValue = geoInfo.value;

    final placemarkValue = geoInfoValue?.$1;
    final textFormEditController = useTextEditingController(text: '');
    final placeMarkDisplayName = placemarkValue?.name ??
        placemarkValue?.locality ??
        placemarkValue?.subLocality ??
        placemarkValue?.thoroughfare ??
        placemarkValue?.subThoroughfare ??
        placemarkValue?.postalCode;
    geoInfo.addListener(() {
      textFormEditController.text = placeMarkDisplayName ?? '';
    });
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
                    controller: textFormEditController,
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
                      final firstLocation = locations.firstOrNull;
                      if (firstLocation != null) {
                        final placemarks = await placemarkFromCoordinates(firstLocation.latitude, firstLocation.longitude);
                        if (placemarks.isNotEmpty) {
                          geoInfo.value = (placemarks.first, firstLocation);
                        }
                      }
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
                      final currentPosition = await Geolocator.getCurrentPosition();
                      final List<Placemark> placemarks = await placemarkFromCoordinates(currentPosition.latitude, currentPosition.longitude);
                      final firstPlacemark = placemarks.firstOrNull;
                      debugPrint('firstPlacemark: ${firstPlacemark.toString()}');
                      if (firstPlacemark != null) {
                        final List<Location> locations = await locationFromAddress(firstPlacemark.name ?? '');
                        final firstLocation = locations.firstOrNull;
                        debugPrint('firstLocation: ${firstLocation.toString()}');
                        if (firstLocation != null) {
                          geoInfo.value = (firstPlacemark, firstLocation);
                        }
                      }
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
          onPressed: geoInfoValue != null
              ? () async {
                  await functions.fillLocation(
                    taskID: taskID,
                    locationName: placeMarkDisplayName ?? '',
                    latitude: geoInfoValue.$2.latitude,
                    longitude: geoInfoValue.$2.longitude,
                  );
                }
              : null,
          child: const Text('予定を組む'),
        ),
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
