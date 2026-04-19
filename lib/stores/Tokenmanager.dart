import 'package:app1/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  _getInstance() {
    return SharedPreferences.getInstance();
  }
  String _token="";
  //初始化
  init() async{
    //从磁盘获取token并赋值给内存
    final prefs = await _getInstance();
    _token = prefs.getString(GlobalConstants.TOKEN_KEY) ?? "";
  }
  //设置token
  Future<void> setToken(String val) async{
    //获取实例
    final prefs = await _getInstance();
    prefs.setString(GlobalConstants.TOKEN_KEY, val);
    _token=val;
  }
  //获取token 同步方法
 String getToken()  {
    return _token;
  }
  //删除token
  Future<void> removeToken() async {
    final prefs = await _getInstance();
    prefs.remove(GlobalConstants.TOKEN_KEY);//磁盘
    _token = "";//内存
  }
}
final tokenManager = TokenManager();