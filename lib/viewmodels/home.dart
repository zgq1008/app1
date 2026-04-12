//首页数据对象
class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});
  //扩展一个工厂函数 一般用factory来声明，一般用来创建对象实例，或者根据某些条件返回不同的对象实例
  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(
      id: json['id'] ?? "",
      imgUrl: json['imgUrl'] ?? "",
    );
  }
}