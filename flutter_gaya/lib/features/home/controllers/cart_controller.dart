import 'package:flutter/foundation.dart';
import 'package:flutter_gaya_2/models/cart_model.dart';
import 'package:flutter_gaya_2/models/tab_model.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CartController extends ChangeNotifier {
  List<OrderItem> _cartItems = [];

  // 构造函数中加载本地数据
  CartController() {
    _loadFromLocal();
  }

  List<OrderItem> get cartItems => _cartItems;

  // 添加到购物车
  void addToCart(ProductDetail product, String variant) {
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
      _saveToLocal();  // 保存到本地
    }
    notifyListeners();
  }

  // 从购物车移除
  void removeFromCart(String orderNumber) {
    _cartItems.removeWhere((item) => item.orderNumber == orderNumber);
    _saveToLocal();  // 保存到本地
    notifyListeners();
  }

  // 更新订单状态
  Future<void> updateOrderStatus(String orderNumber, String newStatus) async {
    try {
      final orderIndex =
          _cartItems.indexWhere((item) => item.orderNumber == orderNumber);
      if (orderIndex != -1) {
        _cartItems[orderIndex].status = newStatus;
        _saveToLocal();  // 保存到本地
        notifyListeners();
      }
    } catch (e) {
      print('Error updating order status: $e');
      rethrow;
    }
  }

  // 更新商品数量
  void updateItemCount(String orderNumber, int count) {
    final item = _cartItems.firstWhere((item) => item.orderNumber == orderNumber);
    final price = double.parse(item.price.replaceAll('\$', ''));
    item.itemCount = count;
    item.totalPrice = price * count;
    _saveToLocal();  // 保存到本地
    notifyListeners();
  }

  // 清空购物车
  void clearCart() {
    _cartItems.clear();
    _saveToLocal();  // 保存到本地
    notifyListeners();
  }

  // 保存到本地存储
  Future<void> _saveToLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String cartJson = jsonEncode(_cartItems.map((e) => e.toJson()).toList());
      await prefs.setString('cart_items', cartJson);
    } catch (e) {
      print('Error saving cart: $e');
    }
  }

  // 从本地存储加载
  Future<void> _loadFromLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? cartJson = prefs.getString('cart_items');
      
      if (cartJson != null) {
        final List<dynamic> decoded = jsonDecode(cartJson);
        _cartItems = decoded.map((item) => OrderItem.fromJson(item)).toList();
        notifyListeners();
      }
    } catch (e) {
      print('Error loading cart: $e');
    }
  }
}
