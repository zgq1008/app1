import 'package:flutter/material.dart';
class HmMoreList extends StatefulWidget {
  const HmMoreList({super.key});

  @override
  State<HmMoreList> createState() => _HmMoreListState();
}
class _HmMoreListState extends State<HmMoreList> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(//网格布局
        crossAxisCount: 2,//每行2个
        mainAxisSpacing: 10,//主轴间距
        crossAxisSpacing: 10,//交叉轴间距
      ), //每行2个
      itemBuilder: (BuildContext context,int index){
        return Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: Text("更多列表",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        );
      },
      itemCount: 10,);
  }
}