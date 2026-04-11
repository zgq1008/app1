import 'package:flutter/material.dart';
import 'package:app1/pages/Home/index.dart';
import 'package:app1/pages/Category/index.dart';
import 'package:app1/pages/Cart/index.dart';
import 'package:app1/pages/Person/index.dart';
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
