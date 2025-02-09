import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:todomaker/components/error/error_alert.dart';
import 'package:todomaker/entity/location_form.dart';

class LocationForm extends HookWidget {
  final Future<void> Function(LocationFormInfo) onSubmit;
  const LocationForm({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final geoInfo = useState<(Placemark, Location)?>(null);
    final geoInfoValue = geoInfo.value;

    final placemarkValue = geoInfoValue?.$1;
    final text = useState('');
    final placeMarkDisplayName = placemarkValue?.name ??
        placemarkValue?.locality ??
        placemarkValue?.subLocality ??
        placemarkValue?.thoroughfare ??
        placemarkValue?.subThoroughfare ??
        placemarkValue?.postalCode;
    geoInfo.addListener(() {
      text.value = placeMarkDisplayName ?? '';
    });
    final focusNode = useFocusNode();

    return AlertDialog(
      title: const Column(
        children: [
          Text('🤖'),
          Text('関連する位置情報・会場・場所をAIに聞く'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('タスクの達成のためにヒントとなる会場・場所を提案できます。現在地・職場などを入力してください'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  child: TextFormField(
                    initialValue: text.value,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      enabledBorder: UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(),
                      hintText: '東京都千代田区永田町1-7-1',
                      labelText: '自宅・職場など',
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (value) {
                      text.value = value;
                    },
                    onFieldSubmitted: (value) async {
                      focusNode.unfocus();

                      text.value = value;

                      debugPrint('value: $value');

                      final List<Location> locations = await locationFromAddress(value);
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
                  final name = placeMarkDisplayName ?? '';
                  final latitude = geoInfoValue.$2.latitude;
                  final longitude = geoInfoValue.$2.longitude;
                  await onSubmit(LocationFormInfo(name: name, latitude: latitude, longitude: longitude));
                }
              : null,
          child: const Text('実行する'),
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
