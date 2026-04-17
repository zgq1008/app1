import 'package:app1/viewmodels/home.dart';
import 'package:flutter/material.dart';
import '../../components/Home/HmCategory.dart';
import '../../components/Home/HmHot.dart';
import '../../components/Home/HmMoreList.dart';
import '../../components/Home/HmSuggestion.dart';
import '../../components/Home/HmSlider.dart';
import 'package:app1/api/home.dart' as homeApi;
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

//首页布局
//内容:轮播图 分类（横向滚动） 推荐（瀑布流） 无限滚动
class _HomeViewState extends State<HomeView> {
  //模拟数据
  List<BannerItem> bannerList = [
    // BannerItem(id: '1', imgUrl: 'https://picsum.photos/id/1018/1200/500'),
    // BannerItem(id: '2', imgUrl: 'https://picsum.photos/id/1016/1200/500'),
    // BannerItem(id: '3', imgUrl: 'https://picsum.photos/id/1043/1200/500'),

  ];
  //分类数据
  //3第三步：定义一个分类列表变量，用于存储获取到的分类数据，并在组件中使用该变量渲染分类组件
  List<CategoryItem> categoryList = [];
  //特惠推荐
SpecilaRecommendResult _specilaRecommendResult = SpecilaRecommendResult(
  id: "",
  title: "",
  subTypes: [],
);
//爆款推荐
SpecilaRecommendResult _inVogueRecommendResult = SpecilaRecommendResult(
  id: "",
  title: "",
  subTypes: [],
);
//一站买全
SpecilaRecommendResult _oneStopRecommendResult = SpecilaRecommendResult(
  id: "",
  title: "",
  subTypes: [],
);
//推荐列表
List<GoodDetailItem> _recommendList = [];
  //获取滚动容器的内容
  List<Widget> _getSlivers() {
    return [
      //使用SliverToBoxAdapter将普通组件转换为Sliver组件
      SliverToBoxAdapter(child: HmSlider(bannerList: bannerList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmCategory(categoryList: categoryList)), //分类组件 横向滚动
      //4第四步：在分类组件中使用获取到的分类数据渲染分类列表
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmSuggestion(specilaRecommendResult: _specilaRecommendResult,)), //特惠推荐组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: HmHot(result: _inVogueRecommendResult,type:"hot")), //爆款推荐组件
              SizedBox(width: 10),
              Expanded(child: HmHot(result: _oneStopRecommendResult,type:"oneStop")), //一站买全组件
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)), 
      HmMoreList(recommendList: _recommendList), //无限滚动组件
    ];
  }

  @override
  void initState() {
    super.initState();
    _getBannerList();
    _getCategoryList();//1第一步：在initState生命周期方法中调用获取分类数据的函数
    _getSpecilaRecommend();
    _getInVogueRecommend();
    _getOneStopRecommend();
    _getRecommendList();
  }
  //获取轮播图数据
  void _getBannerList() async {
    //调用api获取轮播图数据
    bannerList= await homeApi.getBannerListAPI();
    setState(() {});//更新状态，重新渲染页面
  }

  //获取分类数据
  //2第二步：定义一个获取分类数据的函数，调用封装好的api接口函数获取数据，并更新状态
  void _getCategoryList() async {
    //调用api获取分类数据
    categoryList = await homeApi.getCategoryListAPI();
    setState(() {});//更新状态，重新渲染页面
  }

  //获取特惠推荐数据
  void _getSpecilaRecommend() async {
    _specilaRecommendResult = await homeApi.getSpecilaRecommendAPI();
    setState(() {});
  }
  //获取爆款推荐数据
  void _getInVogueRecommend() async {
    _inVogueRecommendResult = await homeApi.getInVogueRecommendAPI();
    setState(() {});
  }
  //获取一站买全数据
  void _getOneStopRecommend() async {
    _oneStopRecommendResult = await homeApi.getOneStopRecommendAPI();
    setState(() {});
  }
//获取推荐列表数据
  void _getRecommendList() async {
  try {
    final list = await homeApi.getRecommendListAPI({"limit": 10});
    if (!mounted) return;
    setState(() {
      _recommendList = list;
    });
  } catch (e) {
    if (!mounted) return;
    setState(() {
      _recommendList = [];
    });
  }
}
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      //使用CustomScrollView实现滚动效果
      slivers: _getSlivers(),
    );
  }
}
