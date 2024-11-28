import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProductBottomBar extends StatelessWidget {
  final VoidCallback? onAddToCartPressed;
  final VoidCallback? onBuyNowPressed;

  const ProductBottomBar({
    super.key,
    this.onAddToCartPressed,
    this.onBuyNowPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      height: 105.h,
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x07000000),
            blurRadius: 15,
            offset: Offset(0, -7),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 5.h),
          Row(
            children: [
              SizedBox(width: 29.w),
              // 购物车按钮
              GestureDetector(
                onTap: onAddToCartPressed,
                child: Container(
                  width: 93.w,
                  height: 60.h,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1,
                        color: Color(0xFFFF6712),
                      ),
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      MdiIcons.cartOutline,
                      color: const Color(0xFFFF6712),
                      size: 28.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              // 购买按钮
              Expanded(
                child: GestureDetector(
                  onTap: onBuyNowPressed,
                  child: Container(
                    height: 60.h,
                    margin: EdgeInsets.only(right: 29.w),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF2B39B8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x4F2B39B8),
                          blurRadius: 22,
                          offset: Offset(0, 13),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'BUY NOW',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
