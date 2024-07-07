import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ibaji/provider/api/login_api.dart';
import 'package:ibaji/provider/storage/get_storage_util.dart';
import '../../../util/routes/routes.dart';
import '../../../util/style/global_logger.dart';

class CustomDioInterceptor extends Interceptor {
  // 1) 요청 보낼때
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i("[REQ] ${options.method} Url ${options.uri} ");
    String header = "";
    options.headers.forEach((key, value) {
      header += '$key:$value\n';
    });
    logger.i("[Header] ${header} ");

    String queryParam = "";
    options.queryParameters.forEach((key, value) {
      queryParam += '$key : $value\n';
    });
    logger.i(queryParam);

    logger.i("Data ${options.data} >>");
    options.connectTimeout != null
        ? ((timeout) => logger.e("Connect Timeout $timeout"))
        : null;
    options.receiveTimeout != null
        ? ((timeout) => logger.e("Receive Timeout $timeout"))
        : null;
    options.sendTimeout != null
        ? ((timeout) => logger.e("Send Timeout $timeout"))
        : null;
    return super.onRequest(options, handler);
  }

  // 2) 응답을 받을때
  @override
  void onResponse( response, ResponseInterceptorHandler handler) {
    logger.i(
        "<< [RESPONSE ${response.statusCode}] Url: ${response.requestOptions.uri} >>");
    logger.i("${response.statusMessage}");
    logger.i("${response.requestOptions.data}");

    logger.i("Connect Timeout ${response.requestOptions.connectTimeout}");
    logger.i("Send Timeout ${response.requestOptions.sendTimeout}");
    logger.i("Receive Timeout ${response.requestOptions.receiveTimeout}");
    return super.onResponse(response, handler);
  }

  // 3) 에러가 났을때
  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    logger.e("Error ${err.error}");
    logger.e("Error Message ${err.message}");

    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout ||
        err.error == DioExceptionType.connectionError) {
      Fluttertoast.showToast(msg: "api가 작동하지 않습니다(추후 에러메세지 수정예정)");
    }
    //TODO: 서버팀 확인필요
    if (err.response?.statusCode == 401) {
      var refreshToken =
          await GetStorageUtil.getToken(StorageKey.REFRESH_TOKEN);
      // handler.resolve(err.response);와 같이 요청을 저장 및 중단후, 다시 요청하는 로직 추가

      refreshToken != null
          ? await LoginApi.getNewToken(refreshToken)
          : Get.offAllNamed(Routes.login);
    }
    return super.onError(err, handler);
  }
}
