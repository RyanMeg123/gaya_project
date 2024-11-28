import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../models/address_model.dart';
import 'address_form_dialog.dart';

class ShippingAddressStep extends StatefulWidget {
  const ShippingAddressStep({super.key});

  @override
  State<ShippingAddressStep> createState() => _ShippingAddressStepState();
}

class _ShippingAddressStepState extends State<ShippingAddressStep> {
  List<AddressModel> addresses = [
    AddressModel(
      name: 'Kevin Hard',
      phone: '+1 234 5678 900',
      address: '4517 Washington Ave. Manchester, Kentucky 39495',
      type: 'Home',
      isDefault: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),

          // 地址列表
          ...addresses.map((address) => _buildAddressCard(address)),
          SizedBox(height: 20.h),

          // 添加新地址按钮
          GestureDetector(
            onTap: _showAddAddressDialog,
            child: Container(
              width: double.infinity,
              height: 60.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF2B39B8),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Center(
                child: Text(
                  'Add New Address',
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
        ],
      ),
    );
  }

  Widget _buildAddressCard(AddressModel address) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                address.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD1D5FF),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      address.type,
                      style: TextStyle(
                        color: const Color(0xFF2B39B8),
                        fontSize: 12.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (address.isDefault) ...[
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8E8E8),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'Default',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            address.phone,
            style: TextStyle(
              color: const Color(0xFF777777),
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            address.address,
            style: TextStyle(
              color: const Color(0xFF777777),
              fontSize: 14.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // 编辑按钮
              TextButton(
                onPressed: () => _editAddress(address),
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: const Color(0xFF2B39B8),
                    fontSize: 14.sp,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              // 删除按钮
              TextButton(
                onPressed: () => _deleteAddress(address),
                child: Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.sp,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              if (!address.isDefault)
                // 设为默认按钮
                TextButton(
                  onPressed: () => _setDefaultAddress(address),
                  child: Text(
                    'Set as Default',
                    style: TextStyle(
                      color: const Color(0xFF2B39B8),
                      fontSize: 14.sp,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showAddAddressDialog() async {
    final result = await showDialog(
      context: context,
      builder: (context) => const AddressFormDialog(),
    );

    if (result != null) {
      setState(() {
        addresses.add(AddressModel(
          name: result['name'],
          phone: result['phone'],
          address: result['address'],
          type: result['type'],
          isDefault: addresses.isEmpty,
        ));
      });
    }
  }

  Future<void> _editAddress(AddressModel address) async {
    final result = await showDialog(
      context: context,
      builder: (context) => AddressFormDialog(address: address),
    );

    if (result != null) {
      setState(() {
        final index = addresses.indexOf(address);
        addresses[index] = AddressModel(
          name: result['name'],
          phone: result['phone'],
          address: result['address'],
          type: result['type'],
          isDefault: result['isDefault'],
        );
      });
    }
  }

  void _deleteAddress(AddressModel address) async {
    // 显示确认对话框
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
        ),
        title: Text(
          'Delete Address',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        content: Text(
          'Are you sure you want to delete this address?',
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: 'Poppins',
            color: const Color(0xFF777777),
          ),
        ),
        actions: [
          // 取消按钮
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: const Color(0xFF777777),
                fontSize: 16.sp,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          // 删除按钮
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Delete',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );

    // 如果用户确认删除
    if (confirmed == true) {
      setState(() {
        addresses.remove(address);
        // 如果删除的是默认地址，且还有其他地址，则将第一个地址设为默认
        if (address.isDefault && addresses.isNotEmpty) {
          addresses[0] = addresses[0].copyWith(isDefault: true);
        }
        // 显示删除成功提示
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Address deleted successfully',
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
      });
    }
  }

  void _setDefaultAddress(AddressModel address) async {
    // 如果已经是默认地址，不需要操作
    if (address.isDefault) return;

    // 显示确认对话框
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
        ),
        title: Text(
          'Set as Default',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        content: Text(
          'Do you want to set this address as default?',
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: 'Poppins',
            color: const Color(0xFF777777),
          ),
        ),
        actions: [
          // 取消按钮
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: const Color(0xFF777777),
                fontSize: 16.sp,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          // 确认按钮
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Set as Default',
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

    // 如果用户确认设置为默认地址
    if (confirmed == true) {
      setState(() {
        // 取消原有默认地址
        for (var i = 0; i < addresses.length; i++) {
          if (addresses[i].isDefault) {
            addresses[i] = addresses[i].copyWith(isDefault: false);
          }
        }
        // 设置新的默认地址
        addresses[addresses.indexOf(address)] = address.copyWith(isDefault: true);

        // 显示设置成功提示
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Default address updated successfully',
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
      });
    }
  }
}
