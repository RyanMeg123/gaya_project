import 'package:flutter/material.dart';
import 'package:flutter_gaya_2/routes.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage3 extends StatelessWidget {
  const SplashPage3({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    const designHeight = 812;
    Size screenSize = MediaQuery.of(context).size;
    double imageWidth = screenSize.width * 75 / 375; // 375 是 iPhone XS Max 的宽度
    double imageHeight =
        screenSize.height * 75 / 812; // 812 是 iPhone XS Max 的高度
    double imageWidthLogo =
        screenSize.width * 115 / 375; // 375 是 iPhone XS Max 的宽度
    double imageHeightLogo =
        screenSize.height * 135 / 812; // 812 是 iPhone XS Max 的高度
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 29.0),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.38,
              width: double.infinity,
              child: Stack(
                children: [
                  LayoutBuilder(builder: (context, constraints) {
                    double width = constraints.maxWidth;
                    double height = constraints.maxHeight;
                    return Stack(
                      children: [
                        Positioned(
                            left: width * 0.15,
                            top: height * 0.15,
                            child: Image.asset(
                              'assets/images/splash/shopIcon1.png',
                              width: imageWidth,
                              height: imageHeight,
                            )),
                        Positioned(
                            right: width * 0.1,
                            bottom: height * 0.3,
                            child: Image.asset(
                              'assets/images/splash/shopIcon2.png',
                              width: imageWidth,
                              height: imageHeight,
                            )),
                        Positioned(
                            right: width * 0.1,
                            top: height * 0.1,
                            child: Image.asset(
                              'assets/images/splash/shopIcon4.png',
                              width: imageWidth,
                              height: imageHeight,
                            )),
                        Positioned(
                            left: width * 0.1,
                            bottom: height * 0.25,
                            child: Image.asset(
                              'assets/images/splash/shopIcon3.png',
                              width: imageWidth,
                              height: imageHeight,
                            )),
                        Positioned(
                            left:
                                width * 0.5 - imageWidthLogo / 2, // 可以根据需要调整位置
                            top: height * 0.5 - imageHeightLogo / 2,
                            child: Image.asset(
                              'assets/images/splash/logo.png',
                              width: imageWidthLogo,
                              height: imageHeightLogo,
                            )),
                      ],
                    );
                  })
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(children: [
                Column(children: [
                  SizedBox(
                    width: 318,
                    child: Text('Discover our summer collections',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  SizedBox(
                    height: screenHeight * 10 / designHeight,
                  ),
                  SizedBox(
                    width: 318.w,
                    child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color.fromRGBO(0, 0, 0, 0.7),
                          fontSize: 14.sp,
                        )),
                  ),
                  const Text('')
                ]),
                SizedBox(
                  height: screenHeight * 15 / designHeight,
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print('email tap');
                        Navigator.pushNamed(context, AppRoutes.registerEmail);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor:
                            const Color.fromRGBO(43, 57, 185, 1), // 设置按钮文本颜色
                        fixedSize: Size(318.w, 60.h), // 设置按钮宽高
                        elevation: 5, // 设置阴影高度

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r), // 圆角边框
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 30.w),
                            child: SizedBox(
                              width: 50.h,
                              child: Icon(MdiIcons.email),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Login With Email",
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 30 / designHeight,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print('email tap');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.white, // 按钮文本颜色
                        side: BorderSide(
                          color: const Color.fromRGBO(55, 106, 237, 1), // 边框颜色
                          width: 1.w, // 边框宽度
                        ),
                        fixedSize: Size(318.w, 60.h), // 设置按钮宽高
                        elevation: 5, // 设置阴影高度
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r), // 圆角边框
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 30.w),
                            child: SizedBox(
                              width: 50.w,
                              child: Image.asset(
                                  'assets/images/splash/iconfb.png'),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Login With Email",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ElevatedButton(
                      onPressed: () {
                        print('email tap');
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.white, //设置按钮文本颜色
                        fixedSize: Size(318.w, 60.h), // 设置按钮宽高
                        elevation: 5, // 设置阴影高度
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r), // 圆角边框
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 30.r),
                            child: SizedBox(
                              width: 50.w,
                              child: Image.asset(
                                  'assets/images/splash/iconGoogle.png'),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Login With Email",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
