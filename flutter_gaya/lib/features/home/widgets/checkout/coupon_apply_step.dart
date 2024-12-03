import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../models/tab_model.dart';

class CouponApplyStep extends StatefulWidget {
  final OrderItem orderItem;
  final Function(double)? onDiscountChanged;

  const CouponApplyStep({
    super.key,
    required this.orderItem,
    this.onDiscountChanged,
  });

  @override
  State<CouponApplyStep> createState() => _CouponApplyStepState();
}

class _CouponApplyStepState extends State<CouponApplyStep> {
  final TextEditingController _couponController = TextEditingController();
  bool _isCouponApplied = false;
  double _discountAmount = 0;
  bool _isValidating = false;

  Future<bool> _validateCoupon(String code) async {
    setState(() => _isValidating = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isValidating = false);

    final validCoupons = {
      'SAVE10': 0.1,
      'SAVE20': 0.2,
      'SAVE30': 0.3,
    };

    return validCoupons.containsKey(code.toUpperCase());
  }

  double _calculateDiscount(String code) {
    final discountRates = {
      'SAVE10': 0.1,
      'SAVE20': 0.2,
      'SAVE30': 0.3,
    };

    final rate = discountRates[code.toUpperCase()] ?? 0.0;
    return widget.orderItem.totalPrice * rate;
  }

  Future<void> _applyCoupon() async {
    final code = _couponController.text.trim();
    if (code.isEmpty) {
      _showMessage('Please enter a coupon code', isError: true);
      return;
    }

    if (_isValidating) return;

    final isValid = await _validateCoupon(code);
    if (isValid) {
      setState(() {
        _isCouponApplied = true;
        _discountAmount = _calculateDiscount(code);
      });
      widget.onDiscountChanged?.call(_discountAmount);
      _showMessage('Coupon applied successfully!');
    } else {
      _showMessage('Invalid coupon code', isError: true);
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontSize: 14.sp,
            fontFamily: 'Poppins',
          ),
        ),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        margin: EdgeInsets.all(20.w),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
          // 优惠券输入框
          Container(
            height: 60.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFF2B39B8),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _couponController,
                    decoration: InputDecoration(
                      hintText: 'Enter coupon code',
                      hintStyle: TextStyle(
                        color: const Color(0xFF777777),
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    ),
                    textCapitalization: TextCapitalization.characters,
                    onSubmitted: (_) => _applyCoupon(),
                  ),
                ),
                Container(
                  width: 100.w,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2B39B8),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(18.r),
                      bottomRight: Radius.circular(18.r),
                    ),
                  ),
                  child: TextButton(
                    onPressed: _isValidating ? null : _applyCoupon,
                    child: _isValidating
                        ? SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Apply',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 30.h),

          // 订单摘要
          Text(
            'Order Summary',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20.h),

          // 订单详情
          _buildOrderSummaryItem(
            'Subtotal',
            '\$${widget.orderItem.totalPrice.toStringAsFixed(1)}',
          ),
          SizedBox(height: 12.h),
          _buildOrderSummaryItem(
            'Shipping',
            'Free',
            valueColor: const Color(0xFF1DB73F),
          ),
          if (_isCouponApplied) ...[
            SizedBox(height: 12.h),
            _buildOrderSummaryItem(
              'Discount',
              '-\$${_discountAmount.toStringAsFixed(1)}',
              valueColor: const Color(0xFFE83737),
            ),
          ],
          SizedBox(height: 20.h),

          // 总计
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xFFE8E8E8),
                  width: 1,
                ),
              ),
            ),
            child: _buildOrderSummaryItem(
              'Total',
              '\$${(widget.orderItem.totalPrice - _discountAmount).toStringAsFixed(1)}',
              titleStyle: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
              valueStyle: TextStyle(
                color: Colors.black,
                fontSize: 24.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummaryItem(
    String title,
    String value, {
    Color? valueColor,
    TextStyle? titleStyle,
    TextStyle? valueStyle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: titleStyle ??
              TextStyle(
                color: const Color(0xFF777777),
                fontSize: 16.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
        ),
        Text(
          value,
          style: valueStyle ??
              TextStyle(
                color: valueColor ?? Colors.black,
                fontSize: 16.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }
}
