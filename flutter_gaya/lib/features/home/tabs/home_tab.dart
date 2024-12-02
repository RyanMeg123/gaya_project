import 'package:flutter/material.dart';
import 'package:flutter_gaya_2/features/home/widgets/carousel.dart';
import 'package:flutter_gaya_2/features/home/widgets/featured_product.dart';
import 'package:flutter_gaya_2/features/home/widgets/home_app_bar.dart';
import 'package:flutter_gaya_2/features/home/widgets/list-card.dart';
import 'package:flutter_gaya_2/features/home/widgets/search_box.dart';
import 'package:flutter_gaya_2/models/tab_model.dart';
import 'package:flutter_gaya_2/routes.dart';
import 'package:flutter_gaya_2/services/api_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  _HomeTabstate createState() => _HomeTabstate();
}

class _HomeTabstate extends State<HomeTab> {
  final _apiService = ApiService();
  List<String> _imgList = [];
  bool _isLoading = true;
  String _searchQuery = '';
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadDiscountedProducts();
  }

  Future<void> _loadDiscountedProducts() async {
    try {
      final products = await _apiService.getDiscountedProducts();
      setState(() {
        _imgList =
            products.map((product) => product['imageUrl'] as String).toList();
        _isLoading = false;
      });
      print('_imgList ${_imgList.length}');
    } catch (e) {
      print('Error loading discounted products: $e');
      setState(() {
        // 使用默认图片作为后备
        _imgList = [
          'assets/images/home/banner1.png',
          'assets/images/home/banner1.png',
          'assets/images/home/banner1.png',
          'assets/images/home/banner1.png',
        ];
        _isLoading = false;
      });
    }
  }

  void _onFavoritesTap() {
    Navigator.pushNamed(context, AppRoutes.wishlist);
  }

  void _onNotificationsTap() {
    print('_onNotificationsTap');
  }

  String searchQuery = '';
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
    // 根据卡片索引设置对应的标签索引
    int initialTabIndex;
    switch (index) {
      case 0:  // TShirt 卡片
        initialTabIndex = 0;  // 对应 TShirt 标签
        break;
      case 1:  // Shoes 卡片
        initialTabIndex = 1;  // 对应 Shoes 标签
        break;
      case 2:  // Watch 卡片
        initialTabIndex = 4;  // 对应 Watch 标签
        break;
      default:
        initialTabIndex = 0;
    }

    Navigator.pushNamed(
      context,
      AppRoutes.productSecondary,
      arguments: ProductRouteParameter(
        cardIndex: index,
        initialTabIndex: initialTabIndex,
      ),
    );
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      final results = await _apiService.searchProducts(query);
      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    } catch (e) {
      print('Search error: $e');
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
    }
  }

  void _handleSearchResultTap(Map<String, dynamic> product) {
    // 添加数据类型转换的安全处理
    double parsePrice(dynamic price) {
      if (price == null) return 0.0;
      if (price is num) return price.toDouble();
      if (price is String) return double.tryParse(price) ?? 0.0;
      return 0.0;
    }

    final productDetail = ProductDetails(
      productId:
          product['id'] is String ? int.parse(product['id']) : product['id'],
      name: product['name']?.toString() ?? '',
      description: product['description']?.toString() ?? '',
      imageUrl: product['imageUrl']?.toString() ?? '',
      originalPrice: parsePrice(product['originalPrice']),
      discountPrice: product['discountPrice'] != null
          ? parsePrice(product['discountPrice'])
          : null,
      isDiscounted: product['isDiscounted'] == true,
      stockQuantity: product['stockQuantity'] is String
          ? int.parse(product['stockQuantity'])
          : (product['stockQuantity'] ?? 0),
      status: ProductStatus.available,
      collectAmount: product['collectAmount'] is String
          ? int.parse(product['collectAmount'])
          : (product['collectAmount'] ?? 0),
      category: product['category']?.toString() ?? '',
    );

    Navigator.pushNamed(
      context,
      AppRoutes.productDetail,
      arguments: productDetail,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
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
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.w, vertical: 1.h),
                        child: SearchBox(
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                            _performSearch(value);
                          },
                        ),
                      ),
                      if (_isSearching)
                        const Center(child: CircularProgressIndicator())
                      else if (_searchResults.isNotEmpty)
                        Container(
                          height: 200.h,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: ListView.builder(
                            itemCount: _searchResults.length,
                            itemBuilder: (context, index) {
                              final product = _searchResults[index];
                              return ListTile(
                                leading: Image.network(
                                  product['imageUrl'],
                                  width: 50.w,
                                  height: 50.h,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.image_not_supported,
                                          size: 50.r),
                                ),
                                title: Text(product['name']),
                                subtitle: Text('\$${product['originalPrice']}'),
                                onTap: () => _handleSearchResultTap(product),
                              );
                            },
                          ),
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
