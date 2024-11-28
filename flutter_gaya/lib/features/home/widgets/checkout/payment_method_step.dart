import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PaymentMethodStep extends StatefulWidget {
  final Function(String method, int cardIndex)? onMethodSelected;
  final double totalAmount;
  final double? shippingFee;
  final double? discount;

  const PaymentMethodStep({
    super.key,
    this.onMethodSelected,
    required this.totalAmount,
    this.shippingFee,
    this.discount,
  });

  @override
  State<PaymentMethodStep> createState() => _PaymentMethodStepState();
}

class _PaymentMethodStepState extends State<PaymentMethodStep>
    with SingleTickerProviderStateMixin {
  String _selectedMethod = 'Credit Card';
  int _selectedCardIndex = 0;
  late final PageController _cardController;
  late final AnimationController _animationController;
  late final Animation<double> _cardAnimation;

  @override
  void initState() {
    super.initState();
    _cardController = PageController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _cardAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _cardController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _selectMethod(String method) {
    if (_selectedMethod == method) return;

    setState(() {
      _selectedMethod = method;
      if (method == 'Credit Card') {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });

    widget.onMethodSelected?.call(method, _selectedCardIndex);
  }

  double get finalAmount {
    double total = widget.totalAmount;
    if (widget.shippingFee != null) {
      total += widget.shippingFee!;
    }
    if (widget.discount != null) {
      total -= widget.discount!;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 信用卡轮播
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _selectedMethod == 'Credit Card'
                ? Column(
                    children: [
                      SizedBox(height: 20.h),
                      SizedBox(
                        height: 168.h,
                        child: PageView(
                          controller: _cardController,
                          onPageChanged: (index) {
                            setState(() {
                              _selectedCardIndex = index;
                              widget.onMethodSelected
                                  ?.call(_selectedMethod, index);
                            });
                          },
                          children: [
                            // 第一张卡
                            _buildCreditCard(
                              gradient: const LinearGradient(
                                begin: Alignment(-0.95, -0.30),
                                end: Alignment(0.95, 0.3),
                                colors: [
                                  Color(0x7CFF9191),
                                  Color(0x7C780E7A),
                                  Color(0xFF57009C)
                                ],
                              ),
                              bankName: 'ABC Bank',
                              cardNumber: '1234 **** **** ****',
                              expiryDate: '04 / 25',
                              holderName: 'KEVIN HARD',
                            ),
                            // 第二张卡
                            _buildCreditCard(
                              gradient: const LinearGradient(
                                begin: Alignment(-0.95, -0.30),
                                end: Alignment(0.95, 0.3),
                                colors: [
                                  Color(0xFF3A3A3A),
                                  Color(0xFF454545),
                                  Color(0xFF3A3A3A)
                                ],
                              ),
                              bankName: 'Black Card',
                              cardNumber: '1234 **** **** ****',
                              expiryDate: '04 / 25',
                              holderName: 'KEVIN HARD',
                              isGoldCard: true,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      // 卡片指示器
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            2, (index) => _buildDotIndicator(index)),
                      ),
                    ],
                  )
                : const SizedBox(),
          ),

          SizedBox(height: 24.h),

          // 支付方式选项
          _buildPaymentOption(
            'Credit Card',
            MdiIcons.creditCard,
          ),
          _buildPaymentOption('Bank Transfer', MdiIcons.accountBadge),
          _buildPaymentOption(
            'Virtual Account',
            Icons.account_balance_wallet,
          ),

          // 订单金额明细
          SizedBox(height: 30.h),
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
            child: Column(
              children: [
                // 小计
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal',
                      style: TextStyle(
                        color: const Color(0xFF777777),
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '\$${widget.totalAmount.toStringAsFixed(1)}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                // 运费
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shipping',
                      style: TextStyle(
                        color: const Color(0xFF777777),
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      widget.shippingFee != null 
                          ? '\$${widget.shippingFee!.toStringAsFixed(1)}'
                          : 'Free',
                      style: TextStyle(
                        color: const Color(0xFF1DB73F),
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                // 如果有折扣，显示折扣行
                if (widget.discount != null && widget.discount! > 0) ...[
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Discount',
                        style: TextStyle(
                          color: const Color(0xFF777777),
                          fontSize: 16.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '-\$${widget.discount!.toStringAsFixed(1)}',
                        style: TextStyle(
                          color: const Color(0xFFE83737),
                          fontSize: 16.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],

                SizedBox(height: 20.h),
                // 总计
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Payment',
                      style: TextStyle(
                        color: const Color(0xFF777777),
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '\$${finalAmount.toStringAsFixed(1)}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreditCard({
    required Gradient gradient,
    required String bankName,
    required String cardNumber,
    required String expiryDate,
    required String holderName,
    bool isGoldCard = false,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: ShapeDecoration(
        gradient: gradient,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17.r),
        ),
      ),
      padding: EdgeInsets.all(25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                bankName,
                style: TextStyle(
                  color: isGoldCard ? const Color(0xFFC7B178) : Colors.white,
                  fontSize: 16.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.24,
                ),
              ),
              if (isGoldCard)
                Container(
                  width: 42.78.w,
                  height: 22.h,
                  color: const Color(0xFFFFD43C),
                )
              else
                SizedBox(
                  width: 45.73.w,
                  height: 28.h,
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        child: Container(
                          width: 28.w,
                          height: 28.h,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.43),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Container(
                        width: 28.w,
                        height: 28.h,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: 20.h),
          Text(
            cardNumber,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
              letterSpacing: 2,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                expiryDate,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 16.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(width: 30.w),
              Text(
                holderName,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 16.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String title, IconData icon) {
    final isSelected = _selectedMethod == title;
    return GestureDetector(
      onTap: () => _selectMethod(title),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF2B39B8) : const Color(0xFFE8E8E8),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24.sp,
              color: isSelected
                  ? const Color(0xFF2B39B8)
                  : const Color(0xFF777777),
            ),
            SizedBox(width: 16.w),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontFamily: 'Poppins',
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            const Spacer(),
            Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF2B39B8)
                      : const Color(0xFF8D8D8F),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10.w,
                        height: 10.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF2B39B8),
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDotIndicator(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      width: 8.w,
      height: 8.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _selectedCardIndex == index
            ? const Color(0xFF2B39B8)
            : const Color(0xFFD9D9D9),
      ),
    );
  }
}
