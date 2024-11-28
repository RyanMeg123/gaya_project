import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gaya_2/features/home/widgets/sliding_card_view.dart';
import 'package:flutter_gaya_2/models/tab_model.dart';
import 'package:flutter_gaya_2/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../widgets/product_detail.dart';
import '../controllers/cart_controller.dart';

class FeaturedProduct extends StatefulWidget {
  final List<ProductDetails> products;
  const FeaturedProduct({super.key, required this.products});

  @override
  State<StatefulWidget> createState() {
    return _FeaturedProductState();
  }
}

class _FeaturedProductState extends State<FeaturedProduct> {
  late PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.7);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page!);
    });
  }

  void _handleProductTap(ProductDetails product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailWidget(
          product: ProductDetails(
            productId: product.productId,
            name: product.name,
            description: product.description,
            originalPrice: product.discountPrice,
            imageUrl: product.imageUrl,
            collectAmount: product.collectAmount,
            stockQuantity: product.stockQuantity,
            status: ProductStatus.available,
            category: 'Featured',
          ),
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 28, right: 28, bottom: 8),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Featured Products',
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                      fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.featuredProducts);
                },
                child: Text('More',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color.fromRGBO(43, 57, 185, 1),
                        fontWeight: FontWeight.bold)),
              )
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 300.h,
            child: PageView(
              controller: pageController,
              children: List.generate(widget.products.length, (index) {
                return GestureDetector(
                  onTap: () => _handleProductTap(widget.products[index]),
                  child: SlidingCard(
                    offset: pageOffset - index,
                    products: widget.products[index],
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
