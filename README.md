# app1

一个用于 Flutter 学习与练手的电商首页 Demo，包含基础路由、底部导航、多模块首页布局与轮播图组件。

## 功能概览

- 命名路由与统一路由入口
- 底部导航栏（首页、分类、购物车、我的）
- 使用 IndexedStack 保持 Tab 页面状态
- 首页采用 CustomScrollView + Sliver 结构
- 首页轮播图（carousel_slider）
- 首页模块化组件拆分（分类、推荐、热门、更多列表等）

## 路由说明

- /：主页 HomePage
- /login：登录页 LoginPage

路由配置见：lib/routes/index.dart

## 关键目录

- lib/main.dart：应用启动入口
- lib/routes/index.dart：路由管理
- lib/pages/Main/index.dart：主页面与底部导航
- lib/pages/Home/index.dart：首页滚动布局与模块组装
- lib/components/Home/HmSlider.dart：首页轮播图组件
- lib/viewmodels/home.dart：首页数据模型（BannerItem）

## 依赖

- flutter
- cupertino_icons
- carousel_slider: ^5.1.2

安装依赖：

```bash
flutter pub get
```

## 运行项目

```bash
flutter run
```

## 后续可扩展方向

- 接入接口数据，替换首页模拟数据
- 增加状态管理（Provider、Riverpod、Bloc 等）
- 补充网络异常、空态与加载态
- 增加组件测试与页面集成测试
