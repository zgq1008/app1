//管理路由
import 'package:app1/pages/Main/index.dart';
import 'package:app1/pages/Login/index.dart';
import 'package:flutter/material.dart';

Widget getRouteWidget(){
  return MaterialApp(
    initialRoute: "/",//默认首页
    routes: getRouteMap(),
  );
}
Map<String,Widget Function(BuildContext)> getRouteMap(){
  return {
    "/":(context)=>const HomePage(),//主页
    "/login":(context)=>const LoginPage(),//登录页
  };
}
