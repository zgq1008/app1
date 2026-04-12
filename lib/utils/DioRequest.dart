//基于Dio进行二次封装
import 'package:app1/constants/index.dart';
import 'package:dio/dio.dart';

class DioRequest {
  final _dio = Dio();
  //基础地址拦截器
  DioRequest(){
    _dio.options
      ..baseUrl=GlobalConstants.BASE_URL
      ..connectTimeout=Duration(seconds: GlobalConstants.TIME_OUT)
      ..sendTimeout=Duration(seconds: GlobalConstants.TIME_OUT)
      ..receiveTimeout=Duration(seconds: GlobalConstants.TIME_OUT);
      //请求拦截器
    _addInterceptor();
  }
  void _addInterceptor(){
    _dio.interceptors.add(InterceptorsWrapper(//请求拦截器
      onRequest: (request, handler) {
        handler.next(request);
      },
      onResponse: (response, handler) {
        //http状态码为200-300时，认为请求成功，其他状态码认为请求失败
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
            handler.next(response);
            return;
        } else {
          handler.reject(DioException(requestOptions: response.requestOptions));
        }
      },
      onError: (error, handler) {
        handler.reject(error);
      },
    ));
  }

  Future<dynamic> get(String url,{Map<String, dynamic>? params}) async {
    try {
      return _handleResponse(_dio.get(url, queryParameters: params));
    } on DioException catch (e) {
      throw e;
    }
  }
  //进一步处理接口请求结果，统一处理接口返回的状态码和数据格式
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async{
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>;
      if (data["code"] == GlobalConstants.SUCCESS_CODE) {
        //http状态和业务状态均成功时，返回接口数据中的result字段
        return data["result"];
      } else {
        throw Exception(data["masg"]?? "请求失败");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

//单例对象
final dioRequest = DioRequest();