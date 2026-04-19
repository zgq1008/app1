import 'package:flutter/material.dart';
class Toastutils {
  //阀门控制
  static bool _isShowing = false;
  static void showToast(BuildContext context,String? msg) {
    if (_isShowing) {
      return;
    }
    _isShowing = true;
    Future.delayed(Duration(seconds: 3), () {
      _isShowing = false;
    }); //3秒后重置阀门
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg ?? '刷新成功',textAlign: TextAlign.center,),
        width: 180,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),//设置圆角
        ),//设置SnackBar的宽度和圆角
        behavior: SnackBarBehavior.floating,//设置SnackBar为浮动模式
        duration: Duration(seconds: 3),//设置SnackBar的持续时间
      ),
    );
  }
}