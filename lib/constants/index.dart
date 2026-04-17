//全局常量类
class GlobalConstants {
  //定义常量数据
  static const String BASE_URL = "https://meikou-api.itheima.net";//基础地址
  static const int TIME_OUT = 10;//请求超时时间
  static const String SUCCESS_CODE = "1";//成功状态码
}
//接口地址常量类
class HttpConstants{
  static const String BANNER_LIST="/home/banner";//轮播图接口地址
  static const String CATEGORY_LIST="/home/category/head";//第一步定义常量请求地址：分类接口地址
  static const String PRODUCT_LIST="/hot/preference";//特惠推荐接口地址
}