import 'dart:developer';
import 'dart:io';

import 'package:alisons_task/constents/api_const.dart';
import 'package:dio/dio.dart';

enum ApiMethod {
  get,
  post,
  delete,
  update,
}

class ApiService {
  static Map errorResponse = {};
  static Dio dio = Dio();
  static bool isDioErrorOccured = false;
  static bool isUpdationChecked = false;

  ///api method set up

  static Future<Response<dynamic>?> apiMethodSetup(
      {required ApiMethod method,
      required String url,
      var data,
      Function()? onPressed,
      bool isErrorShowing = true,
      bool isRemoveToken = false,
      isExceptionChecking = true,
      var queryParameters,
      Function(int, int)? onSendProgress,
      Function(int, int)? onRecieveProgress,
      Options? options}) async {
    log(options.toString());
    log(method.toString());
    dio.options.baseUrl = ApiConst.baseUrl;

    try {
      Response? response;
      switch (method) {
        case ApiMethod.get:
          if (data != null) {
            response = await dio.get(
              url,
              queryParameters: data,
              options: options ?? Options(),
            );
          } else {
            response = await dio.get(url,
                options: options ?? Options(),
                onReceiveProgress: onRecieveProgress);
          }
          break;
        case ApiMethod.post:
          response = await dio.post(url,
              data: data,
              queryParameters: queryParameters,
              onSendProgress: onSendProgress,
              onReceiveProgress: onRecieveProgress);
          break;
        case ApiMethod.delete:
          response = await dio.delete(url,
              data: data, queryParameters: queryParameters);
          break;
        case ApiMethod.update:
          response = await dio.put(url,
              data: data,
              queryParameters: queryParameters,
              onSendProgress: onSendProgress,
              onReceiveProgress: onRecieveProgress);
          break;
      }
      log(response.toString());
      return response;
    } on DioException catch (e) {
      if (!isDioErrorOccured && isErrorShowing) {
        isDioErrorOccured = true;
      }
      if (isExceptionChecking) {
        if (e.response?.statusCode == 401) {
          errorResponse["status"] = "401";
          errorResponse["message"] = "Authorization error";

          // await userLogOut().then((value) => SnackBarWidget.getSnackBar(
          //     showText: "Authentication expierd,login again",
          //     milliseconds: 3000));

          print(errorResponse);
        } else if (e.response?.statusCode == 404) {
          // SnackBarWidget.getSnackBar(
          //     showText: "Server Unreachable, try later");
          return e.response;
        } else if (e.response?.statusCode == 500) {
        } else if (e.type == DioExceptionType.receiveTimeout) {
          // SnackBarWidget.getSnackBar(showText: "Check your network speed");
        } else if (e.type == DioExceptionType.connectionTimeout) {
          // SnackBarWidget.getSnackBar(
          //     showText: "Server Unreachable, try later");
        } else if (e.error is SocketException) {
          errorResponse["status"] = "101";
          errorResponse["message"] = "internet error";
          if (errorResponse["status"] == "101") {
            log("responce ilness");
          }
          print(errorResponse);
        } else {
          // SnackBarWidget.getSnackBar(showText: TextConst.errorText);
          print(e.toString());
        }
      } else {
        return e.response;
      }

      return e.response;
    }
  }
}
