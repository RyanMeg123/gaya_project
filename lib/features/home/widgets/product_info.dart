import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../models/tab_model.dart';

class ProductInfo extends StatefulWidget {
  final ProductDetail product;
  final String selectedSize;
  final Function(String) onSizeSelected;
  final bool isCollapsed;

  const ProductInfo({
    super.key,
    required this.product,
    required this.selectedSize,
    required this.onSizeSelected,
    this.isCollapsed = false,
  });

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Container(
      width: 392.w,
      height: double.infinity,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(34.r),
            topRight: Radius.circular(34.r),
          ),
        ),
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 拖动条指示器
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 12.h),
                width: 61.w,
                height: 6.h,
                decoration: ShapeDecoration(
                  color: const Color(0xFFDDDDDD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
            ),

            // 商品详情区域（始终显示）
            Container(
              width: 319.w,
              margin: EdgeInsets.only(top: 37.h, left: 28.w, right: 28.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 商品名称
                  SizedBox(
                    width: 252.w,
                    child: Text(
                      product.name ?? 'Product Name',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.24,
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // 价格和评分行
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 价格区域
                      Row(
                        children: [
                          Text(
                            '\$${product.discountPrice?.toStringAsFixed(1) ?? product.originalPrice?.toStringAsFixed(1) ?? '0.0'}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.24,
                            ),
                          ),
                          if (product.discountPrice != null) ...[
                            SizedBox(width: 8.w),
                            Text(
                              '\$${product.originalPrice?.toStringAsFixed(1)}',
                              style: TextStyle(
                                color: const Color(0xFF777777),
                                fontSize: 14.sp,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            if (product.discountAmount != null &&
                                product.discountAmount! > 0)
                              Container(
                                width: 41.w,
                                height: 25.h,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFE83737),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.r),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '${product.discountAmount}%',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ],
                      ),

                      // 收藏数量
                      Row(
                        children: [
                          Icon(
                            MdiIcons.star,
                            color: Colors.amber,
                            size: 24.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '${product.collectAmount ?? 0}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 23.h),

                  // 商品描述
                  SizedBox(
                    width: 319.w,
                    child: Text(
                      product.description ?? 'No description available',
                      style: TextStyle(
                        color: const Color(0xFF4D4D4D),
                        fontSize: 14.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Variant 部分（始终显示）
            Container(
              width: 375.w,
              height: 115.h,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Text(
                    'Variant',
                    style: TextStyle(
                      color: const Color(0xFF4D4D4D),
                      fontSize: 16.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildSizeButton(
                          'Small',
                          74.w,
                          isSelected: widget.selectedSize == 'Small',
                          onTap: () => widget.onSizeSelected('Small'),
                        ),
                        SizedBox(width: 10.w),
                        _buildSizeButton(
                          'Medium',
                          84.w,
                          isSelected: widget.selectedSize == 'Medium',
                          onTap: () => widget.onSizeSelected('Medium'),
                        ),
                        SizedBox(width: 10.w),
                        _buildSizeButton(
                          'Large',
                          74.w,
                          isDisabled: true,
                        ),
                        SizedBox(width: 10.w),
                        _buildSizeButton(
                          'Extra large',
                          102.w,
                          isSelected: widget.selectedSize == 'Extra large',
                          onTap: () => widget.onSizeSelected('Extra large'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Specifications 部分（仅在展开时显示）
            if (widget.isCollapsed) ...[
              // 分隔线
              AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: widget.isCollapsed ? 1.0 : 0.0,
                child: Container(
                  width: 375.w,
                  height: 1.h,
                  decoration: const BoxDecoration(color: Color(0xFFEFEFEF)),
                ),
              ),

              // Specifications 内容
              AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: widget.isCollapsed ? 1.0 : 0.0,
                child: Container(
                  width: 375.w,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      Text(
                        'Specifications',
                        style: TextStyle(
                          color: const Color(0xFF4D4D4D),
                          fontSize: 16.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 18.h),
                      _buildSpecificationItem(
                          'Brand', product.name?.split(' ')[0] ?? 'Brand'),
                      SizedBox(height: 8.h),
                      _buildSpecificationItem('Stock',
                          '${product.stockQuantity ?? "Out of stock"}'),
                      SizedBox(height: 8.h),
                      _buildSpecificationItem('Condition',
                          product.status?.name.toUpperCase() ?? 'NEW'),
                      SizedBox(height: 8.h),
                      _buildSpecificationItem(
                          'Category', product.category ?? 'Unknown',
                          isHighlighted: true),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // 修改尺寸按钮构建方法
  Widget _buildSizeButton(String size, double width,
      {bool isSelected = false, bool isDisabled = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        width: width,
        height: 38.h,
        decoration: ShapeDecoration(
          color: isDisabled
              ? const Color(0xFFEAEAEA)
              : isSelected
                  ? const Color(0xFFD1D5FF)
                  : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: isDisabled ? Colors.transparent : const Color(0xFF2B39B8),
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Center(
          child: Text(
            size,
            style: TextStyle(
              color: isDisabled
                  ? const Color(0xFF9B9B9B)
                  : const Color(0xFF2B39B8),
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  // 规格项构建方法
  Widget _buildSpecificationItem(String label, String value,
      {bool isHighlighted = false}) {
    return SizedBox(
      width: 319.w,
      height: 20.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: isHighlighted
                  ? const Color(0xFF2B39B8)
                  : const Color(0xFF777777),
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
