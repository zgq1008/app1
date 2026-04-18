import 'package:flutter/material.dart';
class Toastutils {
  static void showToast(BuildContext context,String? msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg ?? '刷新成功',textAlign: TextAlign.center,),
        width: 120,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),//设置圆角
        ),//设置SnackBar的宽度和圆角
        behavior: SnackBarBehavior.floating,//设置SnackBar为浮动模式
        duration: Duration(seconds: 3),//设置SnackBar的持续时间
      ),
    );
  }
}