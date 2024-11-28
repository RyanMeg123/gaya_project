import 'package:flutter/material.dart';

class WishlistController extends ChangeNotifier {
  final List<WishlistItem> _items = [
    WishlistItem(
      title: 'Tactical Backpack',
      price: '\$56.4',
      imageUrl: 'assets/images/home/product1.png',
      isFeatured: true,
      isLiked: true,
    ),
    WishlistItem(
      title: 'Beach Hat',
      price: '\$56.4',
      imageUrl: 'assets/images/home/product2.png',
      isFeatured: true,
      isLiked: true,
    ),
    WishlistItem(
      title: 'Smart Watch',
      price: '\$89.9',
      imageUrl: 'assets/images/home/product3.png',
      isFeatured: true,
      isLiked: false,
    ),
    WishlistItem(
      title: 'Running Shoes',
      price: '\$120.0',
      imageUrl: 'assets/images/home/product4.png',
      isFeatured: true,
      isLiked: false,
    ),
    WishlistItem(
      title: 'Leather Bag',
      price: '\$199.9',
      imageUrl: 'assets/images/home/product1.png',
      isFeatured: true,
      isLiked: false,
    ),
    WishlistItem(
      title: 'Sports Cap',
      price: '\$45.0',
      imageUrl: 'assets/images/home/product2.png',
      isFeatured: true,
      isLiked: false,
    ),
    WishlistItem(
      title: 'Brown Hand Watch',
      variant: 'White Stripes',
      price: '\$175.4',
      imageUrl: 'assets/images/home/product3.png',
      isFeatured: false,
      isLiked: false,
    ),
    WishlistItem(
      title: 'Possil Leather Watch',
      variant: 'White Stripes',
      price: '\$253.6',
      imageUrl: 'assets/images/home/product4.png',
      isFeatured: false,
      isLiked: false,
    ),
    WishlistItem(
      title: 'Super Red Naiki Shoes',
      variant: 'White Stripes',
      price: '\$175.4',
      imageUrl: 'assets/images/home/product1.png',
      isFeatured: false,
      isLiked: false,
    ),
  ];

  List<WishlistItem> get items => _items;
  List<WishlistItem> get featuredItems =>
      _items.where((item) => item.isFeatured).toList();
  List<WishlistItem> get otherItems =>
      _items.where((item) => !item.isFeatured && item.isLiked).toList();

  void toggleFavorite(WishlistItem item) {
    final index = _items.indexWhere((i) =>
        i.title == item.title &&
        i.price == item.price &&
        i.imageUrl == item.imageUrl);

    if (index != -1) {
      final updatedItem = WishlistItem(
        title: item.title,
        variant: item.variant,
        price: item.price,
        imageUrl: item.imageUrl,
        isFeatured: item.isFeatured,
        isLiked: !(_items[index].isLiked),
      );

      _items[index] = updatedItem;

      if (item.isFeatured && updatedItem.isLiked) {
        _items.add(WishlistItem(
          title: item.title,
          variant: 'Default',
          price: item.price,
          imageUrl: item.imageUrl,
          isFeatured: false,
          isLiked: true,
        ));
      } else if (item.isFeatured && !updatedItem.isLiked) {
        _items.removeWhere((i) =>
            !i.isFeatured && i.title == item.title && i.price == item.price);
      }

      notifyListeners();
    }
  }

  void removeItem(WishlistItem item) {
    _items.remove(item);
    notifyListeners();
  }

  List<WishlistItem> searchItems(String query) {
    if (query.isEmpty) return _items;

    return _items.where((item) {
      return item.title.toLowerCase().contains(query.toLowerCase()) ||
          (item.variant?.toLowerCase().contains(query.toLowerCase()) ??
              false) ||
          item.price.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}

class WishlistItem {
  final String title;
  final String? variant;
  final String price;
  final String imageUrl;
  final bool isFeatured;
  final bool isLiked;

  WishlistItem({
    required this.title,
    this.variant,
    required this.price,
    required this.imageUrl,
    required this.isFeatured,
    required this.isLiked,
  });
}
