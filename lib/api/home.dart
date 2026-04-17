import 'package:app1/constants/index.dart';
import 'package:app1/utils/DioRequest.dart';
import 'package:app1/viewmodels/home.dart';
import 'package:flutter/foundation.dart';


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
//爆款列表接口
Future<SpecilaRecommendResult> getInVogueRecommendAPI() async {
  return SpecilaRecommendResult.fromJson(await dioRequest.get(HttpConstants.IN_VOGUE_LIST));
}
//一站买全列表接口
Future<SpecilaRecommendResult> getOneStopRecommendAPI() async {
  return SpecilaRecommendResult.fromJson(await dioRequest.get(HttpConstants.ONE_STOP_LIST));
}
//推荐列表接口
Future<List<GoodDetailItem>> getRecommendListAPI(Map<String, dynamic> params) async {
  try {
    final dynamic result = await dioRequest.get(
      HttpConstants.RECOMMEND_LIST,
      params: params,
    );

    List<dynamic> rawList = [];

    // 兼容返回直接是数组
    if (result is List) {
      rawList = result;
    }

    // 兼容返回是对象，真正列表在 items/list/rows
    if (result is Map<String, dynamic>) {
      final dynamic items = result["items"] ?? result["list"] ?? result["rows"];
      if (items is List) {
        rawList = items;
      }
    }

    return rawList
        .whereType<Map<String, dynamic>>()
        .map((item) => GoodDetailItem.fromJson(item))
        .toList();
  } catch (e, s) {
    debugPrint("getRecommendListAPI error: $e");
    debugPrint("$s");
    return [];
  }
}