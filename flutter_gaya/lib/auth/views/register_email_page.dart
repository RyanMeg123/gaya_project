import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gaya_2/routes.dart';
import '../../compontents/form_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gaya_2/services/api_service.dart';

class RegisterEmailPage extends StatefulWidget {
  const RegisterEmailPage({super.key});

  @override
  _RegisterEmailPageState createState() => _RegisterEmailPageState();
}

class _RegisterEmailPageState extends State<RegisterEmailPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final _apiService = ApiService();

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      // 验证密码确认
      if (passwordController.text != passwordConfirmController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      try {
        final response = await _apiService.register(
          email: emailController.text,
          password: passwordController.text,
        );
        print('response $response');

        // 注册成功
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful'),
            backgroundColor: Colors.green,
          ),
        );

        // 导航到登录页面
        Navigator.pushNamed(context, AppRoutes.login);
      } catch (e) {
        // 显示错误信息
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 44.h,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back), // 左上角的返回图标
          onPressed: () {
            // 返回上一页
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 29.w, right: 29.w),
        child: ListView(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/login/logomini.png',
                    width: 72.w,
                    height: 72.h,
                  ),
                  SizedBox(height: 36.h),
                  Text(
                    'Create account Free',
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
                  ),
                ],
              ),
            ),
            SizedBox(height: 23.h),
            Container(
              child: Column(
                children: [
                  FormCommon(
                    formKey: _formKey,
                    emailController: emailController,
                    passwordController: passwordController,
                    passwordConfirmController: passwordConfirmController,
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(double.infinity, 60.h),
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromRGBO(43, 57, 185, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.r), // 圆角边框
                          ) // 设置按钮文本颜色
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Register',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: 308.w,
                    child: RichText(
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      text: TextSpan(
                          style: TextStyle(
                              color: const Color.fromRGBO(0, 0, 0, 0.5),
                              letterSpacing: 2,
                              fontSize: 14.sp),
                          children: [
                            const TextSpan(
                              text:
                                  'By tapping “Sign Up” you accept our ', // 普通文本
                            ),
                            TextSpan(
                              text: 'terms', // 需要链接的文本
                              style: const TextStyle(
                                color: Color.fromRGBO(43, 57, 185, 1),
                                fontWeight: FontWeight.bold, // 设置链接的颜色
                                decoration:
                                    TextDecoration.underline, // 可选：设置下划线
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // 在这里处理terms的点击事件
                                  print('Terms clicked');
                                },
                            ),
                            const TextSpan(
                              text: ' and ', // 普通文本
                            ),
                            TextSpan(
                              text: 'condition', // 需要链接的文本
                              style: const TextStyle(
                                color: Color.fromRGBO(43, 57, 185, 1),
                                fontWeight: FontWeight.bold, // 设置链接的颜色
                                decoration:
                                    TextDecoration.underline, // 可选：设置下划线
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // 在这里处理condition的点击事件
                                  print('Condition clicked');
                                },
                            ),
                            const TextSpan(
                              text: '.', // 普通文本
                            ),
                          ]),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 46.h),
            Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Already have an account?',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color.fromRGBO(19, 19, 19, 1),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20.h),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print('email tap');
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor:
                            const Color.fromRGBO(233, 235, 249, 1), // 设置按钮文本颜色
                        fixedSize: Size(318.w, 60.h), // 设置按钮宽高
                        // elevation: 5, // 设置阴影高度

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.r), // 圆角边框
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 12.h),
                      ),
                      child: Container(
                        child: Text(
                          "Continue with email",
                          style: TextStyle(
                              color: const Color.fromRGBO(43, 57, 185, 1),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
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
                          borderRadius: BorderRadius.circular(18.r), // 圆角边框
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
                          borderRadius: BorderRadius.circular(18), // 圆角边框
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
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
