import 'package:flutter/material.dart';
import '../../../models/tab_model.dart';

class CartController extends ChangeNotifier {
  final List<OrderItem> _cartItems = [];

  List<OrderItem> get cartItems => _cartItems;

  void addToCart(ProductDetail product, String variant) {
    // 检查是否已存在相同商品
    final existingItem = _cartItems.firstWhere(
      (item) =>
          item.orderNumber == product.productId.toString() &&
          item.variant == variant,
      orElse: () => OrderItem(
        orderNumber: product.productId.toString(),
        status: 'PENDING',
        productImage: product.imageUrl ?? '',
        productName: product.name ?? '',
        variant: variant,
        price:
            '\$${product.discountPrice?.toStringAsFixed(1) ?? product.originalPrice?.toStringAsFixed(1)}',
        originalPrice: product.discountPrice != null
            ? '\$${product.originalPrice?.toStringAsFixed(1)}'
            : null,
        itemCount: 0,
        totalPrice: product.discountPrice ?? product.originalPrice ?? 0.0,
      ),
    );

    if (!_cartItems.contains(existingItem)) {
      _cartItems.add(existingItem);
    }
    notifyListeners();
  }

  void removeFromCart(String orderNumber) {
    _cartItems.removeWhere((item) => item.orderNumber == orderNumber);
    notifyListeners();
  }

  void updateItemCount(String orderNumber, int count) {
    final item =
        _cartItems.firstWhere((item) => item.orderNumber == orderNumber);
    final price = double.parse(item.price.replaceAll('\$', ''));
    item.itemCount = count;
    item.totalPrice = price * count;
    notifyListeners();
  }

  void updateOrderStatus(String orderNumber, String newStatus) {
    final orderIndex =
        _cartItems.indexWhere((item) => item.orderNumber == orderNumber);
    if (orderIndex != -1) {
      _cartItems[orderIndex].status = newStatus;
      notifyListeners();
    }
  }
}
