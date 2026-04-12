import 'package:app1/viewmodels/home.dart';
import 'package:carousel_slider/carousel_slider.dart';
//轮播图
//轮播图布局：上方搜索框 中间轮播图 下方导航条
//使用Stack布局 Positioned定位轮播图和导航条
//安装轮播图插件：flutter pub add carousel_slider
import 'package:flutter/material.dart';
class HmSlider extends StatefulWidget {
  final List<BannerItem> bannerList;
  const HmSlider ({super.key, required this.bannerList});

  @override
  State<HmSlider> createState() => _HmSliderState();
}
class _HmSliderState extends State<HmSlider> {
  CarouselSliderController _controller = CarouselSliderController();//轮播图控制器
  int _currentIndex = 0;//当前轮播图索引
  Widget _getSlider(){//轮播图组件
  //获取屏幕宽度
  final double screenWidth = MediaQuery.of(context).size.width;
    return CarouselSlider(
      carouselController: _controller,//传入控制器
      items: List.generate(widget.bannerList.length, (int index){
        return Image.network(widget.bannerList[index].imgUrl,
        fit: BoxFit.cover,
        width: screenWidth,
        );
      }),
     options: CarouselOptions(
      viewportFraction: 1,
      //自动播放 每隔3秒切换一次
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      onPageChanged: (index, reason) => setState(() => _currentIndex = index),//轮播图切换时更新当前索引
     ));
  }
  //搜索栏
  Widget _getSearch(){
    return Positioned(
      top:10,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.centerLeft,//搜索框内容左对齐
          padding: EdgeInsets.symmetric(horizontal: 40),//搜索框内边距
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.8),//半透明白色背景
            borderRadius: BorderRadius.circular(25),//圆角
          ),
          child: Row(children: [const Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 8),
          const Text('搜索', style: TextStyle(color: Colors.grey))
          ],),
        ),
      ),
    );
  }
  //导航条
  Widget _getNav(){
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,//导航条内容居中
        children: 
          List.generate(widget.bannerList.length, (int index){
            return GestureDetector(//点击导航点切换轮播图
              onTap: (){
                _controller.animateToPage(index);//点击导航点切换到对应的轮播图
                // _controller.jumpToPage(index);//立即跳转到对应的轮播图
              },
              child: AnimatedContainer(//导航点动画容器
                duration: Duration(milliseconds: 300),//动画持续时间
              height: 6,
              width:index == _currentIndex ? 40 : 20,//当前轮播图对应的导航点宽度为40 其他为20
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color:  _currentIndex == index ? Colors.white : Color.fromRGBO(0, 0, 0, 0.3),//当前轮播图对应的导航点为白色 其他为半透明黑色
                //当前轮播图对应的导航点为红色 其他为白色
                borderRadius: BorderRadius.circular(3),//圆角
              ),
            ),
             );
          })
        ,),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _getSlider(),
        _getSearch(),
        _getNav(),
      ],
    );
  }
}