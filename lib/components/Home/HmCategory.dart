//分类组件
import 'package:flutter/material.dart';
class HmCategory extends StatefulWidget {
  const HmCategory({super.key});

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
        itemCount: 10,itemBuilder: (BuildContext context, int index){
        return Container(
          alignment: Alignment.center,
          width: 80,
          height: 80,
          color: Colors.blue,
          margin: const EdgeInsets.only(right: 10),
          child: const Center(child: Text("分类组件"),),
        );
      }
      ),
    );
  }
}