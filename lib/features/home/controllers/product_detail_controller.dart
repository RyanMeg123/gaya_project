import 'package:flutter/material.dart';
import '../../../models/tab_model.dart';

class ProductDetailController extends ChangeNotifier {
  final ProductDetail product;
  bool isFavorite = false;
  int quantity = 1;

  ProductDetailController(this.product);

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  void updateQuantity(int newQuantity) {
    if (newQuantity > 0) {
      quantity = newQuantity;
      notifyListeners();
    }
  }

  void addToCart() {
    // TODO: 实现添加购物车逻辑
  }
} 