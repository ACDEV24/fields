import 'package:dio/dio.dart';
import 'package:fields/app/utils/log.dart';
import 'package:fields/app/utils/toasts.dart';

class ErrorsInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    AppLogger.error(err, err.stackTrace);

    if (err.response != null) {
      switch (err.response?.statusCode) {
        case 401:
          WalletMessages.showError(err.response!.data['message']);
          break;
        case 403:
          break;
        case 422:
          WalletMessages.showError(err.response!.data['message']);
          break;
        case 500:
          break;
        default:
          break;
      }
    }
    return super.onError(err, handler);
  }
}
