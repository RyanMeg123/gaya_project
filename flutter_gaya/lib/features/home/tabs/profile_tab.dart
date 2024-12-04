import 'package:flutter/material.dart';
import 'package:flutter_gaya_2/models/user_profile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../../../providers/profile_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../routes.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProfile();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.userId != null) {
      print('User ID from provider: ${userProvider.userId}');
      await Provider.of<ProfileProvider>(context, listen: false)
          .loadUserProfile(userProvider.userId!);
    } else {
      print('No user ID available');
    }
  }

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

  void _showUpdateDialog(BuildContext context, UserProfile profile) {
    _nameController.text = profile.name;
    _phoneController.text = profile.phone;
    _addressController.text = profile.address;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Update Profile',
          style: TextStyle(
            fontSize: 20.sp,
            fontFamily: 'SF Pro Text',
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 10.h),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            SizedBox(height: 10.h),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final userProvider =
                  Provider.of<UserProvider>(context, listen: false);
              final profileProvider =
                  Provider.of<ProfileProvider>(context, listen: false);

              try {
                await profileProvider.updateProfile(
                  userProvider.userId!,
                  {
                    'name': _nameController.text,
                    'phone': _phoneController.text,
                    'address': _addressController.text,
                  },
                );

                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile updated successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to update profile: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, _) {
        if (profileProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = profileProvider.profile;
        if (profile == null) {
          return const Center(child: Text('Failed to load profile'));
        }

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
                                GestureDetector(
                                  onTap: () =>
                                      _showUpdateDialog(context, profile),
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
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15.w),
                                  // 个人信息
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          profile.name,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.sp,
                                            fontFamily: 'SF Pro Text',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          profile.email,
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: 15.sp,
                                            fontFamily: 'SF Pro Text',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Divider(height: 16.h),
                                        Text(
                                          '+234 9011039271',
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: 15.sp,
                                            fontFamily: 'SF Pro Text',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Divider(height: 16.h),
                                        Text(
                                          profile.address,
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
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
                            _buildMenuButton('Logout', () async {
                              // 显示确认对话框
                              final shouldLogout = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Logout'),
                                  content: const Text('Are you sure you want to logout?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, false),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, true),
                                      child: Text(
                                        'Logout',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );

                              if (shouldLogout == true) {
                                // 执行登出操作
                                await Provider.of<UserProvider>(context, listen: false).logout();
                                
                                if (mounted) {
                                  // 导航到登录页面
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    AppRoutes.login,
                                    (route) => false,
                                  );
                                }
                              }
                            }),
                          ],
                        ),
                      ),

                      // 更新按钮
                      GestureDetector(
                        onTap: () => _showUpdateDialog(context, profile),
                        child: Container(
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
