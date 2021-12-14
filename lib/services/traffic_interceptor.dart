import 'package:dio/dio.dart';

const accessToken = 'pk.eyJ1Ijoia2xlcml0aCIsImEiOiJja3gzdGVoNmMxdjBpMnVxM251ejcwdXhpIn0.KvaIQqpWzyGy2Nt3C4QUgg';

class TrafficInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': accessToken
    });


    super.onRequest(options, handler);
  }


}
