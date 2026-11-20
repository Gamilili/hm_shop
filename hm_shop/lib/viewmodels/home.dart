class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(id: json["id"], imgUrl: json["imgUrl"]);
  }
}

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
    final children = json["children"] as List?;
    return CategoryItem(
      id: json["id"] as String,
      name: json["name"] as String,
      picture: json["picture"] as String,
      children: children
          ?.map((e) => CategoryItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SuggestionResult {
  String id;
  String title;
  List<SuggestionSubType> subTypes;

  SuggestionResult({
    required this.id,
    required this.title,
    required this.subTypes,
  });

  factory SuggestionResult.fromJson(Map<String, dynamic> json) {
    return SuggestionResult(
      id: json["id"] as String,
      title: json["title"] as String,
      subTypes: (json["subTypes"] as List)
          .map((e) => SuggestionSubType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SuggestionSubType {
  String id;
  String title;
  GoodsItems goodsItems;

  SuggestionSubType({
    required this.id,
    required this.title,
    required this.goodsItems,
  });

  factory SuggestionSubType.fromJson(Map<String, dynamic> json) {
    return SuggestionSubType(
      id: json["id"] as String,
      title: json["title"] as String,
      goodsItems: GoodsItems.fromJson(
        json["goodsItems"] as Map<String, dynamic>,
      ),
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
      counts: json["counts"] as int,
      pageSize: json["pageSize"] as int,
      pages: json["pages"] as int,
      page: json["page"] as int,
      items: (json["items"] as List)
          .map((e) => GoodsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class GoodsItem {
  String id;
  String name;
  String desc;
  String price;
  String picture;
  int orderNum;

  GoodsItem({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });

  factory GoodsItem.fromJson(Map<String, dynamic> json) {
    return GoodsItem(
      id: json["id"] as String,
      name: json["name"] as String,
      desc: json["desc"] as String? ?? "",
      price: json["price"] as String,
      picture: json["picture"] as String,
      orderNum: json["orderNum"] as int,
    );
  }
}

class GoodDetailItem extends GoodsItem {
  int payCount = 0;

  /// 商品详情项
  GoodDetailItem({
    required super.id,
    required super.name,
    required super.price,
    required super.picture,
    required super.orderNum,
    required this.payCount,
  }) : super(desc: "");
  // 转化方法
  factory GoodDetailItem.fromJson(Map<String, dynamic> json) {
    return GoodDetailItem(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      price: json["price"]?.toString() ?? "",
      picture: json["picture"]?.toString() ?? "",
      orderNum: int.tryParse(json["orderNum"]?.toString() ?? "0") ?? 0,
      payCount: int.tryParse(json["payCount"]?.toString() ?? "0") ?? 0,
    );
  }
}

class GoodsDetailItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodDetailItem> items;

  GoodsDetailItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory GoodsDetailItems.fromJson(Map<String, dynamic> json) {
    return GoodsDetailItems(
      counts: json["counts"] as int,
      pageSize: json["pageSize"] as int,
      pages: json["pages"] as int,
      page: json["page"] as int,
      items: (json["items"] as List)
          .map((e) => GoodDetailItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
