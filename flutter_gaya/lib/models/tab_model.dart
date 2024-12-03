import 'package:flutter/material.dart';

class TabModel {
  final String title;
  final IconData icon;

  TabModel(this.title, this.icon);
}

abstract class Item {
  String get typeName;
  String get shortName;
  int get collectionNumber;
  String get iconUrl;
  String? get watermark;
}

class Product implements Item {
  @override
  final String typeName;
  @override
  final String shortName;
  @override
  final int collectionNumber;
  @override
  final String iconUrl;
  @override
  final String? watermark;
  Product(this.typeName, this.shortName, this.collectionNumber, this.iconUrl,
      {this.watermark});
}

abstract class ProductSliding {
  String get image;
  String get name;
  String get date;
  String get description;
  double get price;
  int get leftCount;
  int get collectStars;
  int get reviews;
  double get rates;
}

class ProductItem implements ProductSliding {
  @override
  final String image;
  @override
  final String name;
  @override
  final String date;
  @override
  final String description;
  @override
  final double price;
  @override
  final int leftCount;
  @override
  final int collectStars;
  @override
  final int reviews;
  @override
  final double rates;

  ProductItem(
      {required this.image,
      required this.name,
      required this.date,
      required this.description,
      required this.price,
      required this.leftCount,
      required this.collectStars,
      required this.reviews,
      required this.rates});
}

class ProductRouteParameter {
  final int cardIndex;
  final int initialTabIndex;

  ProductRouteParameter({
    required this.cardIndex,
    this.initialTabIndex = 0,
  });
}

class TabIconItem {
  final String typeText;
  final String typeIcon;
  final int tabIndex;
  TabIconItem(
      {required this.typeText, required this.typeIcon, required this.tabIndex});
  @override
  String toString() {
    return 'TabIconItem(typeText: $typeText, typeIcon: $typeIcon, tabIndex: $tabIndex)';
  }
}

abstract class ProductDetail {
  final int productId;
  final String? name;
  final String? description;
  final int? categoryId;
  final double? originalPrice;
  final double? discountPrice;
  final bool? isDiscounted;
  final int? stockQuantity;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? imageUrl;
  final ProductStatus? status;
  final double? discountAmount;
  final int? collectAmount;
  final String? category;

  ProductDetail({
    required this.productId,
    this.name,
    this.description,
    this.categoryId,
    this.originalPrice,
    this.discountPrice,
    this.isDiscounted,
    this.stockQuantity,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
    this.status,
    this.collectAmount,
    this.discountAmount,
    this.category,
  });

  // 抽象方法，表示需要子类实现
  double getCurrentPrice();

  void updateStock(int quantity);
}

class ProductDetails implements ProductDetail {
  @override
  final int productId;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final int? categoryId;
  @override
  final double? originalPrice;
  @override
  final double? discountPrice;
  @override
  final bool? isDiscounted;
  @override
  final int? stockQuantity;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? imageUrl;
  @override
  final ProductStatus? status;
  @override
  final double? discountAmount;
  @override
  final int? collectAmount;
  @override
  final String? category;

  ProductDetails({
    required this.productId,
    this.name,
    this.description,
    this.categoryId,
    this.originalPrice,
    this.discountPrice,
    this.isDiscounted,
    this.stockQuantity,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
    this.status,
    this.discountAmount,
    this.collectAmount,
    this.category,
  });

  @override
  double getCurrentPrice() {
    // TODO: implement getCurrentPrice
    throw UnimplementedError();
  }

  @override
  void updateStock(int quantity) {
    // TODO: implement updateStock
  }
}

// 枚举类表示商品状态
enum ProductStatus {
  available,
  outOfStock,
  discontinued,
}

class FavoriteItem {
  final int productId;
  final DateTime addedAt;

  FavoriteItem({
    required this.productId,
    required this.addedAt,
  });
}

abstract class FavoritesManager {
  // 收藏的商品列表
  final List<FavoriteItem> favorites = [];

  // 添加商品到收藏夹
  void addFavorite(int productId) {
    favorites.add(FavoriteItem(productId: productId, addedAt: DateTime.now()));
  }

  // 从收藏夹移除商品
  void removeFavorite(int productId) {
    favorites.removeWhere((item) => item.productId == productId);
  }

  // 检查商品是否在收藏夹中
  bool isFavorite(int productId) {
    return favorites.any((item) => item.productId == productId);
  }
}

// 添加 OrderItem 类
class OrderItem {
  final String orderNumber;
  String status;
  final String productImage;
  final String productName;
  final String variant;
  final String price;
  final String? originalPrice;
  int itemCount;
  double totalPrice;
  double discountAmount;
  double shippingFee;

  OrderItem({
    required this.orderNumber,
    required this.status,
    required this.productImage,
    required this.productName,
    required this.variant,
    required this.price,
    this.originalPrice,
    required this.itemCount,
    required this.totalPrice,
    this.discountAmount = 0,
    this.shippingFee = 0,
  });

  double get finalPrice {
    double total = totalPrice;
    total -= (discountAmount);
    total += (shippingFee);
    return total;
  }

  // 添加 toJson 方法
  Map<String, dynamic> toJson() {
    return {
      'orderNumber': orderNumber,
      'status': status,
      'productImage': productImage,
      'productName': productName,
      'variant': variant,
      'price': price,
      'originalPrice': originalPrice,
      'itemCount': itemCount,
      'totalPrice': totalPrice,
    };
  }

  // 添加 fromJson 工厂构造函数
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      orderNumber: json['orderNumber'],
      status: json['status'],
      productImage: json['productImage'],
      productName: json['productName'],
      variant: json['variant'],
      price: json['price'],
      originalPrice: json['originalPrice'],
      itemCount: json['itemCount'],
      totalPrice: json['totalPrice'],
    );
  }
}
