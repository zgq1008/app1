import 'package:flutter/material.dart';
import '../../components/Home/HmCategory.dart';
import '../../components/Home/HmHot.dart';
import '../../components/Home/HmMoreList.dart';
import '../../components/Home/HmSuggestion.dart';
import '../../components/Home/HmSlider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

//首页布局
//内容:轮播图 分类（横向滚动） 推荐（瀑布流） 无限滚动
class _HomeViewState extends State<HomeView> {
  //获取滚动容器的内容
  List<Widget> _getSlivers() {
    return [
      //使用SliverToBoxAdapter将普通组件转换为Sliver组件
      SliverToBoxAdapter(child: const HmSlider()),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: const HmCategory()), //分类组件 横向滚动
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: const HmSuggestion()),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: HmHot()),
              SizedBox(width: 10),
              Expanded(child: HmHot()),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(), //无限滚动组件
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      //使用CustomScrollView实现滚动效果
      slivers: _getSlivers(),
    );
  }
}
