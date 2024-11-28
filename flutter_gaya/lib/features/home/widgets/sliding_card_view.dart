import 'package:flutter/material.dart';
import 'package:flutter_gaya_2/features/home/widgets/rating_widget.dart';
import 'package:flutter_gaya_2/models/tab_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

class SlidingCard extends StatelessWidget {
  final double offset;
  final ProductDetails products;
  const SlidingCard({super.key, required this.offset, required this.products});

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    var v = -40 + (-2 * gauss * offset.sign);
    return Transform.translate(
      offset: Offset(v.w, 0),
      child: SizedBox(
        width: 206.w,
        child: Card(
          margin: EdgeInsets.only(right: 20.w),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(18.r),
                ),
                child: Image.asset(
                  products.imageUrl ?? '',
                  height: 152.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 159.w,
                        child: Text(
                          products.name ?? '',
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${products.originalPrice?.toStringAsFixed(1) ?? '0.0'}',
                            style: TextStyle(
                              color: const Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${products.stockQuantity ?? 0}',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(43, 57, 185, 1),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                WidgetSpan(
                                  child: SizedBox(width: 4.w),
                                ),
                                TextSpan(
                                  text: 'left',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(123, 123, 123, 1),
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      RatingWidget(rating: products.stockQuantity?.toDouble() ?? 0.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
