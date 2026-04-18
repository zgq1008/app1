import 'package:app1/utils/ToastUtils.dart';
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
      SliverToBoxAdapter(
        child: HmCategory(categoryList: categoryList),
      ), //分类组件 横向滚动
      //4第四步：在分类组件中使用获取到的分类数据渲染分类列表
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: HmSuggestion(specilaRecommendResult: _specilaRecommendResult),
      ), //特惠推荐组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: HmHot(result: _inVogueRecommendResult, type: "hot"),
              ), //爆款推荐组件
              SizedBox(width: 10),
              Expanded(
                child: HmHot(result: _oneStopRecommendResult, type: "oneStop"),
              ), //一站买全组件
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(recommendList: _recommendList), //无限滚动组件
    ];
  }

  //initState->buidl->下拉刷新组件
  @override
  void initState() {
    super.initState();
    // _getBannerList();
    // _getCategoryList(); //1第一步：在initState生命周期方法中调用获取分类数据的函数
    // _getSpecilaRecommend();
    // _getInVogueRecommend();
    // _getOneStopRecommend();
    // _getRecommendList();
    _registerEvent();
    Future.microtask(() {
      //在页面加载完成后自动调用下拉刷新函数，获取数据并刷新页面
      _paddingTop = 100; //设置顶部内边距，提升用户体验
      setState(() {});
      _key.currentState?.show();
    });
  }

  //获取轮播图数据
  Future<void> _getBannerList() async {
    //调用api获取轮播图数据
    bannerList = await homeApi.getBannerListAPI();
  }

  //获取分类数据
  //2第二步：定义一个获取分类数据的函数，调用封装好的api接口函数获取数据，并更新状态
  Future<void> _getCategoryList() async {
    //调用api获取分类数据
    categoryList = await homeApi.getCategoryListAPI();
  }

  //获取特惠推荐数据
  Future<void> _getSpecilaRecommend() async {
    _specilaRecommendResult = await homeApi.getSpecilaRecommendAPI();
  }

  //获取爆款推荐数据
  Future<void> _getInVogueRecommend() async {
    _inVogueRecommendResult = await homeApi.getInVogueRecommendAPI();
  }

  //获取一站买全数据
  Future<void> _getOneStopRecommend() async {
    _oneStopRecommendResult = await homeApi.getOneStopRecommendAPI();
  }

  //页码
  int _page = 1;
  bool _isLoading = false; //是否正在加载数据 同时只能加载一个请求
  bool _hasMore = true; //是否有更多数据 是否还有下一页
  //获取推荐列表数据
  Future<void> _getRecommendList() async {
    try {
      if (_isLoading || !_hasMore) return; //如果正在加载数据或者没有更多数据了，就不再发送请求
      _isLoading = true; //设置正在加载数据
      int requestLimit = _page * 10; //每次请求的数据量，假设每页10条数据
      final list = await homeApi.getRecommendListAPI({
        "limit": requestLimit,
      }); //调用api获取推荐列表数据
      _isLoading = false; //请求完成，设置不再加载数据
      if (!mounted) return;
      setState(() {
        _recommendList = list;
      });
      _page++; //页码加1，为下一次请求做准备
      if (list.length < requestLimit) {
        _hasMore = false; //如果返回的数据量小于请求的数据量，说明没有更多数据了
        return;
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _recommendList = [];
      });
    }
  }

  //监听滚动到底部的事件
  void _registerEvent() {
    _Controller.addListener(() {
      //监听滚动事件
      if (_Controller.position.pixels >=
          (_Controller.position.maxScrollExtent - 50)) {
        //pixels当前滚动位置，maxScrollExtent最大滚动范围
        //滚动到底部了，加载更多数据
        _getRecommendList();
      }
    });
  }

  Future<void> _onRefresh() async {
    //下拉刷新函数
    //重置页码和状态
    _page = 1;
    _isLoading = false;
    _hasMore = true;
    //重新获取数据
    await _getBannerList();
    await _getCategoryList();
    await _getSpecilaRecommend();
    await _getInVogueRecommend();
    await _getOneStopRecommend();
    await _getRecommendList();
    //刷新完成，显示提示信息
    Toastutils.showToast(context, "刷新成功");
    _paddingTop = 0; //重置顶部内边距，提升用户体验
    setState(() {});
  }

  final ScrollController _Controller = ScrollController();

  final GlobalKey<RefreshIndicatorState> _key =
      GlobalKey<RefreshIndicatorState>();
double _paddingTop = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      //使用RefreshIndicator实现下拉刷新功能
      key: _key, //设置RefreshIndicator的key，方便在需要的时候调用刷新方法
      onRefresh: _onRefresh, //下拉刷新函数
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: _paddingTop), //设置顶部内边距，提升用户体验
        duration: Duration(milliseconds: 300),//设置动画持续时间，提升用户体验
        curve: Curves.easeInOut,//设置动画效果，提升用户体验
        child: CustomScrollView(
          controller: _Controller, //设置滚动控制器，监听滚动事件
          slivers: _getSlivers(), //获取滚动容器的内容
        ),
      ),
    );
  }
}
