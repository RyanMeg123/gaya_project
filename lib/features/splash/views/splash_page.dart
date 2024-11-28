import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/splash_controller.dart';
import 'package:flutter_gaya_2/utils/hex_color.dart';
import 'splash_page1.dart';
import 'splash_page2.dart';
import 'splash_page3.dart';

Color colorShape = HexColor('#2B39B9');

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    const designHeight = 812;
    return ChangeNotifierProvider(
      create: (_) => SplashController(),
      child: Consumer<SplashController>(builder: (context, controller, child) {
        return Scaffold(
          body: Stack(
            children: [
              PageView(
                controller: _pageController,
                onPageChanged: controller.setCurrentSplashPage,
                children: const [SplashPage1(), SplashPage2(), SplashPage3()],
              ),
              if (controller.currentSplashPage != 0) ...[
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  top: controller.currentSplashPage == 2
                      ? screenHeight * -60 / designHeight
                      : screenHeight * 250 / designHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) =>
                            _buildDot(controller.currentSplashPage, index)),
                  ),
                ),
              ]
            ],
          ),
          floatingActionButton: controller.currentSplashPage == 2
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Icon(CupertinoIcons.back),
                )
              : null,
        );
      }),
    );
  }

  Widget _buildDot(int currentSplashPage, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: currentSplashPage == index ? 24.0 : 8.0,
      height: currentSplashPage == index ? 8.0 : 8.0,
      decoration: BoxDecoration(
        color: currentSplashPage == index ? colorShape : Colors.grey,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
