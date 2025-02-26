import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:todomaker/components/error/error_alert.dart';
import 'package:todomaker/components/loading/loading.dart';
import 'package:todomaker/entity/location_form.dart';

class LocationForm extends HookWidget {
  final Future<void> Function(LocationFormInfo) onSubmit;
  const LocationForm({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final text = useState('');
    final textEditFormController = useTextEditingController();
    final focusNode = useFocusNode();
    final submitting = useState(false);

    textEditFormController.addListener(() {
      text.value = textEditFormController.text;
    });

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
          const Text('タスクの達成のためにヒントとなる会場・場所をAIが提案します。現在地・職場などを入力してください', style: TextStyle(fontSize: 10)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  child: TextFormField(
                    controller: textEditFormController,
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
                      final name = _formatted(firstPlacemark);
                      if (name.isEmpty) {
                        debugPrint('firstPlacemark: ${firstPlacemark.toString()}');
                        throw const FormatException('位置情報が取得できませんでした');
                      }

                      textEditFormController.text = name;
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
        Loading(
          isLoading: submitting.value,
          child: TextButton(
            onPressed: textEditFormController.text.isNotEmpty && !submitting.value
                ? () async {
                    submitting.value = true;
                    try {
                      final List<Location> locations = await locationFromAddress(textEditFormController.text);
                      final firstLocation = locations.firstOrNull;
                      final Placemark? firstPlacemark;
                      if (firstLocation != null) {
                        final placemarks = await placemarkFromCoordinates(firstLocation.latitude, firstLocation.longitude);
                        firstPlacemark = placemarks.firstOrNull;
                      } else {
                        firstPlacemark = null;
                      }
                      if (firstPlacemark == null) {
                        throw const FormatException('位置情報が取得できませんでした。入力した住所をご確認ください');
                      }

                      final name = _formatted(firstPlacemark);
                      final latitude = firstLocation?.latitude;
                      final longitude = firstLocation?.longitude;

                      await onSubmit(LocationFormInfo(name: name, latitude: latitude, longitude: longitude));
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    } catch (e) {
                      if (context.mounted) {
                        showErrorAlert(context, e.toString());
                      }
                    } finally {
                      submitting.value = false;
                    }
                  }
                : null,
            child: const Text('実行する'),
          ),
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

  String _formatted(Placemark? placemark) {
    if (placemark == null) {
      return '';
    }

    final placeMarkDisplayName =
        (placemark.locality ?? '') + (placemark.subLocality ?? '') + (placemark.thoroughfare ?? '') + (placemark.subThoroughfare ?? '');
    debugPrint('placemark.name: ${placemark.name}');
    debugPrint('placemark.locality: ${placemark.locality}');
    debugPrint('placemark.subLocality: ${placemark.subLocality}');
    debugPrint('placemark.thoroughfare: ${placemark.thoroughfare}');
    debugPrint('placemark.subThoroughfare: ${placemark.subThoroughfare}');
    debugPrint('placemark.postalCode: ${placemark.postalCode}');
    return placeMarkDisplayName;
  }
}
