import 'package:flutter/material.dart';
import 'package:app1/pages/Home/index.dart';
import 'package:app1/pages/Category/index.dart';
import 'package:app1/pages/Cart/index.dart';
import 'package:app1/pages/Person/index.dart';
import 'package:get/get.dart';

import '../../api/user.dart';
import '../../stores/Tokenmanager.dart';
import '../../stores/UserController.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //底部导航栏 渲染4个导航：首页 分类 购物车 我的
  final List<Map<String, dynamic>> _tablist = [
    {"icon": Icons.home, "activeIcon": Icons.home_outlined, "label": "首页"},
    {"icon": Icons.category, "activeIcon": Icons.category_outlined, "label": "分类"},
    {"icon": Icons.shopping_cart, "activeIcon": Icons.shopping_cart_outlined, "label": "购物车"},
    {"icon": Icons.person, "activeIcon": Icons.person_outline, "label": "我的"},
  ];
  int _currentIndex = 0;//当前选中的导航项索引
  List<BottomNavigationBarItem> getBottomNavigationBarItemList() {
    return List.generate(_tablist.length, (index){
      return BottomNavigationBarItem(
        icon: Icon(_tablist[index]["icon"]),
        activeIcon: Icon(_tablist[index]["activeIcon"]),
        label: _tablist[index]["label"],
      );
    });
  }
  List<Widget> getTabWidgetList() {
    return [
      const HomeView(),
      const CategoryView(),
      const CartView(),
      const PersonView(),
    ];
  }
  //初始化用户
  @override
  void initState() {
    super.initState();
    _initUser();
  }
  final UserController _userController = Get.put(UserController()); //获取UserController实例 通过GetX实现全局状态管理 其他页面可以监听用户信息的变化并更新UI
  _initUser() async{
    await tokenManager.init();//初始化TokenManager 从磁盘获取token并赋值给内存
    //从磁盘获取token并赋值给内存
    if(tokenManager.getToken().isNotEmpty){
      //如果token不为空，说明用户已经登录过了，可以直接获取用户信息并更新到UserController中
      try{
        _userController.updateUser(await getUserProfile());//获取用户信息接口 获取用户信息成功后更新到UserController中 通过GetX实现全局状态管理 其他页面可以监听用户信息的变化并更新UI
      }catch(e){
        //如果获取用户信息失败了，说明token可能过期了或者无效了，可以删除token并让用户重新登录
        await tokenManager.removeToken();//删除token 从磁盘和内存中都删除
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(//安全区域，避免被刘海屏等遮挡
        child: IndexedStack(
          index: _currentIndex,
          children: //放置四个对应的组件
            getTabWidgetList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(//渲染底部导航栏
      selectedItemColor: Colors.black,//选中项的颜色
      unselectedItemColor: Colors.grey,//未选中项的颜色
      showUnselectedLabels: true,//显示未选中项的标签
      currentIndex: _currentIndex,//当前选中的导航项索引
        items: getBottomNavigationBarItemList(),//渲染底部导航栏的4个导航项
        onTap: (int index){
          setState(() {
            _currentIndex = index;//更新当前选中的导航项索引
          });
        },
      ),
    );
  }
}
