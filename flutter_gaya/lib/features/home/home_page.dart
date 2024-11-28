import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gaya_2/controllers/home_controller.dart';
import 'package:flutter_gaya_2/features/home/tabs/cart_tab.dart';
import 'package:flutter_gaya_2/features/home/tabs/home_tab.dart';
import 'package:flutter_gaya_2/features/home/tabs/profile_tab.dart';
import 'package:flutter_gaya_2/features/home/tabs/transaction_tab.dart';
import 'package:flutter_gaya_2/features/home/widgets/bottom_nav_bar_android.dart';
import 'package:flutter_gaya_2/features/home/widgets/bottom_nav_bar_ios.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = HomeController();
  }

  void _onTabTapped(int index) {
    print('press tab $index');
    _controller.changeTabIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _controller,
      child: Scaffold(
        body: Consumer<HomeController>(builder: (context, controller, child) {
          return _getTabPage(controller.currentTabIndex);
        }),
        bottomNavigationBar: Consumer<HomeController>(
            builder: (context, controller, child) => Platform.isAndroid
                ? BottomNavBar(
                    currentIndex: controller.currentTabIndex,
                    onTap: _onTabTapped,
                  )
                : IOSBottomNavBar(
                    currentIndex: controller.currentTabIndex,
                    onTap: _onTabTapped,
                  )),
      ),
    );
  }

  Widget _getTabPage(int currentIndex) {
    final List<Widget> tabs = [
      const HomeTab(),
      const TransactionTab(),
      const CartTab(),
      const ProfileTab(),
    ];
    return tabs[currentIndex];
  }

  @override
  void dispose() {
    _controller.dispose(); // 清理 controller
    super.dispose();
  }
}
