import 'package:app1/viewmodels/home.dart';
import 'package:flutter/material.dart';
class HmMoreList extends StatefulWidget {
  // 推荐列表
  final List<GoodDetailItem> recommendList;

  HmMoreList({Key? key, required this.recommendList}) : super(key: key);

  @override
  _HmMoreListState createState() => _HmMoreListState();
}

class _HmMoreListState extends State<HmMoreList> {
  Widget _getChildren(int index) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 1,//保持图片为正方形 宽高比组件
              child: Image.network(
                widget.recommendList[index].picture,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "lib/assets/home_cmd_inner.png",
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 6),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              widget.recommendList[index].name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          SizedBox(height: 6),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "¥${widget.recommendList[index].price}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                    // children: [
                    //   TextSpan(text: " "),
                    //   TextSpan(
                    //     text: "${widget.recommendList[index].price}",
                    //     style: TextStyle(
                    //       decoration: TextDecoration.lineThrough,
                    //       color: Colors.grey,
                    //       fontSize: 12,
                    //     ),
                    //   ),
                    // ],
                  ),
                ),
                Text(
                  "${widget.recommendList[index].payCount}人付款",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

@override
Widget build(BuildContext context) {
  if (widget.recommendList.isEmpty) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: Text(
            "暂无推荐商品",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
      ),
    );
  }

  return SliverGrid.builder(
    itemCount: widget.recommendList.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 0.7,
    ),
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: _getChildren(index),
      );
    },
  );
}
}