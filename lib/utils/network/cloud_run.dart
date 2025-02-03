import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:todomaker/entity/task.dart';
import 'package:todomaker/utils/network/interceptors/authorization_request.dart';
import 'package:todomaker/utils/network/interceptors/content_type.dart';

class CloudRunClient {
  CloudRunClient._({required this.baseURL}) {
    _dio = Dio();
    _dio.options
      ..baseUrl = baseURL
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 30);

    _dio.interceptors.add(AuthorizationRequestInterceptor());
    _dio.interceptors.add(ContentTypeInterceptor());
  }
  final String baseURL;
  late final Dio _dio;

  static final CloudRunClient _instance = () {
    if (kDebugMode) {
      return CloudRunClient._(
        baseURL: 'http://localhost:3400',
      );
    } else {
      return CloudRunClient._(
        // TODO: ハッカソンが終わってストアに出すことがあればenvにしよう
        // baseURL: const String.fromEnvironment('cloudRunServiceBaseURL'),
        baseURL: 'https://zennaihackathonbackend-985520941084.asia-northeast1.run.app',
      );
    }
  }();

  static CloudRunClient get instance => _instance;

  Future<Task> taskCreate({required String question}) async {
    try {
      // {
      //   "question": "",
      //   "userRequest": {
      //       "userID": "",
      //   }
      // }
      final result = await _dio.post(
        '$baseURL/taskCreate',
        data: {
          'data': {
            'question': question,
            'userRequest': {
              'userID': FirebaseAuth.instance.currentUser?.uid,
            },
          },
        },
      );
      // resultはGenKitのレスポンス構造
      final response = mapToJSON(result.data)['result'];

      if (response['result'] != 'OK') {
        throw Exception(response['error']['message']);
      }
      return Task.fromJson(response['data']['task']);
    } on DioException catch (e) {
      throw Exception('Failed to create task: ${e.message}');
    }
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
