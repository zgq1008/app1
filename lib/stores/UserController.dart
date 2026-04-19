//共享用户数据
import 'package:app1/viewmodels/person.dart';
import 'package:get/get.dart';
//GetX用法：
//1.安装GetX包
//2.创建一个控制器类，继承GetxController
//定义需要共享的数据
class UserController extends GetxController {
  //3.定义需要共享的数据 数据需要响应式更新 并且以.obs结尾
  var user=UserInfo.fromJson({}).obs;//user是一个可观察对象，初始值为一个空的UserInfo对象 被监听
  //通过user.value来访问和修改user对象的属性
  //提供更新方法
  updateUser(UserInfo newUser) {
    user.value = newUser; //更新user对象的值，触发监听
  }
}