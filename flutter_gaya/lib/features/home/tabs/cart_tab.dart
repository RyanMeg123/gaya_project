import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../../../models/tab_model.dart';
import '../controllers/cart_controller.dart';
import '../pages/checkout_page.dart';
import '../../../routes.dart';
import '../pages/tracking_order_page.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  final List<String> _tabs = ['All', 'Pending', 'On Delivery', 'Done'];
  int selectedTabIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      selectedTabIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
      builder: (context, cartController, child) {
        final allOrders = cartController.cartItems;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Cart',
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
            automaticallyImplyLeading: false,
          ),
          body: Column(
            children: [
              // 标签栏
              Container(
                height: 51.h,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFFE0E0E0),
                      width: 1,
                    ),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: 19.w),
                      ..._tabs.asMap().entries.map((entry) {
                        final index = entry.key;
                        final text = entry.value;
                        return Stack(
                          children: [
                            GestureDetector(
                              onTap: () => onTabTapped(index),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      text,
                                      style: TextStyle(
                                        color: selectedTabIndex == index
                                            ? const Color(0xFF2B39B8)
                                            : const Color(0xFF777777),
                                        fontSize: 18.sp,
                                        fontFamily: 'Poppins',
                                        fontWeight: selectedTabIndex == index
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                      ),
                                    ),
                                    if (selectedTabIndex == index)
                                      Container(
                                        margin: EdgeInsets.only(top: 14.h),
                                        width: 67.w,
                                        height: 3.h,
                                        color: const Color(0xFF2B39B8),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                      SizedBox(width: 4.w),
                    ],
                  ),
                ),
              ),

              // 订单列表
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      selectedTabIndex = index;
                    });
                  },
                  children: [
                    // All 标签页
                    _buildOrderList(allOrders),
                    // Pending 标签页
                    _buildOrderList(_getPendingOrders(allOrders)),
                    // On Delivery 标签页
                    _buildOrderList(_getOnDeliveryOrders(allOrders)),
                    // Done 标签页
                    _buildOrderList(_getDoneOrders(allOrders)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOrderCard({
    required String orderNumber,
    required String status,
    required String productImage,
    required String productName,
    required String variant,
    required String price,
    String? originalPrice,
    required int itemCount,
    required double totalPrice,
    Color statusColor = Colors.black,
  }) {
    return GestureDetector(
      onTap: () {
        if (status == 'PENDING') {
          Navigator.pushNamed(
            context,
            AppRoutes.checkout,
            arguments: OrderItem(
              orderNumber: orderNumber,
              status: status,
              productImage: productImage,
              productName: productName,
              variant: variant,
              price: price,
              originalPrice: originalPrice,
              itemCount: itemCount,
              totalPrice: totalPrice,
            ),
          );
        } else if (status == 'ON DELIVERY') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TrackingOrderPage(
                orderItem: OrderItem(
                  orderNumber: orderNumber,
                  status: status,
                  productImage: productImage,
                  productName: productName,
                  variant: variant,
                  price: price,
                  originalPrice: originalPrice,
                  itemCount: itemCount,
                  totalPrice: totalPrice,
                ),
              ),
            ),
          );
        }
      },
      child: Container(
        width: 376.w,
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 6,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            // 订单号和状态
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '#$orderNumber',
                    style: TextStyle(
                      color: const Color(0xFF777777),
                      fontSize: 16.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 16.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // 商品信息
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 29.w),
              child: Row(
                children: [
                  // 商品图片
                  Container(
                    width: 56.w,
                    height: 87.h,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFCECECE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: productImage.startsWith('http')
                          ? Image.network(
                              productImage,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/home/product1.png',
                                  fit: BoxFit.cover,
                                );
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            )
                          : Image.asset(
                              productImage,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(width: 20.w),

                  // 商品详情
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 26.h),
                        Row(
                          children: [
                            // 变体标签
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15.w,
                                vertical: 5.h,
                              ),
                              decoration: ShapeDecoration(
                                color: const Color(0xFFD1D5FF),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: Color(0xFF2B39B8),
                                  ),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              child: Text(
                                variant,
                                style: TextStyle(
                                  color: const Color(0xFF2B39B8),
                                  fontSize: 14.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const Spacer(),
                            if (originalPrice != null) ...[
                              Text(
                                originalPrice,
                                style: TextStyle(
                                  color: const Color(0xFF777777),
                                  fontSize: 14.sp,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              SizedBox(width: 8.w),
                            ],
                            Text(
                              price,
                              style: TextStyle(
                                color: const Color(0xFF777777),
                                fontSize: 16.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.24,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 分隔线
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 28.w,
                vertical: 20.h,
              ),
              height: 1.h,
              color: const Color(0xFFF3F3F3),
            ),

            // 总价
            Padding(
              padding: EdgeInsets.only(
                left: 29.w,
                right: 29.w,
                bottom: 20.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Price ($itemCount Item)',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '\$${totalPrice.toStringAsFixed(1)}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
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

  Widget _buildOrderList(List<OrderItem> orders) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        vertical: 20.h,
        horizontal: 16.w,
      ),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _buildOrderCard(
          orderNumber: order.orderNumber,
          status: order.status,
          productImage: order.productImage,
          productName: order.productName,
          variant: order.variant,
          price: order.price,
          originalPrice: order.originalPrice,
          itemCount: order.itemCount,
          totalPrice: order.totalPrice,
          statusColor: _getStatusColor(order.status),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'ON DELIVERY':
        return const Color(0xFF2B39B8);
      case 'PENDING':
        return const Color(0xFF5B5B5B);
      case 'DONE':
        return const Color(0xFF1DB73F);
      default:
        return Colors.black;
    }
  }

  List<OrderItem> _getPendingOrders(List<OrderItem> orders) {
    return orders.where((order) => order.status == 'PENDING').toList();
  }

  List<OrderItem> _getOnDeliveryOrders(List<OrderItem> orders) {
    return orders.where((order) => order.status == 'ON DELIVERY').toList();
  }

  List<OrderItem> _getDoneOrders(List<OrderItem> orders) {
    return orders.where((order) => order.status == 'DONE').toList();
  }
}
