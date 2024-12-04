import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gaya_2/compontents/form_common.dart';
import 'package:flutter_gaya_2/routes.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gaya_2/services/api_service.dart';
import 'package:flutter_gaya_2/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gaya_2/providers/user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _apiService = ApiService();
  final _authService = AuthService();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        final userProvider = Provider.of<UserProvider>(context, listen: false);

        // 登录并获取响应
        final response = await _apiService.login(
          email: emailController.text,
          password: passwordController.text,
        );

        // 设置用户数据
        await userProvider.setUserData(response);

        // 确保用户数据已初始化
        await userProvider.initializeUser();

        if (mounted) {
          // 使用 pushNamedAndRemoveUntil 清除导航栈
          await Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.homePage,
            (route) => false,
          );

          // 成功提示放在导航之后，避免被新页面覆盖
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login successful'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        print('Login error: $e');

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString().replaceAll('Exception: ', '')),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 44.h,
        leading: IconButton(
          icon: Icon(MdiIcons.arrowLeft), // 左上角的返回图标
          onPressed: () {
            // 返回上一页
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              // 只保留一个 Logo 和欢迎文本
              Column(
                children: [
                  Image.asset(
                    'assets/images/login/logomini.png',
                    width: 72.w,
                    height: 72.h,
                  ),
                  SizedBox(height: 36.h),
                  Text(
                    'Welcome back!',
                    style: TextStyle(
                      color: const Color.fromRGBO(34, 34, 34, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp,
                    ),
                  ),
                  SizedBox(height: 9.h),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color.fromRGBO(106, 106, 106, 1),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 23.h),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormCommon(
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
                    SizedBox(height: 24.h),
                    ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(318.w, 60.h),
                            foregroundColor: Colors.white,
                            backgroundColor:
                                const Color.fromRGBO(43, 57, 185, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0), // 圆角边框
                            ) // 设置按钮文本颜色
                            ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                    SizedBox(height: 16.h),
                    Container(
                      // width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              text: TextSpan(
                                text: 'Forgot password?',
                                style: TextStyle(
                                  color: const Color.fromRGBO(101, 101, 101, 1),
                                  fontSize: 16.sp,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // 在这里处理condition的点击事件
                                    print('press the forget password');
                                  },
                              )),
                          RichText(
                            text: TextSpan(
                              text: 'Reset here?',
                              style: TextStyle(
                                  color: const Color.fromRGBO(43, 57, 185, 1),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // 在这里处理condition的点击事件
                                  print('press the forget password');
                                },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 59.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Don’t have an account?',
                            style: TextStyle(
                                color: const Color.fromRGBO(19, 19, 19, 1),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // 在这里处理condition的点击事件
                                print('press the forget password');
                              },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(318.w, 60.h),
                            foregroundColor: Colors.white,
                            backgroundColor:
                                const Color.fromRGBO(233, 235, 249, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0), // 圆角边框
                            ) // 设置按钮文本颜色
                            ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Register for Free now',
                              style: TextStyle(
                                  color: const Color.fromRGBO(43, 57, 185, 1),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                  ],
                ),
              ),
              // 社交登录按钮
              SizedBox(height: 20.h),
              Center(
                child: Column(
                  children: [
                    // Facebook 登录按钮
                    ElevatedButton(
                      onPressed: () {
                        print('Facebook login');
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        side: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1.w,
                        ),
                        fixedSize: Size(318.w, 60.h),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 30.w),
                            child: SizedBox(
                              width: 40.w,
                              child: Image.asset(
                                  'assets/images/splash/iconfb.png'),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Login With Facebook",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    // Google 登录按钮
                    ElevatedButton(
                      onPressed: () {
                        print('Google login');
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        side: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1.w,
                        ),
                        fixedSize: Size(318.w, 60.h),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 30.w),
                            child: SizedBox(
                              width: 40.w,
                              child: Image.asset(
                                  'assets/images/splash/iconGoogle.png'),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Login With Google",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h), // 底部间距
            ],
          ),
        ),
      ),
    );
  }
}
