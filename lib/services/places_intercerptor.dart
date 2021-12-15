import 'package:dio/dio.dart';


class PlacesInterceptor extends Interceptor {
  
  final accessToken = 'pk.eyJ1Ijoia2xlcml0aCIsImEiOiJja3gzdGVoNmMxdjBpMnVxM251ejcwdXhpIn0.KvaIQqpWzyGy2Nt3C4QUgg';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    options.queryParameters.addAll({
      'access_token': accessToken,
      'language': 'es',
    });


    super.onRequest(options, handler);
  }

}
