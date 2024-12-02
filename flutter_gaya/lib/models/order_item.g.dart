// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      orderNumber: json['orderNumber'] as String,
      status: json['status'] as String,
      productImage: json['productImage'] as String,
      productName: json['productName'] as String,
      variant: json['variant'] as String,
      price: json['price'] as String,
      originalPrice: json['originalPrice'] as String?,
      itemCount: (json['itemCount'] as num).toInt(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      discountAmount: (json['discountAmount'] as num?)?.toDouble() ?? 0,
      shippingFee: (json['shippingFee'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'orderNumber': instance.orderNumber,
      'status': instance.status,
      'productImage': instance.productImage,
      'productName': instance.productName,
      'variant': instance.variant,
      'price': instance.price,
      'originalPrice': instance.originalPrice,
      'itemCount': instance.itemCount,
      'totalPrice': instance.totalPrice,
      'discountAmount': instance.discountAmount,
      'shippingFee': instance.shippingFee,
    };
