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
//第三步：封装一个获取分类列表的接口函数
Future<List<CategoryItem>> getCategoryListAPI() async {
  return ((await dioRequest.get(HttpConstants.CATEGORY_LIST)) as List).map((item){
    return CategoryItem.fromJson(item as Map<String, dynamic>);
  }).toList();
}
//特惠列表接口
Future<SpecilaRecommendResult> getSpecilaRecommendAPI() async {//SpecilaRecommendResult本身就是一个数据结构，直接返回就行了，不需要再map了
  return SpecilaRecommendResult.fromJson(await dioRequest.get(HttpConstants.PRODUCT_LIST));
}