import 'package:json_annotation/json_annotation.dart';

part 'order_item.g.dart';

@JsonSerializable()
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

  // 自动生成 fromJson
  factory OrderItem.fromJson(Map<String, dynamic> json) => 
      _$OrderItemFromJson(json);

  // 自动生成 toJson
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
} 