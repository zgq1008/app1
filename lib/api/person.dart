//封装猜你喜欢的接口函数
import 'package:app1/utils/DioRequest.dart';
import 'package:app1/viewmodels/home.dart';
import 'package:app1/constants/index.dart';

Future<GoodsDetailsItems> getGuessListAPI(Map<String, dynamic> params) async {
  final res = await dioRequest.get(HttpConstants.GUESS_LIST, params: params);
  return GoodsDetailsItems.fromJson(res);
}