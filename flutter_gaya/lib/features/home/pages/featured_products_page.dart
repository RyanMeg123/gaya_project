import 'package:flutter/material.dart';
import 'package:flutter_gaya_2/features/home/controllers/cart_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../controllers/featured_products_controller.dart';
import '../widgets/product_detail.dart';
import '../../../models/tab_model.dart';

class FeaturedProductsPage extends StatefulWidget {
  const FeaturedProductsPage({super.key});

  @override
  State<FeaturedProductsPage> createState() => _FeaturedProductsPageState();
}

class _FeaturedProductsPageState extends State<FeaturedProductsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  final List<String> _tabs = [
    'All',
    'FlashSale',
    'Man Fashion',
    'Women Fashion'
  ];
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          selectedTabIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // 替换原来的标签栏部分
  Widget _buildTabBar() {
    return Container(
      height: 47.h,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        labelColor: const Color(0xFF2B39B8),
        unselectedLabelColor: const Color(0xFF777777),
        labelStyle: TextStyle(
          fontSize: 18.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 18.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 3.h,
            color: const Color(0xFF2B39B8),
          ),
          insets: EdgeInsets.symmetric(horizontal: 15.w),
        ),
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FeaturedProductsController>(
      builder: (context, controller, child) {
        final products = selectedTabIndex == 0
            ? controller.allProducts
            : controller.getProductsByCategory(_tabs[selectedTabIndex]);

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Featured Products',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(MdiIcons.arrowLeft, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 30,
              ),

              // 促销卡片
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.w),
                height: 105.h,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // 底层卡片
                    Container(
                      decoration: ShapeDecoration(
                        gradient: const RadialGradient(
                          center: Alignment(0.40, 0.50),
                          radius: 0.55,
                          colors: [Color(0xFF2B39B8), Color(0xFF17228B)],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                      ),
                    ),
                    // 促销文本
                    Positioned(
                      left: 106.w,
                      top: 14.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PROMOTION',
                            style: TextStyle(
                              color: const Color(0xFF81C2FF),
                              fontSize: 12.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            'Summers Sale',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.24,
                            ),
                          ),
                          // SizedBox(height: 5.h),
                          Row(
                            children: [
                              Text(
                                '80%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.24,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                'OFF',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.24,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // 立绘图片放在最上层
                    Positioned(
                      left: -38,
                      top: -40.h, // 向上偏移，使立绘超出卡片顶部
                      child: Image.asset(
                        'assets/images/home/promotion.png',
                        height: 145.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 33),

              // 使用新的标签栏
              _buildTabBar(),

              // 商品网格使用 Expanded 和 TabBarView
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: _tabs.map((tab) {
                    final tabProducts = tab == 'All'
                        ? controller.allProducts
                        : controller.getProductsByCategory(tab);
                    return GridView.builder(
                      padding: EdgeInsets.all(13.w),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20.h,
                        crossAxisSpacing: 20.w,
                        childAspectRatio: 157 / 187,
                      ),
                      itemCount: tabProducts.length,
                      itemBuilder: (context, index) {
                        final product = tabProducts[index];
                        return _buildProductCard(product);
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductCard(ProductDetails product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailWidget(
              product: product,
              cartController: Provider.of<CartController>(context, listen: false),
              onFavoritePressed: () {
                // 处理收藏逻辑
              },
              onAddToCartPressed: () {
                // 处理添加到购物车逻辑
              },
            ),
          ),
        );
      },
      child: Container(
        decoration: ShapeDecoration(
          color: const Color(0xFFC4C4C4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.r),
          ),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18.r),
              child: Image.asset(
                product.imageUrl ?? '',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // 渐变遮罩
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 65.h,
              child: Container(
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: const Alignment(0.00, -1.00),
                    end: const Alignment(0, 1),
                    colors: [Colors.black.withOpacity(0), Colors.black],
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                  ),
                ),
              ),
            ),
            // 商品信息
            Positioned(
              left: 19.w,
              bottom: 26.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '\$${product.originalPrice?.toStringAsFixed(1)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
