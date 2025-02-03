import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthorizationRequestInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    options.headers['Authorization'] = 'Bearer $accessToken';
    super.onRequest(options, handler);
  }
}
