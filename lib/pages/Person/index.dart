import 'package:app1/api/person.dart';
import 'package:app1/viewmodels/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/Home/HmMoreList.dart';
import '../../components/Person/HmGuess.dart';
import '../../stores/Tokenmanager.dart';
import '../../stores/UserController.dart';
import '../../viewmodels/person.dart';

class PersonView extends StatefulWidget {
  const PersonView({super.key});

  @override
  State<PersonView> createState() => _PersonViewState();
}

class _PersonViewState extends State<PersonView> {
  final UserController _userController = Get.find();//put仅一次 find多次 获取UserController实例 通过GetX实现全局状态管理 其他页面可以监听用户信息的变化并更新UI
  //退出登录组件
  Widget _getLogout(){
    return _userController.user.value.id.isNotEmpty? Expanded(child: GestureDetector(//如果用户已登录显示退出登录按钮，否则不显示
      onTap: () {
        //弹出确认框 使用showDialog方法显示一个对话框，用户点击确认后调用_userController.logout()方法退出登录
        showDialog(
          context:context,
          builder:(context){
            return AlertDialog(title: Text('提示'),
            content:Text("确认退出登录吗？"),
            actions:[
              TextButton(onPressed: (){
                Navigator.pop(context);//关闭对话框
              }, child: Text('取消')),
              TextButton(onPressed: ()async{
                //清除用户信息
                await tokenManager.removeToken();
                _userController.updateUser(UserInfo.fromJson({}));;//更新用户信息为初始状态
                Navigator.pop(context);//关闭对话框
              }, child: Text('确认', style: TextStyle(color: Colors.red),)),
            ],
            );
          },
        );
      },
      child:Text('退出登录', style: TextStyle(fontSize: 14, color: Colors.red),
      textAlign: TextAlign.right,
      ),
    ))
    :Text("");
  }
  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0XFFFFF2EB), const Color(0XFFFDF6F1)],
        ),
      ),
      padding: const EdgeInsets.only(left: 20, right: 40, top: 80, bottom: 20),
      child: Row(
        children: [
          Obx((){
            return CircleAvatar(
            radius: 26,
            backgroundImage: _userController.user.value.id.isNotEmpty
                ? NetworkImage(_userController.user.value.avatar)//如果用户已登录显示用户头像，否则显示默认头像
            :const AssetImage('lib/assets/goods_avatar.png'),
            backgroundColor: Colors.white,
          );
          }),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx((){
                  //Obx中必须有一个被监听的变量，否则会报错
                  //监听用户数据的变化，如果用户已登录显示用户名，否则显示登录按钮
                  return GestureDetector(
                  onTap: () {
                    if (_userController.user.value.id.isEmpty) {
                      //当没有用户信息 点击跳转登录页
                    Navigator.pushNamed(context, '/login');
                    }
                  },
                  child:Text(
                    _userController.user.value.id.isNotEmpty
                        ? _userController.user.value.account
                        :'立即登录',//如果用户已登录显示用户名，否则显示登录按钮
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                );
                }),
              ],
            ),
          ),
          //如果用户已经登录 在右侧显示一个退出登录的按钮
        Obx((){
          return _getLogout();
        }),
        ],
      ),
    );
  }

Widget _buildVipCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 239, 197, 153),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Image.asset("lib/assets/ic_user_vip.png", width: 30, height: 30),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                '升级美荟商城会员，尊享无限免邮',
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(128, 44, 26, 1),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(126, 43, 26, 1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text('立即开通', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildQuickActions() {
    Widget item(String pic, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(pic, width: 30, height: 30, fit: BoxFit.cover),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            item("lib/assets/ic_user_collect.png", '我的收藏'),
            item("lib/assets/ic_user_history.png", '我的足迹'),
            item("lib/assets/ic_user_unevaluated.png", '我的客服'),
          ],
        ),
      ),
    );
  }
  Widget _buildOrderModule() {
    Widget orderItem(String pic, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(pic, width: 30, height: 30, fit: BoxFit.cover),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),

          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '我的订单',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  orderItem("lib/assets/ic_user_order.png", '全部订单'),
                  orderItem("lib/assets/ic_user_obligation.png", '待付款'),
                  orderItem("lib/assets/ic_user_unreceived.png", '待发货'),
                  orderItem("lib/assets/ic_user_unshipped.png", '待收货'),
                  orderItem("lib/assets/ic_user_unevaluated.png", '待评价'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  List<GoodDetailItem> _List = [];
  //分页的请求参数
  Map<String, dynamic> _params = {
    "page": 1,
    "pageSize": 10,
  };
  @override
  void initState() {
    super.initState();
    _getGuessList();
    _registerEvent();
  }
  void _registerEvent() {
    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 50) {
        // 接近底部，加载更多数据
        _getGuessList();
      }
    });
  }
  bool _isLoading = false; // 是否正在加载数据
  bool _hasMore = true; // 是否还有更多数据可加载
  void _getGuessList() async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    final result = await getGuessListAPI(_params);
    //_List = result.items;
    _List.addAll(result.items);// 追加数据
      _isLoading = false;
      setState(() {});
      _params['page'] += 1; // 增加页码
      if (_params['page'] >= result.pages) {
        _hasMore = false; // 没有更多数据了
        return;
      }
  }
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      slivers: [
        SliverToBoxAdapter(child: _buildHeader()),
        SliverToBoxAdapter(child: _buildVipCard()),
        SliverToBoxAdapter(child: _buildQuickActions()),
        SliverToBoxAdapter(child: _buildOrderModule()),
        // pinned 表示吸住的意思
        SliverPersistentHeader(delegate: HmGuess(), pinned: true),
        // 猜你喜欢
        HmMoreList(recommendList: _List), // 上拉加载
      ],
    );
  }
}
