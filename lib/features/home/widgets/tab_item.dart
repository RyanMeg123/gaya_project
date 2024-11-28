import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabItem extends StatefulWidget {
  final String text;
  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;
  const TabItem(
      {super.key,
      required this.text,
      required this.iconPath,
      this.isSelected = false,
      required this.onTap});

  @override
  State<StatefulWidget> createState() {
    return _TabItemState();
  }
}

class _TabItemState extends State<TabItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          Container(
            width: 64.w,
            height: 64.h,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(221, 224, 255, 1),
              border: Border.all(
                  color: widget.isSelected
                      ? const Color.fromRGBO(43, 57, 185, 1)
                      : Colors.transparent,
                  width: 2.w),
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Image.asset(
              widget.iconPath,
              width: 32.w,
              height: 32.h,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            widget.text,
            style: TextStyle(
                color: widget.isSelected
                    ? const Color.fromRGBO(48, 48, 48, 1)
                    : const Color.fromRGBO(96, 96, 96, 1),
                fontSize: 12.sp,
                fontWeight:
                    widget.isSelected ? FontWeight.bold : FontWeight.normal),
          )
        ],
      ),
    );
  }
}
