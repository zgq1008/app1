//爆款推荐组件
import 'package:app1/viewmodels/home.dart';
import 'package:flutter/material.dart';

class HmSuggestion extends StatefulWidget {
  final SpecilaRecommendResult specilaRecommendResult;
  const HmSuggestion({super.key, required this.specilaRecommendResult});

  @override
  State<HmSuggestion> createState() => _HmSuggestionState();
}

class _HmSuggestionState extends State<HmSuggestion> {
  //数据 来源：HomeViewModel中的specilaRecommendResult
  //取前三条数据
  List<GoodsItem> _getDisplayData() {
    if(widget.specilaRecommendResult.subTypes.isEmpty ||
        widget.specilaRecommendResult.subTypes.first.goodsItems.items.isEmpty) {//如果没有数据，返回空列表
      return [];
    }
    return widget.specilaRecommendResult.subTypes.first.goodsItems.items
        .take(3)
        .toList();
  }

  //顶部内容
  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          "特惠推荐",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 86, 24, 20),
          ),
        ),
        SizedBox(width: 10),
        Text(
          "精选省攻略",
          style: TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 124, 31, 24),
          ),
        ),
      ],
    );
  }

  //中间左侧部分
  Widget _buildLeft() {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), //设置圆角
        image: DecorationImage(
          image: AssetImage("lib/assets/home_cmd_inner.png"), //背景图片
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  //中间右侧部分
  List<Widget> _buildRight() {
    List<GoodsItem> list = _getDisplayData();
    return List.generate(list.length, (int index) {
      return Expanded(
        child: Column(
        children: [
          //cLIPRRect:裁剪组件，裁剪成圆角矩形
          ClipRRect(
            borderRadius: BorderRadius.circular(10), //设置圆角
            child: Image.network(//网络图片
              errorBuilder: (context, error, stackTrace) {
                //如果图片加载失败，返回一个本地图片
                return Image.asset("lib/assets/home_cmd_inner.png", height: 140, fit: BoxFit.cover);
              },
              list[index].picture,
              //width: 100,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 240, 96, 12),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              "￥${list[index].price}",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        //添加内边距
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage("lib/assets/home_cmd_sm.png"), //背景图片
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            //顶部内容
            _buildHeader(),
            SizedBox(height: 10),
            //中间部分
            Row(
              children: [
                _buildLeft(),
                SizedBox(width: 10),
                Expanded(
                  child: Row(
                    spacing: 10,//设置子组件之间的间距
                    mainAxisAlignment: MainAxisAlignment.spaceAround, //平均分布
                    children: _buildRight(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
