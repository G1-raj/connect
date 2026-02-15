import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://127.0.0.1:8000",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        "Content-Type": "application/json",
      },
    )
  );

  static final _storage = const FlutterSecureStorage();

  static void setupInterceptor() {

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.read(key: "access_token");

          if(token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },

        onError: (error, handler) async {
          if(error.response?.statusCode == 401) {
            final refresh = await _storage.read(key: "refresh_token");

            if(refresh == null) {
              return handler.next(error);
            }

            try {

              final res = await dio.post(
                "/auth/refresh-token",
                options: Options(
                  headers: {
                    "Authorization": "Bearer $refresh"
                  }
                )
              );

              final newAccess = res.data["access_token"];
              final newRefresh = res.data["refresh_token"];

              await _storage.write(key: "access_token", value: newAccess);
              await _storage.write(key: "refresh_token", value: newRefresh);

              final retry = await dio.fetch(
                error.requestOptions
                  ..headers["Authorization"] = "Bearer $newAccess",
              );

              return handler.resolve(retry);
              
            } catch (e) {
              return handler.next(error);
            }
          }
        }
      )
    );

  }
}



