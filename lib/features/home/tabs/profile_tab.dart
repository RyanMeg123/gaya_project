import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  Widget _buildMenuButton(String title, VoidCallback onTap) {
    return Container(
      width: 315.w,
      height: 60.h,
      margin: EdgeInsets.only(bottom: 27.h),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x07000000),
            blurRadius: 40,
            offset: Offset(0, 10),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontFamily: 'SF Pro Text',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  MdiIcons.chevronRight,
                  size: 24.sp,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          Padding(
            padding: EdgeInsets.only(left: 30.w, top: 124.h),
            child: Text(
              'My profile',
              style: TextStyle(
                color: Colors.black,
                fontSize: 34.sp,
                fontFamily: 'SF Pro Text',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // 可滚动内容区域
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 个人信息卡片
                  Container(
                    width: 315.w,
                    margin: EdgeInsets.only(left: 32.w, top: 32.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Personal details',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                                fontFamily: 'SF Pro Text',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'change',
                                style: TextStyle(
                                  color: const Color(0xFF2B39B8),
                                  fontSize: 15.sp,
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 315.w,
                          padding: EdgeInsets.all(16.w),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x07000000),
                                blurRadius: 40,
                                offset: Offset(0, 10),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 头像
                              Container(
                                width: 91.w,
                                height: 100.h,
                                decoration: ShapeDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/home/profileLogo.png'),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15.w),
                              // 个人信息
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Marvis Ighedosa',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                        fontFamily: 'SF Pro Text',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      'Dosamarvis@gmail.com',
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 15.sp,
                                        fontFamily: 'SF Pro Text',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Divider(height: 16.h),
                                    Text(
                                      '+234 9011039271',
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 15.sp,
                                        fontFamily: 'SF Pro Text',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Divider(height: 16.h),
                                    Text(
                                      'No 15 uti street off ovie palace road effurun delta state',
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 15.sp,
                                        fontFamily: 'SF Pro Text',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 菜单按钮列表
                  Padding(
                    padding: EdgeInsets.only(left: 32.w, top: 27.h),
                    child: Column(
                      children: [
                        _buildMenuButton('Orders', () {}),
                        _buildMenuButton('Pending reviews', () {}),
                        _buildMenuButton('Faq', () {}),
                        _buildMenuButton('Help', () {}),
                      ],
                    ),
                  ),

                  // 更新按钮
                  Container(
                    width: 314.w,
                    height: 70.h,
                    margin: EdgeInsets.only(
                      left: 30.w,
                      top: 20.h,
                      bottom: 42.h,
                    ),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF2B39B8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Update',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFFF6F6F9),
                          fontSize: 17.sp,
                          fontFamily: 'SF Pro Text',
                          fontWeight: FontWeight.w600,
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
