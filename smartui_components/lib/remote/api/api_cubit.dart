import 'dart:convert';
import 'dart:io';
import 'package:smartui_components/remote/api/api_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import '../../shared_pref/shared_preferences_service.dart';
import '../util/common.dart';
import '../util/string_file.dart';
import '../util/text_sanitizer.dart';
import 'api_constant.dart';
import 'app_exceptions.dart';
import 'base_response.dart';
import 'api_state.dart';

typedef LogoutCallback = void Function();

class ApiCubit extends Cubit<ApiState> {
  final SharedPreferencesService _sharedPrefRepository = SharedPreferencesService();
  final ApiConfig? config;

  ApiCubit({this.config}) : super(ApiState.initial());

  /// Common Header
  Future<Map<String, String>> _mGetApplicationHeader() async {
    String token = await _mCheckTokenExpired();
    Common().printLog('CheckApiToken', token);
    return {
      ApiConstant.acceptLanguage: 'en',
      ApiConstant.contentType: ApiConstant.applicationJson,
      if (token.isNotEmpty) ApiConstant.authorization: '${ApiConstant.bearer} $token',
    };
  }

  Future<String> _mCheckTokenExpired() async {
    String token = await _sharedPrefRepository.mGetUserToken();
    if (token.isNotEmpty) {
      DateTime expiryDate = JwtDecoder.getExpirationDate(token);
      Duration timeLeft = expiryDate.difference(DateTime.now());
      if (!JwtDecoder.isExpired(token) && timeLeft.inMinutes <= 3) {
        token = (await _refreshToken())!;
      }
      token = await _sharedPrefRepository.mGetUserToken();
    }
    return token;
  }

  Future<String?> _refreshToken() async {
    String token = await _sharedPrefRepository.mGetUserToken();
    final headers = {
      ApiConstant.contentType: ApiConstant.applicationJson,
      ApiConstant.authorization: '${ApiConstant.bearer} $token',
    };
    final response = await http
        .get(Uri.parse(config!.refreshTokenApi!), headers: headers)
        .timeout(const Duration(seconds: ApiConstant.requestTimeOut));

    if (response.statusCode == ApiConstant.successStatusCode && response.body.isNotEmpty) {
      BaseResponse<String> mTokenData = BaseResponse.fromJson(jsonDecode(response.body), (data) => data as String);
      if (mTokenData.mIsDataNotNull()) {
        await _sharedPrefRepository.mSaveUserToken(mTokenData.data!);
        return mTokenData.data!;
      }
    }
    return null;
  }

  /// Request
  Future<dynamic> _handleRequest(Future<http.Response> Function() request, String url) async {
    emit(ApiState.loading());
    try {
      final response = await request();
      final result = await _returnResponse(response, url);
      emit(ApiState.success(result));
      return result;
    } on SocketException {
      emit(ApiState.error(StringFile.noInternetError));
    } on AppExceptions catch (e) {
      emit(ApiState.error(e.toString()));
    } catch (e) {
      emit(ApiState.error(e.toString()));
    }
  }

  /// GET API
  Future<dynamic> getApi(String url) async {
    final headers = await _mGetApplicationHeader();
    return _handleRequest(
      () => http.get(Uri.parse(url), headers: headers).timeout(const Duration(seconds: ApiConstant.requestTimeOut)),
      url,
    );
  }

  /// POST API
  Future<dynamic> postApi(String url, dynamic data) async {
    final headers = await _mGetApplicationHeader();
    return _handleRequest(
      () => http
          .post(Uri.parse(url), headers: headers, body: jsonEncode(data))
          .timeout(const Duration(seconds: ApiConstant.requestTimeOut)),
      url,
    );
  }

  /// PUT API
  Future<dynamic> putApi(String url, dynamic data) async {
    final headers = await _mGetApplicationHeader();
    return _handleRequest(
      () => http
          .put(Uri.parse(url), headers: headers, body: jsonEncode(data))
          .timeout(const Duration(seconds: ApiConstant.requestTimeOut)),
      url,
    );
  }

  Future<dynamic> patchApi(String url, dynamic data) async {
    final headers = await _mGetApplicationHeader();
    return _handleRequest(
      () => http
          .patch(Uri.parse(url), headers: headers, body: jsonEncode(data))
          .timeout(const Duration(seconds: ApiConstant.requestTimeOut)),
      url,
    );
  }

  /// DELETE API
  Future<dynamic> deleteApi(String url, dynamic data) async {
    final headers = await _mGetApplicationHeader();
    return _handleRequest(
      () => http
          .delete(Uri.parse(url), headers: headers, body: jsonEncode(data))
          .timeout(const Duration(seconds: ApiConstant.requestTimeOut)),
      url,
    );
  }

  // ------------------------ MULTIPART UPLOAD ------------------------
  Future<dynamic> uploadMultipart(http.MultipartRequest request) async {
    emit(ApiState.loading());
    try {
      final headers = await _mGetApplicationHeader();
      request.headers.addAll(headers);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      final result = await _returnResponse(response, request.url.toString());
      emit(ApiState.success(result));
      return result;
    } catch (e) {
      emit(ApiState.error(e.toString()));
    }
  }

  /// Response Handler
  Future<dynamic> _returnResponse(http.Response response, String endPoint) async {
    Common().printLog('CheckResponseCode', '$endPoint -> ${response.statusCode}');
    String responseBody = '';

    try {
      responseBody = utf8.decode(response.bodyBytes);
    } catch (_) {
      responseBody = latin1.decode(response.bodyBytes, allowInvalid: true);
    }

    responseBody = TextSanitizer.clean(responseBody);
    dynamic data = {};
    String? message = '';
    String? extendedDetails = '';

    if (responseBody.isNotEmpty) {
      try {
        data = jsonDecode(responseBody);
      } catch (e) {
        data = {};
      }
    }

    if (data is Map) {
      if (data.containsKey(ApiConstant.extendedDetails) && data[ApiConstant.extendedDetails].isNotEmpty) {
        extendedDetails = data[ApiConstant.extendedDetails].entries
            .map((entry) => '${entry.key}: ${entry.value}')
            .join('\n');
      }
      if (data.containsKey(ApiConstant.message)) {
        message = data[ApiConstant.message];
      }
    }

    switch (response.statusCode) {
      case ApiConstant.successStatusCode:
        if (response.body.isEmpty) {
          return BaseResponse(
            status: ApiConstant.successStatusCode,
            timestamp: DateTime.now().toString(),
            message: message,
          );
        }
        return data;
      case ApiConstant.createdSuccessStatusCode:
        if (response.body.isEmpty) {
          return BaseResponse(
            status: ApiConstant.successStatusCode,
            timestamp: DateTime.now().toString(),
            message: message,
          );
        }
        return data;
      case ApiConstant.failedStatusCode:
        config!.errorDialog!(message!, extendedDetails!);
        return data;
      case ApiConstant.emailAlreadyExistCode:
        return BaseResponse(
          status: response.statusCode,
          timestamp: DateTime.now().toString(),
          message: StringFile.emailAlreadyExist,
        );
      case ApiConstant.tokenExpireCode:
        await Common().mLogOut();
        config!.onLogout!.call();
        emit(ApiState.error('Session expired. Please login again.'));
        break;
      default:
        config!.errorDialog!(message!, extendedDetails!);
        emit(ApiState.error(message));
        return null;
    }
  }
}
