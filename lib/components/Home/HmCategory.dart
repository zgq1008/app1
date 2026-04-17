//分类组件
import 'package:app1/viewmodels/home.dart';
import 'package:flutter/material.dart';
class HmCategory extends StatefulWidget {
  //第五步：在分类组件中定义一个接收分类列表数据的参数，并在组件中使用该参数渲染分类列表
  final List<CategoryItem> categoryList;//分类列表数据
  const HmCategory({super.key, required this.categoryList});

  @override
  State<HmCategory> createState() => _HmCategoryState();
}
class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child:ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categoryList.length,
        itemBuilder: (BuildContext context, int index) {
          final category = widget.categoryList[index];
          return Container(
            alignment: Alignment.center,
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              color:const Color.fromARGB(255, 231, 232, 234),//半透明黑色背景
              borderRadius: BorderRadius.circular(40),//圆角
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Image.network(category.picture, width: 40, height: 40),
                Text(category.name, style: TextStyle(color: Colors.white)),
              ],
            ),
          );
        }
      ),
    );
  }
}