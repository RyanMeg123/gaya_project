import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gaya_2/features/home/widgets/product_card.dart';
import 'package:flutter_gaya_2/features/home/widgets/product_list_view.dart';
import 'package:flutter_gaya_2/features/home/widgets/tab_item.dart';
import 'package:flutter_gaya_2/models/tab_model.dart';
import 'package:flutter_gaya_2/routes.dart';
import 'package:flutter_gaya_2/services/api_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProductSecondary extends StatefulWidget {
  final ProductRouteParameter productRouteParameter;
  const ProductSecondary({
    super.key,
    required this.productRouteParameter,
  });

  @override
  State<StatefulWidget> createState() {
    return _ProductSecondaryState();
  }
}

class _ProductSecondaryState extends State<ProductSecondary> {
  final _apiService = ApiService();
  final TextEditingController searchController = TextEditingController();
  late final PageController _pageController;
  final ScrollController _scrollController = ScrollController();
  final ScrollController _cardScrollController = ScrollController();

  bool _isLoading = true;
  bool isGridView = false;
  late int selectedTabIndex;
  List<ProductDetails> productDetailList = [];

  List<TabIconItem> tabList = [
    TabIconItem(
      typeText: 'TShirt',
      typeIcon: 'assets/images/home/shirt_1.png',
      tabIndex: 0,
    ),
    TabIconItem(
      typeText: 'Shoes',
      typeIcon: 'assets/images/home/shoe_1.png',
      tabIndex: 1,
    ),
    TabIconItem(
      typeText: 'Bag',
      typeIcon: 'assets/images/home/womanbag_1.png',
      tabIndex: 2,
    ),
    TabIconItem(
      typeText: 'Dress',
      typeIcon: 'assets/images/home/dress_1.png',
      tabIndex: 3,
    ),
    TabIconItem(
      typeText: 'Watch',
      typeIcon: 'assets/images/home/hand_watch.png',
      tabIndex: 4,
    ),
  ];

  @override
  void initState() {
    super.initState();
    // 初始化顺序很重要
    selectedTabIndex = widget.productRouteParameter.initialTabIndex;
    _pageController = PageController(initialPage: selectedTabIndex);
    _loadProducts();
  }

  @override
  void dispose() {
    searchController.dispose();
    _pageController.dispose();
    _scrollController.dispose();
    _cardScrollController.dispose();
    super.dispose();
  }

  void _performSearch(value) {
    print('这是传递过来的$value');
  }

  void _changeView(type) {
    print('type $type');
    if (type == 'column') {
      setState(() {
        isGridView = false;
      });
    } else {
      setState(() {
        isGridView = true;
      });
    }
  }

  // 添加处理商品点击的方法
  void _handleProductTap(ProductDetail product) {
    Navigator.pushNamed(
      context,
      AppRoutes.productDetail,
      arguments: product,
    );
  }

  void onTabTapped(TabIconItem tab) {
    setState(() {
      selectedTabIndex = tab.tabIndex;
    });
    _pageController.jumpToPage(tab.tabIndex);
    // 切换标签时重新加载商品
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      // 根据 selectedTabIndex 确定要加载的分类
      String category;
      switch (selectedTabIndex) {
        case 0:
          category = 'men';
          break;
        case 1:
          category = 'shoes';
          break;
        case 2:
          category = 'bags';
          break;
        case 3:
          category = 'women';
          break;
        case 4:
          category = 'jewelery';
          break;
        default:
          category = 'men';
      }

      final products = await _apiService.getProductsByCategory(category);
      print(
          'Loading products for category: $category, count: ${products.length}');

      double parsePrice(dynamic price) {
        if (price == null) return 0.0;
        if (price is num) return price.toDouble();
        if (price is String) return double.tryParse(price) ?? 0.0;
        return 0.0;
      }

      setState(() {
        productDetailList = products.map((product) => ProductDetails(
          productId: product['id'] is String 
              ? int.parse(product['id']) 
              : product['id'],
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
          discountAmount: parsePrice(product['discountAmount']),
          collectAmount: product['collectAmount'] is String
              ? int.parse(product['collectAmount'])
              : (product['collectAmount'] ?? 0),
          category: product['category']?.toString() ?? '',
        )).toList();
        _isLoading = false;
        print('shoesss $productDetailList');
      });
    } catch (e) {
      print('Error loading products: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Products',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(CupertinoIcons.back)),
          // backgroundColor: Colors.pink[100],
          actions: [
            IconButton(onPressed: () {}, icon: Icon(MdiIcons.dotsVertical)),
            IconButton(
              icon: const Icon(Icons.bug_report),
              onPressed: () {
                print('\n=== Current Products ===');
                for (var product in productDetailList) {
                  print('''
                    Name: ${product.name}
                    Price: ${product.originalPrice}
                    Category: ${product.category}
                    Image: ${product.imageUrl}
                    ---
                  ''');
                }
                print('=== End Products ===\n');
              },
            ),
          ]),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // 搜索框
                Padding(
                  padding: EdgeInsets.only(top: 22.h, right: 29.w, left: 29.w),
                  child: TextFormField(
                    controller: searchController,
                    onFieldSubmitted: _performSearch,
                    decoration: InputDecoration(
                        labelText: 'Search man fashion..',
                        suffixIcon: Icon(MdiIcons.magnify),
                        hintText: 'Search',
                        filled: true,
                        fillColor: const Color.fromRGBO(239, 239, 239, 1),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(18.r))),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromRGBO(43, 57, 185, 1),
                              width: 1.w),
                          borderRadius: BorderRadius.all(Radius.circular(18.r)),
                        )),
                  ),
                ),
                SizedBox(height: 22.h),

                // Tab 栏
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      children: tabList.map((tab) {
                        return GestureDetector(
                          onTap: () => onTabTapped(tab),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: TabItem(
                              text: tab.typeText,
                              iconPath: tab.typeIcon,
                              isSelected: selectedTabIndex == tab.tabIndex,
                              onTap: () => onTabTapped(tab),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // 产品列表
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: tabList.length,
                    onPageChanged: (index) {
                      setState(() {
                        selectedTabIndex = index;
                      });
                      // 页面切换时重新加载商品
                      _loadProducts();

                      // 调整滚动位置
                      final screenWidth = MediaQuery.of(context).size.width;
                      final tabWidth = 64.w + 16.w;
                      final maxScrollPosition = tabWidth * (tabList.length - 1);
                      double targetPosition =
                          (index * tabWidth) - screenWidth / 2 + tabWidth / 2;
                      targetPosition =
                          targetPosition.clamp(0.0, maxScrollPosition);

                      _scrollController.animateTo(
                        targetPosition,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 21.w),
                        child: ProductListView(
                          products: productDetailList,
                          isGridView: true,
                          scrollController: _cardScrollController,
                          onProductTap: _handleProductTap,
                          onViewChange: _changeView,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
