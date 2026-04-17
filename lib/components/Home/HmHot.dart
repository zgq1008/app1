//爆款
import 'package:app1/viewmodels/home.dart';
import 'package:flutter/material.dart';
class HmHot extends StatefulWidget {
  ///爆款推荐组件
  final SpecilaRecommendResult result;
  //类型
  final String type;
  //一站式推荐组件
  const HmHot({super.key, required this.result, required this.type});

  @override
  State<HmHot> createState() => _HmHotState();
}
class _HmHotState extends State<HmHot> {
  //获取前两条数据
  List<GoodsItem> get _items {
    //getter方法：在访问属性时会自动调用该方法，返回计算后的值
    if (widget.result.subTypes.isEmpty) {
      return [];
    }
      return widget.result.subTypes.first.goodsItems.items.take(2).toList();
  }
  //创建子项
 // 构建子项
  List<Widget> _getChildrenList() {
    return _items.map((item) {
      return Expanded(
        child: Container(
          // width: 80,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(//使用ClipRRect组件实现图片圆角效果
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.picture,
                  // width: 80,
                  fit: BoxFit.cover,
                  height: 100,
                  errorBuilder: (context, error, stackTrace) {//图片加载失败时显示占位图
                    return Image.asset(
                      "lib/assets/home_cmd_inner.png",
                      // width: 80,
                      fit: BoxFit.cover,
                      height: 100,
                    );
                  },
                ),
              ),
              SizedBox(height: 5),
              Text(
                "¥${item.price}",
                style: TextStyle(
                  fontSize: 12,
                  color: const Color.fromARGB(255, 86, 24, 20),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
 Widget _buildHeader() {
    return Row(
      children: [
        Text(
          widget.type == "step" ? "一站买全" : "爆款推荐",//根据类型显示不同的文本
          style: TextStyle(
            color: const Color.fromARGB(255, 86, 24, 20),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 10),
        Text(
          widget.type == "step" ? "精心优选" : "最受欢迎",//根据类型显示不同的文本
          style: TextStyle(
            fontSize: 12,
            color: const Color.fromARGB(255, 124, 63, 58),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: widget.type == "step"
              ? const Color.fromARGB(255, 249, 247, 219)
              : const Color.fromARGB(255, 211, 228, 240),
        ),
        child: Column(
          children: [
            // 顶部内容
            _buildHeader(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _getChildrenList(),
            ),
          ],
        ),
      ),
    );
  }
}