import 'package:flutter/foundation.dart';
import 'package:flutter_gaya_2/models/cart_model.dart';
import 'package:flutter_gaya_2/models/tab_model.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CartController extends ChangeNotifier {
  List<OrderItem> _cartItems = [];
  List<CartItem> _items = [];

  List<OrderItem> get cartItems => _cartItems;
  List<CartItem> get items => _items;

  int get itemCount => _items.length;
  double get totalAmount =>
      _items.fold(0, (sum, item) => sum + item.totalPrice);

  // 添加到购物车 (新版本)
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
        itemCount: 1,
        totalPrice: product.discountPrice ?? product.originalPrice ?? 0.0,
      ),
    );

    if (!_cartItems.contains(existingItem)) {
      _cartItems.add(existingItem);
    }
    _saveToLocal();
    notifyListeners();
  }

  // 更新订单状态
  void updateOrderStatus(String orderNumber, String newStatus) {
    final orderIndex =
        _cartItems.indexWhere((item) => item.orderNumber == orderNumber);
    if (orderIndex != -1) {
      _cartItems[orderIndex].status = newStatus;
      _saveToLocal();
      notifyListeners();
    }
  }

  // 从购物车移除
  void removeFromCart(String orderNumber) {
    _cartItems.removeWhere((item) => item.orderNumber == orderNumber);
    _saveToLocal();
    notifyListeners();
  }

  // 更新数量
  void updateItemCount(String orderNumber, int count) {
    final item =
        _cartItems.firstWhere((item) => item.orderNumber == orderNumber);
    final price = double.parse(item.price.replaceAll('\$', ''));
    item.itemCount = count;
    item.totalPrice = price * count;
    _saveToLocal();
    notifyListeners();
  }

  // 清空购物车
  void clearCart() {
    _cartItems.clear();
    _saveToLocal();
    notifyListeners();
  }

  // 保存到本地存储
  Future<void> _saveToLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final String cartJson =
        jsonEncode(_cartItems.map((e) => e.toJson()).toList());
    await prefs.setString('cart_items', cartJson);
  }

  // 从本地存储加载
  Future<void> loadFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartJson = prefs.getString('cart_items');

    if (cartJson != null) {
      final List<dynamic> decoded = jsonDecode(cartJson);
      _cartItems = decoded.map((item) => OrderItem.fromJson(item)).toList();
      notifyListeners();
    }
  }
}
