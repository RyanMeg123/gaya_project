import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../models/tab_model.dart';
import '../widgets/step_menu.dart';
import '../widgets/checkout/shipping_address_step.dart';
import '../widgets/checkout/payment_method_step.dart';
import '../widgets/checkout/coupon_apply_step.dart';
import 'package:provider/provider.dart';
import '../controllers/cart_controller.dart';

class CheckoutPage extends StatefulWidget {
  final OrderItem orderItem;

  const CheckoutPage({super.key, required this.orderItem});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  StepMenuType currentStep = StepMenuType.shippingAddress;
  String? selectedPaymentMethod;
  int? selectedCardIndex;
  double currentDiscount = 0;

  void _handlePaymentMethodSelected(String method, int cardIndex) {
    setState(() {
      selectedPaymentMethod = method;
      selectedCardIndex = cardIndex;
    });
  }

  void _handleDiscountChanged(double discount) {
    setState(() {
      currentDiscount = discount;
      widget.orderItem.discountAmount = discount;
    });
  }

  void _handleNextStep() {
    setState(() {
      switch (currentStep) {
        case StepMenuType.shippingAddress:
          currentStep = StepMenuType.paymentMethod;
          break;
        case StepMenuType.paymentMethod:
          if (selectedPaymentMethod != null) {
            currentStep = StepMenuType.couponApply;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please select a payment method'),
                duration: Duration(seconds: 2),
              ),
            );
          }
          break;
        case StepMenuType.couponApply:
          _processCheckout();
          break;
      }
    });
  }

  void _handlePreviousStep() {
    setState(() {
      switch (currentStep) {
        case StepMenuType.paymentMethod:
          currentStep = StepMenuType.shippingAddress;
          break;
        case StepMenuType.couponApply:
          currentStep = StepMenuType.paymentMethod;
          break;
        case StepMenuType.shippingAddress:
          // 第一步不需要返回
          break;
      }
    });
  }

  void _processCheckout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
        ),
        title: Text(
          'Confirm Order',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary:',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 10.h),
            Text('Product: ${widget.orderItem.productName}'),
            Text('Variant: ${widget.orderItem.variant}'),
            Text('Payment Method: $selectedPaymentMethod'),
            if (selectedPaymentMethod == 'Credit Card')
              Text('Card Index: $selectedCardIndex'),
            Text('Total: \$${widget.orderItem.finalPrice.toStringAsFixed(1)}'),
            if (currentDiscount > 0)
              Text('Discount: -\$${currentDiscount.toStringAsFixed(1)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: const Color(0xFF777777),
                fontSize: 16.sp,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // 关闭对话框
              
              // 更新购物车中的订单状态
              final cartController = Provider.of<CartController>(context, listen: false);
              cartController.updateOrderStatus(widget.orderItem.orderNumber, 'ON DELIVERY');
              
              // 显示成功提示
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Order placed successfully! Status: ON DELIVERY',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  margin: EdgeInsets.all(20.w),
                ),
              );
              // 返回上一页
              Navigator.pop(context);
            },
            child: Text(
              'Confirm',
              style: TextStyle(
                color: const Color(0xFF2B39B8),
                fontSize: 16.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            height: 0.05,
            letterSpacing: -0.24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(MdiIcons.arrowLeft, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          StepMenu(currentStep: currentStep),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (currentStep == StepMenuType.shippingAddress)
                    const ShippingAddressStep(),
                  if (currentStep == StepMenuType.paymentMethod)
                    PaymentMethodStep(
                      totalAmount: widget.orderItem.totalPrice,
                      shippingFee: 0,
                      discount: widget.orderItem.discountAmount,
                      onMethodSelected: _handlePaymentMethodSelected,
                    ),
                  if (currentStep == StepMenuType.couponApply)
                    CouponApplyStep(
                      orderItem: widget.orderItem,
                      onDiscountChanged: _handleDiscountChanged,
                    ),
                  // ... 其他步骤的内容
                ],
              ),
            ),
          ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 20.h),
              child: Row(
                children: [
                  if (currentStep != StepMenuType.shippingAddress)
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 10.w),
                        height: 60.h,
                        child: OutlinedButton(
                          onPressed: _handlePreviousStep,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFF2B39B8),
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                          ),
                          child: Text(
                            'Back',
                            style: TextStyle(
                              color: const Color(0xFF2B39B8),
                              fontSize: 16.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: SizedBox(
                      height: 60.h,
                      child: ElevatedButton(
                        onPressed: _handleNextStep,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2B39B8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                          elevation: 22,
                          shadowColor: const Color(0x4F2B39B8),
                        ),
                        child: Text(
                          currentStep == StepMenuType.couponApply
                              ? 'Confirm'
                              : 'Next',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
