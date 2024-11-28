import 'package:flutter/material.dart';
import '../../../models/tab_model.dart';

class FeaturedProductsController extends ChangeNotifier {
  final List<ProductDetails> _products = [
    // Man Fashion
    ProductDetails(
      productId: 1,
      name: 'Casual Shoes',
      imageUrl: 'assets/images/home/product1.png',
      originalPrice: 56.4,
      discountPrice: null,
      discountAmount: 0,
      collectAmount: 245,
      description: 'Comfortable casual shoes for daily wear',
      status: ProductStatus.available,
      categoryId: 1,
    ),
    ProductDetails(
      productId: 2,
      name: 'Leather Watch',
      imageUrl: 'assets/images/home/product2.png',
      originalPrice: 89.9,
      discountPrice: null,
      discountAmount: 0,
      collectAmount: 180,
      description: 'Classic leather watch with modern design',
      status: ProductStatus.available,
      categoryId: 1,
    ),
    ProductDetails(
      productId: 3,
      name: 'Business Suit',
      imageUrl: 'assets/images/home/product3.png',
      originalPrice: 299.9,
      discountPrice: null,
      discountAmount: 0,
      collectAmount: 320,
      description: 'Professional business suit for formal occasions',
      status: ProductStatus.available,
      categoryId: 1,
    ),

    // FlashSale
    ProductDetails(
      productId: 4,
      name: 'Brown Watch',
      imageUrl: 'assets/images/home/product2.png',
      originalPrice: 21.7,
      discountPrice: 18.45,
      discountAmount: 15,
      collectAmount: 156,
      description: 'Elegant brown watch with special discount',
      status: ProductStatus.available,
      isDiscounted: true,
      categoryId: 2,
    ),
    ProductDetails(
      productId: 5,
      name: 'Sport Shoes',
      imageUrl: 'assets/images/home/product1.png',
      originalPrice: 45.9,
      discountPrice: 36.72,
      discountAmount: 20,
      collectAmount: 289,
      description: 'High-performance sport shoes on sale',
      status: ProductStatus.available,
      isDiscounted: true,
      categoryId: 2,
    ),
    ProductDetails(
      productId: 6,
      name: 'Smart Watch',
      imageUrl: 'assets/images/home/product4.png',
      originalPrice: 99.9,
      discountPrice: 79.92,
      discountAmount: 20,
      collectAmount: 425,
      description: 'Latest smart watch with amazing features',
      status: ProductStatus.available,
      isDiscounted: true,
      categoryId: 2,
    ),

    // Women Fashion
    ProductDetails(
      productId: 7,
      name: 'Purple Sunglasses',
      imageUrl: 'assets/images/home/product3.png',
      originalPrice: 12.6,
      discountPrice: null,
      discountAmount: 0,
      collectAmount: 145,
      description: 'Stylish purple sunglasses for summer',
      status: ProductStatus.available,
      categoryId: 3,
    ),
    ProductDetails(
      productId: 8,
      name: 'Summer Dress',
      imageUrl: 'assets/images/home/product4.png',
      originalPrice: 78.9,
      discountPrice: null,
      discountAmount: 0,
      collectAmount: 278,
      description: 'Beautiful summer dress for casual wear',
      status: ProductStatus.available,
      categoryId: 3,
    ),
    ProductDetails(
      productId: 9,
      name: 'Fashion Bag',
      imageUrl: 'assets/images/home/product1.png',
      originalPrice: 156.4,
      discountPrice: null,
      discountAmount: 0,
      collectAmount: 312,
      description: 'Trendy fashion bag for modern women',
      status: ProductStatus.available,
      categoryId: 3,
    ),
  ];

  List<ProductDetails> get allProducts => _products;
  
  List<ProductDetails> getProductsByCategory(String category) {
    if (category == 'All') return _products;
    int categoryId = getCategoryId(category);
    return _products.where((product) => product.categoryId == categoryId).toList();
  }

  int getCategoryId(String category) {
    switch (category) {
      case 'Man Fashion':
        return 1;
      case 'FlashSale':
        return 2;
      case 'Women Fashion':
        return 3;
      default:
        return 0;
    }
  }
} 