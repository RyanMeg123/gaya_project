import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class OrderItem {
  final String orderNumber;
  final String productName;
  final String variant;
  final double price;
  double discountAmount;
  final String status;

  OrderItem({
    required this.orderNumber,
    required this.productName,
    required this.variant,
    required this.price,
    this.discountAmount = 0,
    this.status = 'pending',
  });

  double get finalPrice => price - discountAmount;

  Map<String, dynamic> toJson() {
    return {
      'orderNumber': orderNumber,
      'productName': productName,
      'variant': variant,
      'price': price,
      'discountAmount': discountAmount,
      'status': status,
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      orderNumber: json['orderNumber'],
      productName: json['productName'],
      variant: json['variant'],
      price: json['price'].toDouble(),
      discountAmount: json['discountAmount']?.toDouble() ?? 0,
      status: json['status'],
    );
  }
}
