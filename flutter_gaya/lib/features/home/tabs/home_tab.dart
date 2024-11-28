import 'package:flutter/material.dart';
import 'package:flutter_gaya_2/features/home/widgets/carousel.dart';
import 'package:flutter_gaya_2/features/home/widgets/featured_product.dart';
import 'package:flutter_gaya_2/features/home/widgets/home_app_bar.dart';
import 'package:flutter_gaya_2/features/home/widgets/list-card.dart';
import 'package:flutter_gaya_2/models/tab_model.dart';
import 'package:flutter_gaya_2/routes.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  _HomeTabstate createState() => _HomeTabstate();
}

class _HomeTabstate extends State<HomeTab> {
  void _onFavoritesTap() {
    Navigator.pushNamed(context, AppRoutes.wishlist);
  }

  void _onNotificationsTap() {
    print('_onNotificationsTap');
  }

  String searchQuery = '';
  final List<String> _imgList = [
    'assets/images/home/banner1.png',
    'assets/images/home/banner1.png',
    'assets/images/home/banner1.png',
    'assets/images/home/banner1.png',
  ];
  final List<Item> _listCard = [
    Product('TShirt', 'Man Fashion', 312, 'assets/images/home/shirt1.png',
        watermark: 'assets/images/home/Vector1.png'),
    Product('Shoes', 'Formal Shoes', 213, 'assets/images/home/shoe1.png',
        watermark: 'assets/images/home/Vector2.png'),
    Product(
        'Hand Watch', 'Original Watch', 65, 'assets/images/home/hand_watch.png',
        watermark: 'assets/images/home/Vector3.png'),
    Product('', 'Check out more', 87, 'assets/images/home/icNext.png'),
  ];

  final List<ProductDetails> _products = [
    ProductDetails(
      productId: 1,
      name: 'Reversible Bomber Jacket',
      imageUrl: 'assets/images/home/bk.png',
      description: 'This is a cute cat product!',
      originalPrice: 16.9,
      stockQuantity: 20,
      collectAmount: 4,
      status: ProductStatus.available,
      category: 'Featured',
    ),
    ProductDetails(
      productId: 2,
      name: 'Pormula 1 Exclusive Watch [GOLD]',
      imageUrl: 'assets/images/home/bk.png',
      description: 'This is another cute cat product!',
      originalPrice: 16.9,
      stockQuantity: 20,
      collectAmount: 4,
      status: ProductStatus.available,
      category: 'Featured',
    ),
    ProductDetails(
      productId: 3,
      name: 'Pormula 1 Exclusive Watch [GOLD]',
      imageUrl: 'assets/images/home/bk.png',
      description: 'Yet another cute cat product!',
      originalPrice: 16.9,
      stockQuantity: 20,
      collectAmount: 4,
      status: ProductStatus.available,
      category: 'Featured',
    ),
  ];

  void updateSearchQuery(String query) {
    print(query);
    setState(() {
      searchQuery = query;
    });
  }

  void _onCardTap(int index) {
    print('current card index $index');
    Navigator.pushNamed(context, AppRoutes.productSecondary,
        arguments: ProductRouteParameter(cardIndex: index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: [
            Column(
              children: [
                HomeTabAppBar(
                  userName: 'Ryan',
                  badgeCount: '30',
                  onFavoritesTap: _onFavoritesTap,
                  onNotificationsTap: _onNotificationsTap,
                  onSearchChanged: updateSearchQuery,
                ),
                CustomCarousel(
                  imgList: _imgList,
                ),
                ListCard(
                  CardList: _listCard,
                  onCardTap: _onCardTap,
                ),
                FeaturedProduct(products: _products)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
