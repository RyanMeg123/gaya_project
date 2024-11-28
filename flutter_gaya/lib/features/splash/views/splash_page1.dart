import 'package:flutter/material.dart';
import 'package:flutter_gaya_2/utils/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 使用示例
Color colobackground = HexColor('#2B39B9'); // 使用自定义 HexColor 类

class SplashPage1 extends StatelessWidget {
  const SplashPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colobackground,
      padding: EdgeInsets.all(16.0.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
            child: Image.asset(
              'assets/images/icon/appicon.png',
              width: 95.w,
              height: 95.h,
            ),
          )),

          // 确保路径正确
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/splash/Gaya.png",
                  width: 127.w, height: 21.h),
              Text(
                'Fashion Store App',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'v1.0.0',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }
}
