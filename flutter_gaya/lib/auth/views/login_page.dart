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
        final response = await _apiService.login(
          email: emailController.text,
          password: passwordController.text,
        );

        await userProvider.setUserData(response);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login successful'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );

          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.homePage,
            (route) => false,
            arguments: true,
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
      body: Padding(
        padding: EdgeInsets.only(left: 29.w, right: 29.w),
        child: Container(
          child: Column(
            children: [
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
                        fontSize: 24.sp),
                  ),
                  SizedBox(height: 9.h),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color.fromRGBO(106, 106, 106, 1),
                      fontSize: 14.sp,
                    ),
                  )
                ],
              ),
              SizedBox(height: 23.h),
              Expanded(
                child: Column(
                  children: [
                    FormCommon(
                        formKey: _formKey,
                        emailController: emailController,
                        passwordController: passwordController),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
