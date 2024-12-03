import 'package:flutter/material.dart';
import 'package:flutter_gaya_2/services/auth_service.dart';
import 'package:flutter_gaya_2/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  Future<void> _checkLoginState() async {
    // 添加一个短暂延迟以显示启动画面
    await Future.delayed(const Duration(seconds: 2));

    final isLoggedIn = await _authService.isTokenValid();

    if (mounted) {
      if (isLoggedIn) {
        // 如果已登录，直接进入主页
        Navigator.pushReplacementNamed(context, AppRoutes.homePage);
      } else {
        // 如果未登录，进入登录页
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/splash/logo.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
