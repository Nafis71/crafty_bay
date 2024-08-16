import 'dart:convert';

import 'package:crafty_bay/common/services/response/failure.dart';
import 'package:crafty_bay/common/services/response/success.dart';
import 'package:crafty_bay/utils/app_strings.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class ApiRequest {
  Object? _finalResponse;

  Future<Object> getRequest(
      {required String url, Map<String, String>? headers}) async {
    try {
      Response response = await get(Uri.parse(url), headers: headers);
      _finalResponse = getResponse(response);
      return _finalResponse!;
    } on ClientException {
      _finalResponse =
          Failure(statusCode: 601, errorMessage: AppStrings.networkError);
    } catch (exception) {
      if (kDebugMode) {
        _finalResponse =
            Failure(statusCode: 600, errorMessage: AppStrings.unknownError);
        debugPrint(exception.toString());
      }
    }
    return _finalResponse!;
  }

  Future<Object> postRequest(
      {required String url,
      Map<String, String>? headers,
      required Map<String, dynamic> body}) async {
    try {
      Response response = await post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );
      _finalResponse = getResponse(response);
      return _finalResponse!;
    } on ClientException {
      _finalResponse =
          Failure(statusCode: 601, errorMessage: AppStrings.networkError);
    } catch (exception) {
      if (kDebugMode) {
        _finalResponse =
            Failure(statusCode: 600, errorMessage: AppStrings.unknownError);
        debugPrint(exception.toString());
      }
    }
    return _finalResponse!;
  }

  Object getResponse(Response response) {
    if (response.statusCode == 200) {
      return Success(
          response: jsonDecode(response.body), statusCode: response.statusCode);
    }
    return Failure(
        statusCode: response.statusCode, response: jsonDecode(response.body));
  }
}
