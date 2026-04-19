//定义登录接口api
import 'package:app1/utils/DioRequest.dart';
import 'package:app1/viewmodels/person.dart';
import 'package:dio/dio.dart';
import 'package:app1/constants/index.dart';
Future<UserInfo> loginAPI(Map<String, dynamic> data) async{
  try{
    return UserInfo.fromJson(
      await dioRequest.post(HttpConstants.LOGIN, params: data),//post请求 登录接口地址 传递登录数据 包含账号和密码等信息 登录成功后接口会返回用户信息 包含token等字段 将返回的用户信息转换为UserInfo对象并返回
    );
  }catch(e){
    throw e;
  }
}
Future<UserInfo> getUserProfile() async{
  try{
    return UserInfo.fromJson(
      await dioRequest.get(HttpConstants.USER_PROFILE),
    );
  }catch(e){
    throw e;
  }
}