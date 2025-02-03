import 'package:dio/dio.dart';

class ContentTypeInterceptor extends Interceptor {
  static const contentTypeKey = 'contentTypeKey';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final contentType = options.extra[contentTypeKey];
    if (contentType == null) {
      return super.onRequest(options, handler);
    }

    options.headers.addAll({'Content-Type': contentType});
    super.onRequest(options, handler);
  }
}
