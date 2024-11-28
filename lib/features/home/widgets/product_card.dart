import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProductCard extends StatefulWidget {
  final bool isGridView;
  final int productId;
  final String productImg;
  final String name;
  final double discountAmount;
  final double originalPrice;
  final double discountPrice;
  final int collectAmount;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.isGridView,
    required this.productId,
    required this.productImg,
    required this.name,
    required this.discountAmount,
    required this.originalPrice,
    required this.discountPrice,
    required this.collectAmount,
    this.onTap,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  double cardHeight = 0.0;
  double cardWidth = 179.w; // 默认宽度

  @override
  Widget build(BuildContext context) {
    // 判断是否是 Grid 模式，根据模式选择宽度和高度
    cardWidth = widget.isGridView ? 179.w : MediaQuery.of(context).size.width;

    // 计算图片高度
    double imageHeight = cardWidth * (157 / 152); // 假设宽高比为1.5

    // 总高度 = 图片高度 + 剩余内容的高度
    double totalHeight = imageHeight + 160.h; // 假设剩余部分高度为200
    return SizedBox(
      height: totalHeight,
      width: cardWidth,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Card(
          elevation: 3,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 299.h, maxWidth: 179.w),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(18.r),
                  ),
                  child: Image.asset(
                    widget.productImg,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: imageHeight, // 图片的动态高度
                  ),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.all(8.h),
                  child: Column(
                    children: [
                      SizedBox(
                        // color: Colors.red,
                        width: cardWidth * 0.85, // 根据宽度调整文字显示
                        child: Text(
                          widget.name,
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: const Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                '\$${widget.discountPrice.toString()}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 16.sp),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                '\$${widget.originalPrice.toString()}',
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color:
                                        const Color.fromRGBO(119, 119, 119, 1),
                                    fontSize: 12.sp),
                              )
                            ],
                          ),
                          Container(
                            width: 35.w,
                            height: 21.h,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(233, 55, 55, 1),
                              borderRadius: BorderRadius.circular(3.w),
                            ),
                            child: Center(
                              child: Text(
                                  '${widget.discountAmount.toStringAsFixed(0)}%',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                  )),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(MdiIcons.star, color: Colors.amber),
                              Text(
                                '(${widget.collectAmount})',
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color:
                                        const Color.fromRGBO(119, 119, 119, 1)),
                              )
                            ],
                          ),
                          Icon(MdiIcons.heart,
                              color: const Color.fromRGBO(43, 57, 185, 1))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
