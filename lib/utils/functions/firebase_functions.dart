import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todomaker/entity/location_form.dart';

// GenKitがus-central1のサポートになる
final functions = FirebaseFunctions.instanceFor(region: 'us-central1');

extension FirebaseFunctionsExt on FirebaseFunctions {
  Future<void> enqueueTaskCreate({
    required String taskID,
    required String question,
  }) async {
    // {
    //   "question": "",
    //   "userRequest": {
    //       "userID": "",
    //   }
    // }
    final result = await httpsCallable('enqueueTaskCreate').call(
      {
        'taskID': taskID,
        'question': question,
        'userRequest': {
          'userID': FirebaseAuth.instance.currentUser?.uid,
        },
      },
    );

    final response = mapToJSON(result.data);
    if (response['result'] != 'OK') {
      throw Exception(response['error']['message']);
    }
    return;
  }

  Future<void> fillLocation({
    required String taskID,
    required LocationFormInfo userLocation,
  }) async {
    final result = await httpsCallable('enqueueFillLocation').call(
      {
        'taskID': taskID,
        'userLocation': userLocation.toJson(),
        'userRequest': {
          'userID': FirebaseAuth.instance.currentUser?.uid,
        },
      },
    );
    final response = mapToJSON(result.data);
    debugPrint('enqueueFillLocation response: ${response.toString()}');
    if (response['result'] != 'OK') {
      throw Exception(response['error']['message']);
    }

    return;
  }
}

// Map<String, dynamic>.fromだけだとネストした子要素が_Map<Object? Object?>のままになる
// 以下のエラーを回避する _TypeError (type '_Map<Object?, Object?>' is not a subtype of type 'Map<String, dynamic>' in type cast)
Map<String, dynamic> mapToJSON(Map<dynamic, dynamic> map) {
  for (var key in map.keys) {
    if (map[key] is Map) {
      map[key] = mapToJSON(map[key]);
    } else if (map[key] is List) {
      map[key] = map[key].map((e) {
        if (e is Map) {
          return mapToJSON(e);
        }
        return e;
      }).toList();
    }
  }
  return Map<String, dynamic>.from(map);
}
