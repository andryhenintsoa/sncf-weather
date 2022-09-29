import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../exception/main_exception.dart';
import '../service_locator.dart';
import 'authentification_service.dart';

class ApiClient {
  Dio get client {
    return Dio();
  }

  String get endpoint => dotenv.env['ENDPOINT'] ?? '';

  Future<Response> get(String url) async {
    try {
      var response = await client.get(
        url,
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader:
                'Bearer ${locator<AuthenticationService>().token ?? ''}',
          },
        ),
      );

      return response;
    } catch (e) {
      throw MainException.from(e);
    }
  }

  Future<Response> post(
    String url, {
    required Map<String, dynamic> body,
    bool useToken = true,
  }) async {
    try {
      return await client.post(
        url.toString(),
        data: body,
        options: Options(
          headers: useToken
              ? {
                  HttpHeaders.authorizationHeader:
                      'Bearer ${locator<AuthenticationService>().token ?? ''}',
                }
              : null,
        ),
      );
    } catch (e) {
     throw MainException.from(e);
    }
  }
}
