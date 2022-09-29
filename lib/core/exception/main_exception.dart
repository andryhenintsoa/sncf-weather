import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class MainException implements Exception {
  late final String message;

  MainException(this.message);

  MainException.from(dynamic e) {
    if (e is DioError) {
      if (e.response?.data?["message"] != null) {
        message = e.response!.data!["message"]!;
      } else if (e.response?.statusMessage != null) {
        message = e.response!.statusMessage!;
      } else if (e.type == DioErrorType.other && e.error != null) {
        if (e.error is SocketException) {
          debugPrint('${e.error}');
          message = "Erreur de connexion";
        } else {
          message = e.error;
        }
      } else {
        message = e.message;
      }

      // print(e.response);
    } else {
      debugPrint('Unhandled Error : $e');
      message = "Une erreur s'est produite";
    }
  }
}
