// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetails _$ProductDetailsFromJson(Map<String, dynamic> json) =>
    ProductDetails(
      productId: (json['productId'] as num).toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      categoryId: (json['categoryId'] as num?)?.toInt(),
      originalPrice: (json['originalPrice'] as num?)?.toDouble(),
      discountPrice: (json['discountPrice'] as num?)?.toDouble(),
      isDiscounted: json['isDiscounted'] as bool?,
      stockQuantity: (json['stockQuantity'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] as String?,
      status: $enumDecodeNullable(_$ProductStatusEnumMap, json['status']),
      discountAmount: (json['discountAmount'] as num?)?.toDouble(),
      collectAmount: (json['collectAmount'] as num?)?.toInt(),
      category: json['category'] as String?,
    );

Map<String, dynamic> _$ProductDetailsToJson(ProductDetails instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'name': instance.name,
      'description': instance.description,
      'categoryId': instance.categoryId,
      'originalPrice': instance.originalPrice,
      'discountPrice': instance.discountPrice,
      'isDiscounted': instance.isDiscounted,
      'stockQuantity': instance.stockQuantity,
      'imageUrl': instance.imageUrl,
      'status': _$ProductStatusEnumMap[instance.status],
      'discountAmount': instance.discountAmount,
      'collectAmount': instance.collectAmount,
      'category': instance.category,
    };

const _$ProductStatusEnumMap = {
  ProductStatus.available: 'available',
  ProductStatus.outOfStock: 'outOfStock',
  ProductStatus.discontinued: 'discontinued',
};
