import 'package:json_annotation/json_annotation.dart';

part 'product_details.g.dart';

@JsonSerializable()
class ProductDetails {
  final int productId;
  final String? name;
  final String? description;
  final int? categoryId;
  final double? originalPrice;
  final double? discountPrice;
  final bool? isDiscounted;
  final int? stockQuantity;
  final String? imageUrl;
  final ProductStatus? status;
  final double? discountAmount;
  final int? collectAmount;
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
    this.imageUrl,
    this.status,
    this.discountAmount,
    this.collectAmount,
    this.category,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) => 
      _$ProductDetailsFromJson(json);
  
  Map<String, dynamic> toJson() => _$ProductDetailsToJson(this);
}

enum ProductStatus {
  available,
  outOfStock,
  discontinued,
} 