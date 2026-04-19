import 'package:app1/api/user.dart';
import 'package:app1/stores/Tokenmanager.dart';
import 'package:app1/utils/ToastUtils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../stores/UserController.dart';
import '../../utils/LoadingDialog.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>{
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final UserController _userController = Get.find();//获取UserController实例 通过GetX实现全局状态管理 其他页面可以监听用户信息的变化并更新UI
  //用户账号Widget
  @override
  Widget _buildUsernameTextField() {
    return TextFormField(//文本输入框
       validator:(value){//表单验证函数
        if(value==null || value.isEmpty){
          return "账号不能为空";//返回错误提示 提示错误信息出现在输入框下方
        }
        //校验手机号格式 使用正则表达式
        if( !RegExp(r"^1[3-9]\d{9}$").hasMatch(value) ){//1开头 第二位3-9 其他9位数字
          return "请输入正确的手机号";
        }
        return null;
       },//表单验证函数
      controller: _usernameController,
      decoration: InputDecoration(//输入框装饰
        contentPadding: EdgeInsets.only(left: 10),//输入框内边距
        hintText: '请输入账号',
        fillColor: const Color.fromRGBO(243, 243, 243, 1),//输入框背景颜色
        filled: true,//是否填充背景颜色
        border: OutlineInputBorder(//输入框边框
          borderRadius: BorderRadius.circular(25),//输入框圆角
          borderSide: BorderSide.none,//输入框边框颜色
        ),
      ),
    );
  }

//用户密码Widget
Widget _buildPasswordTextField() {
  return TextFormField(
    validator:(value){//表单验证函数
        if(value==null || value.isEmpty){
          return "密码不能为空";//返回错误提示 提示错误信息出现在输入框下方
        }
        //密码为6-16位的字母 数字 下划线组合
        if(!RegExp(r"^[a-zA-Z0-9_]{6,16}$").hasMatch(value)){
          return "请输入6-16位的密码";
        }
        return null;
       },//表单验证函数
    controller: _passwordController,
    obscureText: true,//是否隐藏输入内容
    decoration: InputDecoration(
      contentPadding: EdgeInsets.only(left: 10),//输入框内边距
      hintText: '请输入密码',
      fillColor: const Color.fromRGBO(243, 243, 243, 1),//输入框背景颜色
      filled: true,//是否填充背景颜色
      border: OutlineInputBorder(//输入框边框
        borderRadius: BorderRadius.circular(25),//输入框圆角
        borderSide: BorderSide.none,//输入框边框颜色
      ),
    ),
  );
}
_login() async{
  //调用登录接口
  try{
    LoadingDialog.show(context, message: "努力登录中...");
    final res = await loginAPI({
      "account": _usernameController.text,
      "password": _passwordController.text,
    });
    // 登录成功后更新用户信息
    _userController.updateUser(res);//更新用户信息到UserController中 通过GetX实现全局状态管理 其他页面可以监听用户信息的变化并更新UI
    // 登录成功后更新token
    await tokenManager.setToken(res.token);//将登录接口返回的token保存到TokenManager中 通过SharedPreferences实现持久化存储 其他页面可以通过TokenManager获取token并进行鉴权等操作
    LoadingDialog.hide(context);//隐藏加载进度
    Toastutils.showToast(context, "登录成功");
    Navigator.pop(context);//登录成功后返回上一页并传递用户信息
}catch(e){
  //登录失败提示错误信息
  LoadingDialog.hide(context);//隐藏加载进度
  Toastutils.showToast(context, (e as DioException).message);//登录失败提示错误信息
  }
}
//登录按钮Widget
Widget _buildLoginButton() {
  return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (_Key.currentState!.validate()) {
            // 进行勾选框的判断
            if(_isChecked){
              //校验通过
              _login();
            }else{
              //提示勾选用户协议
              Toastutils.showToast(context, "请勾选用户协议");
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text("登录", style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
}
//勾选用户协议Widget
bool _isChecked = false;
  Widget _buildCheckbox() {
    return Row(
      children: [
        // 设置勾选为圆角
        Checkbox(//勾选框
          value: _isChecked,
          activeColor: Colors.black,//勾选框选中时的颜色
          checkColor: Colors.white,//勾选框内勾的颜色
          onChanged: (bool? value) {
            _isChecked = value ?? false;
            setState(() {});
          },
          // 设置形状
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // 圆角大小
          ),
          // 可选：设置边框
          side: BorderSide(color: Colors.grey, width: 2.0),
        ),
        Text.rich(
          TextSpan(//富文本
            children: [
              TextSpan(text: "查看并同意"),
              TextSpan(
                text: "《隐私条款》",
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(text: "和"),
              TextSpan(
                text: "《用户协议》",
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }
  // 头部Widget
  Widget _buildHeader() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "账号密码登录",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
  final GlobalKey<FormState> _Key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("惠多美登录", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: Form(//表单 TextFormField需要放在Form中 可实现表单验证等功能
      key: _Key,
        child: Container(
          padding: EdgeInsets.all(30),
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildHeader(),
              SizedBox(height: 30),
              _buildUsernameTextField(),
              SizedBox(height: 20),
              _buildPasswordTextField(),
              SizedBox(height: 20),
              _buildCheckbox(),
              SizedBox(height: 20),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}