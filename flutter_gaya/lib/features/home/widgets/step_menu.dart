import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' show pi;

enum StepMenuType {
  shippingAddress,
  paymentMethod,
  couponApply,
}

class StepMenu extends StatefulWidget {
  final StepMenuType currentStep;

  const StepMenu({
    super.key,
    required this.currentStep,
  });

  @override
  State<StepMenu> createState() => _StepMenuState();
}

class _StepMenuState extends State<StepMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _positionAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _positionAnimation = Tween<double>(
      begin: _getStepPosition(context),
      end: _getStepPosition(context),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
  }

  @override
  void didUpdateWidget(StepMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentStep != widget.currentStep) {
      _positionAnimation = Tween<double>(
        begin: _positionAnimation.value,
        end: _getStepPosition(context),
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ));
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 计算文本宽度
  double _getTextWidth(String text, TextStyle style, BuildContext context) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.width;
  }

  // 动态计算滚动偏移量
  double _getScrollOffset(BuildContext context) {
    final spacing = 30.w;

    // 获取各个文本的宽度
    final shippingWidth = _getTextWidth(
      'Shipping Address',
      _getTextStyle(widget.currentStep == StepMenuType.shippingAddress),
      context,
    );
    final paymentWidth = _getTextWidth(
      'Payment Method',
      _getTextStyle(widget.currentStep == StepMenuType.paymentMethod),
      context,
    );
    final couponWidth = _getTextWidth(
      'Coupon Apply',
      _getTextStyle(widget.currentStep == StepMenuType.couponApply),
      context,
    );

    switch (widget.currentStep) {
      case StepMenuType.shippingAddress:
        return 0;
      case StepMenuType.paymentMethod:
        return -(shippingWidth - paymentWidth / 1.5);
      case StepMenuType.couponApply:
        return -(paymentWidth - couponWidth / 4);
    }
  }

  // 动态计算步骤指示器位置
  double _getStepPosition(BuildContext context) {
    // final padding = 35.w;
    // final spacing = 35.w;

    // 获取各个文本的宽度
    final shippingWidth = _getTextWidth(
      'Shipping Address',
      _getTextStyle(widget.currentStep == StepMenuType.shippingAddress),
      context,
    );
    final paymentWidth = _getTextWidth(
      'Payment Method',
      _getTextStyle(widget.currentStep == StepMenuType.paymentMethod),
      context,
    );
    final couponWidth = _getTextWidth(
      'Coupon Apply',
      _getTextStyle(widget.currentStep == StepMenuType.couponApply),
      context,
    );

    switch (widget.currentStep) {
      case StepMenuType.shippingAddress:
        return shippingWidth / 4; // 第一个文本中心
      case StepMenuType.paymentMethod:
        return shippingWidth + paymentWidth / 4 + 20.w; // 第二个文本中心
      case StepMenuType.couponApply:
        return shippingWidth + paymentWidth + couponWidth / 4; // 第三个文本中心
    }
  }

  TextStyle _getTextStyle(bool isSelected) {
    return TextStyle(
      color: isSelected ? Colors.black : const Color(0x6D777777),
      fontSize: 18.sp,
      fontFamily: 'Poppins',
      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
      letterSpacing: -0.24,
    );
  }

  @override
  Widget build(BuildContext context) {
    // 计算渐变的位置
    final gradientAlignment = widget.currentStep == StepMenuType.shippingAddress
        ? const Alignment(-1, 0)
        : widget.currentStep == StepMenuType.paymentMethod
            ? const Alignment(0, 0)
            : const Alignment(1, 0);

    return Column(
      children: [
        SizedBox(
          height: 68.h,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // 进度条
              Positioned(
                left: 0,
                right: 0,
                top: 52.h,
                child: Container(
                  height: 2.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: const Alignment(-1, 0),
                      end: const Alignment(1, 0),
                      colors: const [
                        Color(0x002B39B8), // 透明
                        Color(0xFF2B39B8), // 深色
                        Color(0x002B39B8), // 透明
                      ],
                      stops: [
                        0.0,
                        _getStepPosition(context) /
                            MediaQuery.of(context).size.width, // 根据指示器位置动态计算中心点
                        1.0,
                      ],
                    ),
                  ),
                ),
              ),
              // 步骤标题
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: _getScrollOffset(context),
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // 让 Row 适应内容宽度
                    children: [
                      const SizedBox(width: 3),
                      Text(
                        'Shipping Address',
                        style: _getTextStyle(
                            widget.currentStep == StepMenuType.shippingAddress),
                      ),
                      SizedBox(width: 35.w),
                      Text(
                        'Payment Method',
                        style: _getTextStyle(
                            widget.currentStep == StepMenuType.paymentMethod),
                      ),
                      SizedBox(width: 35.w),
                      Text(
                        'Coupon Apply',
                        style: _getTextStyle(
                            widget.currentStep == StepMenuType.couponApply),
                      ),
                    ],
                  ),
                ),
              ),
              // 步骤指示器 - 使用动态计算的位置
              AnimatedBuilder(
                animation: _positionAnimation,
                builder: (context, child) {
                  return Positioned(
                    left: _positionAnimation.value - 15.w,
                    top: 38.h,
                    child: child!,
                  );
                },
                child: SizedBox(
                  width: 30.w,
                  height: 30.h,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 5.w,
                        top: 5.h,
                        child: Container(
                          width: 20.w,
                          height: 20.h,
                          decoration: const ShapeDecoration(
                            color: Color(0xFF2B39B8),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 12.w,
                        top: 12.h,
                        child: Container(
                          width: 6.w,
                          height: 6.h,
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 30.w,
                          height: 30.h,
                          decoration: ShapeDecoration(
                            shape: OvalBorder(
                              side: BorderSide(
                                  width: 1.w, color: const Color(0x262B39B8)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
