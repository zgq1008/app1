import 'package:app1/constants/index.dart';
import 'package:app1/utils/DioRequest.dart';
import 'package:app1/viewmodels/home.dart';


//封装一个api 返回业务侧要的数据结构
Future<List<BannerItem>> getBannerListAPI() async {
  //返回请求
  return ((await dioRequest.get(HttpConstants.BANNER_LIST)) as List).map((item){
    return BannerItem.fromJson(item as Map<String, dynamic>);
  }).toList();
}