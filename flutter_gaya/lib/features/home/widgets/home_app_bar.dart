import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../controllers/wishlist_controller.dart';

class HomeTabAppBar extends StatelessWidget {
  final String userName;
  final String badgeCount;
  final VoidCallback onFavoritesTap;
  final VoidCallback onNotificationsTap;
  final Function(String) onSearchChanged;

  const HomeTabAppBar({
    super.key,
    required this.userName,
    required this.badgeCount,
    required this.onFavoritesTap,
    required this.onNotificationsTap,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 44.h),
      child: Column(
        children: [
          // 顶部栏
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 欢迎文本
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello,',
                      style: TextStyle(
                        color: const Color(0xFF777777),
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      userName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                // 图标按钮组
                Row(
                  children: [
                    // 收藏按钮
                    Consumer<WishlistController>(
                      builder: (context, controller, child) {
                        final itemCount = controller.items.length;
                        return Stack(
                          children: [
                            IconButton(
                              icon: Icon(
                                MdiIcons.heart,
                                color: Colors.black,
                                size: 24.sp,
                              ),
                              onPressed: onFavoritesTap,
                            ),
                            if (itemCount > 0)
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  padding: EdgeInsets.all(4.w),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    itemCount.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                    SizedBox(width: 16.w),
                    // 通知按钮
                    Stack(
                      children: [
                        IconButton(
                          icon: Icon(
                            MdiIcons.bell,
                            color: Colors.black,
                            size: 24.sp,
                          ),
                          onPressed: onNotificationsTap,
                        ),
                        if (badgeCount.isNotEmpty)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                badgeCount,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
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
}
