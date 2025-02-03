import 'package:dio/dio.dart';
import 'package:todomaker/entity/task.dart';

const serviceURL = 'https://zennaihackathonbackend-985520941084.asia-northeast1.run.app';

class CloudRunClient {
  CloudRunClient({
    required this.dio,
  });
  final Dio dio;

  Future<Task> taskCreate({required String question}) async {
    try {
      final result = await dio.post(
        '$serviceURL/taskCreate',
        data: {
          'data': {
            'question': question,
          },
        },
      );
      final response = mapToJSON(result.data);
      if (response['result'] != 'OK') {
        throw Exception(response['error']['message']);
      }
      return Task.fromJson(response['data']['task']);
    } on DioException catch (e) {
      throw Exception('Failed to generate image: ${e.message}');
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
