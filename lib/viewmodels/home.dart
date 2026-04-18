//首页数据对象
class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});
  //扩展一个工厂函数 一般用factory来声明，一般用来创建对象实例，或者根据某些条件返回不同的对象实例
  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(id: json['id'] ?? "", imgUrl: json['imgUrl'] ?? "");
  }
}

//第二步：定义分类数据对象和工厂转化函数
//根据json编写class对象和工厂转化函数
class CategoryItem {
  String id;
  String name;
  String picture;
  List<CategoryItem>? children;
  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
  });
  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      picture: json['picture'] ?? "",
      children: (json['children'] == null)
          ? null
          : (json['children'] as List?)
                ?.map(
                  (item) => CategoryItem.fromJson(item as Map<String, dynamic>),
                )
                .toList(),
    );
  }
}

//定义特惠推荐数据对象和工厂转化函数
class GoodsItem {
  String id;
  String name;
  String? desc;
  String price;
  String picture;
  int orderNum;
  GoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });
  factory GoodsItem.fromJson(Map<String, dynamic> json) {
    return GoodsItem(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      desc: json['desc'],
      price: json['price'] ?? "",
      picture: json['picture'] ?? "",
      orderNum: json['orderNum'] ?? 0,
    );
  }
}

class GoodsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodsItem> items;
  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });
  factory GoodsItems.fromJson(Map<String, dynamic> json) {
    return GoodsItems(
      counts: int.tryParse(json['counts']?.toString() ?? "") ?? 0,
      pageSize: int.tryParse(json['pageSize']?.toString() ?? "") ?? 0,
      pages: int.tryParse(json['pages']?.toString() ?? "") ?? 0,
      page: int.tryParse(json['page']?.toString() ?? "") ?? 0,
      items: (json['items'] as List)
          .map((item) => GoodsItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SubType {
  String id;
  String titile;
  GoodsItems goodsItems;
  SubType({required this.id, required this.titile, required this.goodsItems});
  factory SubType.fromJson(Map<String, dynamic> json) {
    return SubType(
      id: json['id']?.toString() ?? "",
      titile: json['titile']?.toString() ?? "",
      goodsItems: GoodsItems.fromJson(
        json['goodsItems'] as Map<String, dynamic>,
      ),
    );
  }
}

class SpecilaRecommendResult {
  String id;
  String title;
  List<SubType> subTypes;
  SpecilaRecommendResult({
    required this.id,
    required this.title,
    required this.subTypes,
  });
  factory SpecilaRecommendResult.fromJson(Map<String, dynamic> json) {
    return SpecilaRecommendResult(
      id: json['id']?.toString() ?? "",
      title: json['title']?.toString() ?? "",
      subTypes: (json['subTypes'] as List)
          .map((item) => SubType.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

//列表项类型
class GoodDetailItem extends GoodsItem {
  int payCount = 0;
  GoodDetailItem({
    required String id,
    required String name,
    String? desc,
    required String price,
    required String picture,
    required int orderNum,
    this.payCount = 0,
  }) : super(
         id: id,
         name: name,
         desc: desc,
         price: price,
         picture: picture,
         orderNum: orderNum,
       );
  //工厂函数
  factory GoodDetailItem.fromJson(Map<String, dynamic> json) {
    return GoodDetailItem(
      id: json['id']?.toString() ?? "",
      name: json['name']?.toString() ?? "",
      desc: json['desc']?.toString(),
      price: json['price']?.toString() ?? "",
      picture: json['picture']?.toString() ?? "",
      orderNum: int.tryParse(json['orderNum']?.toString() ?? "") ?? 0,
      payCount: int.tryParse(json['payCount']?.toString() ?? "") ?? 0,
    );
  }
}

//改造GoodsItems来适配HmMoreList组件的接口数据结构
class GoodsDetailsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodDetailItem> items;
  GoodsDetailsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });
  factory GoodsDetailsItems.fromJson(Map<String, dynamic> json) {
    return GoodsDetailsItems(
      counts: int.tryParse(json['counts']?.toString() ?? "") ?? 0,
      pageSize: int.tryParse(json['pageSize']?.toString() ?? "") ?? 0,
      pages: int.tryParse(json['pages']?.toString() ?? "") ?? 0,
      page: int.tryParse(json['page']?.toString() ?? "") ?? 0,
      items: (json['items'] as List)
          .map((item) => GoodDetailItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}