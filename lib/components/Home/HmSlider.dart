//轮播图
import 'package:flutter/material.dart';
class HmSlider extends StatefulWidget {
  const HmSlider ({super.key});

  @override
  State<HmSlider> createState() => _HmSliderState();
}
class _HmSliderState extends State<HmSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.blue,
      child: const Center(child: Text("轮播图组件"),),
    );
  }
}