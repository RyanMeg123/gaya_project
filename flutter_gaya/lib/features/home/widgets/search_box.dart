import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SearchBox extends StatelessWidget {
  final Function(String) onChanged;
  final String hintText;

  const SearchBox({
    super.key,
    required this.onChanged,
    this.hintText = 'Search man fashion..',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 318.w,
          height: 54.h,
          decoration: ShapeDecoration(
            color: const Color(0xFFEFEFEF),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Colors.white),
              borderRadius: BorderRadius.circular(18.r),
            ),
          ),
          child: Row(
            children: [
              // 搜索提示文本
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 23.w),
                  child: TextField(
                    onChanged: onChanged,
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: TextStyle(
                        color: const Color(0xFF797979),
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              // 搜索图标
              Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: Container(
                  width: 24.w,
                  height: 24.h,
                  padding: EdgeInsets.symmetric(vertical: 0.04.h),
                  child: Icon(
                    MdiIcons.magnify,
                    color: const Color(0xFF797979),
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
