import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryProgress extends StatelessWidget {
  final double progress; // 0.0 到 1.0 之间的值
  final List<String> steps = [
    'Order\nConfirmed',
    'Preparing\nOrder',
    'On The\nWay',
    'Delivered'
  ];

  DeliveryProgress({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery Progress',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20.h),
          LayoutBuilder(
            builder: (context, constraints) {
              final availableWidth = constraints.maxWidth;
              final stepWidth = availableWidth / steps.length;
              
              return Stack(
                children: [
                  // 背景线
                  Container(
                    height: 2.h,
                    color: const Color(0xFFE0E0E0),
                  ),
                  // 进度线
                  Container(
                    height: 2.h,
                    width: availableWidth * progress,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF2B39B8),
                          Color(0xFF2B39B8),
                        ],
                      ),
                    ),
                  ),
                  // 步骤点
                  SizedBox(
                    height: 70.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        steps.length,
                        (index) {
                          final stepProgress = index / (steps.length - 1);
                          final isCompleted = progress >= stepProgress;
                          final isCurrent = index == (progress * (steps.length - 1)).floor();

                          return SizedBox(
                            width: stepWidth,
                            child: Column(
                              children: [
                                Container(
                                  width: 24.w,
                                  height: 24.h,
                                  decoration: BoxDecoration(
                                    color: isCompleted ? const Color(0xFF2B39B8) : Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isCompleted ? const Color(0xFF2B39B8) : const Color(0xFFE0E0E0),
                                      width: 2,
                                    ),
                                  ),
                                  child: isCurrent
                                      ? Center(
                                          child: Container(
                                            width: 8.w,
                                            height: 8.h,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        )
                                      : isCompleted
                                          ? Icon(
                                              Icons.check,
                                              size: 16.sp,
                                              color: Colors.white,
                                            )
                                          : null,
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  steps[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: isCompleted ? const Color(0xFF2B39B8) : const Color(0xFF777777),
                                    fontSize: 12.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: isCompleted ? FontWeight.w600 : FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
} 