import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gaya_2/providers/notification_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  Color _getTypeColor(String type) {
    switch (type) {
      case 'order':
        return const Color(0xFF2B39B8); // 蓝色
      case 'system':
        return const Color(0xFFE09FFF); // 紫色
      case 'promotion':
        return const Color(0xFFFFCF81); // 橙色
      default:
        return Colors.grey;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'order':
        return MdiIcons.shoppingOutline;
      case 'system':
        return MdiIcons.informationOutline;
      case 'promotion':
        return MdiIcons.tagOutline;
      default:
        return MdiIcons.bellOutline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F8),
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(MdiIcons.arrowLeft), // 左上角的返回图标
          onPressed: () {
            // 返回上一页
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<NotificationProvider>(context, listen: false)
                  .markAllAsRead();
            },
            child: Text(
              'Mark all as read',
              style: TextStyle(
                color: const Color(0xFF2B39B8),
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off_outlined,
                    size: 64.sp,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No notifications',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            itemCount: provider.notifications.length,
            itemBuilder: (context, index) {
              final notification = provider.notifications[index];
              final typeColor = _getTypeColor(notification.type);
              final typeIcon = _getTypeIcon(notification.type);

              return Container(
                margin: EdgeInsets.only(bottom: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => provider.markAsRead(notification.id),
                    borderRadius: BorderRadius.circular(12.r),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 类型图标
                          Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              color: typeColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              typeIcon,
                              color: typeColor,
                              size: 24.sp,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          // 通知内容
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        notification.title,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    if (!notification.isRead)
                                      Container(
                                        width: 8.w,
                                        height: 8.w,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF2B39B8),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  notification.message,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  DateFormat('MMM dd, yyyy HH:mm')
                                      .format(notification.createdAt),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
