# app1

Flutter 学习项目，包含基础路由与底部导航栏示例。

## 项目简介

当前项目已实现：

- 路由入口与命名路由配置
- 主页底部导航栏（首页、分类、购物车、我的）
- 登录页基础页面
- 使用 IndexedStack 保持各 Tab 页面状态

## 页面与路由

- `/`：主页（HomePage）
- `/login`：登录页（LoginPage）

路由定义位置：

- `lib/routes/index.dart`

## 目录说明

- `lib/main.dart`：应用启动入口
- `lib/routes/index.dart`：路由管理
- `lib/pages/Main/index.dart`：主页面与底部导航栏
- `lib/pages/Home/index.dart`：首页
- `lib/pages/Category/index.dart`：分类页
- `lib/pages/Cart/index.dart`：购物车页
- `lib/pages/Person/index.dart`：我的页面
- `lib/pages/Login/index.dart`：登录页

## 本地运行

1. 安装依赖：

```bash
flutter pub get
```

2. 启动项目：

```bash
flutter run
```

## 说明

当前各业务页面为基础占位内容（Center + Text），可在此结构上继续扩展网络请求、状态管理与页面组件化。
