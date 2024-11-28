import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gaya_2/features/home/widgets/product_card.dart';
import 'package:flutter_gaya_2/features/home/widgets/tab_item.dart';
import 'package:flutter_gaya_2/models/tab_model.dart';
import 'package:flutter_gaya_2/routes.dart';
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
  final TextEditingController searchController = TextEditingController();
  int selectedTabIndex = 0;
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  final ScrollController _cardScrollController = ScrollController();
  bool isGridView = false;

  List<TabIconItem> tabList = [
    TabIconItem(
        typeText: 'TShirt',
        typeIcon: 'assets/images/home/shirt_1.png',
        tabIndex: 0),
    TabIconItem(
        typeText: 'Shoes',
        typeIcon: 'assets/images/home/shoe_1.png',
        tabIndex: 1),
    TabIconItem(
        typeText: 'Bag',
        typeIcon: 'assets/images/home/womanbag_1.png',
        tabIndex: 2),
    TabIconItem(
        typeText: 'Dress',
        typeIcon: 'assets/images/home/dress_1.png',
        tabIndex: 3),
    TabIconItem(
        typeText: 'Watch',
        typeIcon: 'assets/images/home/hand_watch.png',
        tabIndex: 4),
  ];
  List<ProductDetail> productDetailList = [
    ProductDetails(
        productId: 1,
        name: 'Naiki White Pro Sneakers ',
        imageUrl: 'assets/images/home/product1.png',
        originalPrice: 170.0,
        discountPrice: 158.2,
        discountAmount: 15,
        collectAmount: 245),
    ProductDetails(
        productId: 31,
        name: 'Naiki White Pro Sneakers ',
        imageUrl: 'assets/images/home/product2.png',
        originalPrice: 170.0,
        discountPrice: 158.2,
        discountAmount: 15,
        collectAmount: 245),
    ProductDetails(
        productId: 41,
        name: 'Naiki White Pro Sneakers ',
        imageUrl: 'assets/images/home/product3.png',
        originalPrice: 170.0,
        discountPrice: 158.2,
        discountAmount: 15,
        collectAmount: 245),
    ProductDetails(
        productId: 51,
        name: 'Naiki White Pro Sneakers ',
        imageUrl: 'assets/images/home/product4.png',
        originalPrice: 170.0,
        discountPrice: 158.2,
        discountAmount: 15,
        collectAmount: 245)
  ];

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

  @override
  Widget build(BuildContext context) {
    final productParameter = widget.productRouteParameter;
    print('Received parameter: ${productParameter.cardIndex}');

    void onTabTapped(tab) {
      print('tab ${tab.toString()}');
      setState(() {
        selectedTabIndex = tab.tabIndex;
      });
      print('current $selectedTabIndex');
      _pageController.jumpToPage(tab.tabIndex);
    }

    print('Argument: $productParameter');
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              'Products',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(CupertinoIcons.back)),
            // backgroundColor: Colors.pink[100],
            actions: [
              IconButton(onPressed: () {}, icon: Icon(MdiIcons.dotsVertical))
            ]),
        body: SizedBox(
          height: double.infinity,
          // color: Colors.amber,
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: 22.h, right: 29.w, left: 29.w),
                    child: TextFormField(
                      controller: searchController,
                      onFieldSubmitted: (value) {
                        print('搜索的内容 $value');
                        _performSearch(value);
                      },
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(18.r)),
                          )),
                    ),
                  ),
                  SizedBox(height: 22.h),

                  // Scrollable TabBar
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Row(
                        children: tabList.map((tab) {
                          return GestureDetector(
                              onTap: () {
                                _pageController.jumpToPage(tab.tabIndex);
                                setState(() {
                                  selectedTabIndex = tab.tabIndex;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: TabItem(
                                    text: tab.typeText,
                                    iconPath: tab.typeIcon,
                                    isSelected:
                                        selectedTabIndex == tab.tabIndex,
                                    onTap: () => onTabTapped(tab)),
                              ));
                        }).toList(),
                      ),
                    ),
                  ),
                  // Animated Tab Indicator

                  SizedBox(height: 50.h),
                ],
              ),

              // TabBarView content
              Expanded(
                flex: 1,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: tabList.length,
                  onPageChanged: (index) {
                    setState(() {
                      selectedTabIndex = index;
                    });
                    // Adjust the scroll position of the SingleChildScrollView
                    final screenWidth = MediaQuery.of(context).size.width;
                    print('screenWidth $screenWidth');
                    final tabWidth = 64.w + 16.w; // 每个tab的宽度
                    final maxScrollPosition =
                        tabWidth * (tabList.length - 1); // 最大滚动位置
                    double targetPosition =
                        (index * tabWidth) - screenWidth / 2 + tabWidth / 2;

                    // 防止超出最大滚动位置
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
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 150.w,
                                    child: Text('1300 products',
                                        softWrap: true,
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text('Based your filter',
                                      style: TextStyle(
                                          color: const Color.fromRGBO(
                                              119, 119, 119, 1),
                                          fontSize: 14.sp))
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => _changeView('column'),
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: 48.w,
                                        height: 48.h,
                                        // padding: EdgeInsets.symmetric(
                                        //     vertical: 22.sp, horizontal: 12.sp),
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 1),
                                          border: Border.all(
                                            color: isGridView
                                                ? Colors.grey
                                                : const Color.fromRGBO(
                                                    43, 57, 185, 1),
                                            width: 1.w,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                        ),
                                        child: Icon(MdiIcons.viewSequential,
                                            color: !isGridView
                                                ? const Color.fromRGBO(
                                                    43, 57, 185, 1)
                                                : Colors.grey)),
                                  ),
                                  SizedBox(width: 8.w),
                                  GestureDetector(
                                    onTap: () => _changeView('grid'),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 48.w,
                                      height: 48.h,
                                      // padding: EdgeInsets.symmetric(
                                      //     vertical: 22.sp, horizontal: 12.sp),
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        border: Border.all(
                                          color: !isGridView
                                              ? Colors.grey
                                              : const Color.fromRGBO(
                                                  43, 57, 185, 1),
                                          width: 1.w,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      child: Icon(MdiIcons.viewGrid,
                                          color: isGridView
                                              ? const Color.fromRGBO(
                                                  43, 57, 185, 1)
                                              : Colors.grey),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          // 初始为单列模式

                          Flexible(
                            child: ListView.builder(
                              controller: _cardScrollController,
                              itemCount: (productDetailList.length /
                                      (isGridView ? 2 : 1))
                                  .ceil(),
                              itemBuilder: (context, index) {
                                if (isGridView &&
                                    index * 2 + 1 < productDetailList.length) {
                                  // 双列模式：显示两个 `ProductCard` 并排
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: ProductCard(
                                          isGridView: isGridView,
                                          productId:
                                              productDetailList[index * 2]
                                                  .productId,
                                          productImg:
                                              productDetailList[index * 2]
                                                      .imageUrl ??
                                                  '',
                                          name: productDetailList[index * 2]
                                                  .name ??
                                              '',
                                          discountAmount:
                                              productDetailList[index * 2]
                                                      .discountAmount ??
                                                  0,
                                          originalPrice:
                                              productDetailList[index * 2]
                                                      .originalPrice ??
                                                  0,
                                          discountPrice:
                                              productDetailList[index * 2]
                                                      .discountPrice ??
                                                  0,
                                          collectAmount:
                                              productDetailList[index * 2]
                                                      .collectAmount ??
                                                  0,
                                          onTap: () => _handleProductTap(
                                              productDetailList[index * 2]),
                                        ),
                                      ),
                                      SizedBox(width: 10.w), // 卡片之间的间距
                                      Expanded(
                                        child: ProductCard(
                                          isGridView: isGridView,
                                          productId:
                                              productDetailList[index * 2 + 1]
                                                  .productId,
                                          productImg:
                                              productDetailList[index * 2 + 1]
                                                      .imageUrl ??
                                                  '',
                                          name: productDetailList[index * 2 + 1]
                                                  .name ??
                                              '',
                                          discountAmount:
                                              productDetailList[index * 2 + 1]
                                                      .discountAmount ??
                                                  0,
                                          originalPrice:
                                              productDetailList[index * 2 + 1]
                                                      .originalPrice ??
                                                  0,
                                          discountPrice:
                                              productDetailList[index * 2 + 1]
                                                      .discountPrice ??
                                                  0,
                                          collectAmount:
                                              productDetailList[index * 2 + 1]
                                                      .collectAmount ??
                                                  0,
                                          onTap: () => _handleProductTap(
                                              productDetailList[index * 2 + 1]),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  // 单列模式：显示一个 `ProductCard`
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ProductCard(
                                      isGridView: isGridView,
                                      productId:
                                          productDetailList[index].productId,
                                      productImg:
                                          productDetailList[index].imageUrl ??
                                              '',
                                      name: productDetailList[index].name ?? '',
                                      discountAmount: productDetailList[index]
                                              .discountAmount ??
                                          0,
                                      originalPrice: productDetailList[index]
                                              .originalPrice ??
                                          0,
                                      discountPrice: productDetailList[index]
                                              .discountPrice ??
                                          0,
                                      collectAmount: productDetailList[index]
                                              .collectAmount ??
                                          0,
                                      onTap: () => _handleProductTap(
                                          productDetailList[index]),
                                    ),
                                  );
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
