//封装一个登陆后的加载进度
import 'package:flutter/material.dart';

class LoadingDialog{
  static void show(BuildContext context,{String message = '加载中...'}){
    showDialog(context: context, builder: (context){
      return Dialog(
        backgroundColor: Colors.transparent,//背景透明
        child:Center(
          child:Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child:Column(
              mainAxisSize: MainAxisSize.min,//根据内容自动调整大小
              children: [
                CircularProgressIndicator(),//加载动画
                SizedBox(height: 10),
                Text(message),//提示信息
              ],
            ),
          ),
        ),
      );
    });
  }
  static void hide(BuildContext context){
    Navigator.pop(context);
  }
}