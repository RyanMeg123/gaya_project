import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gaya_2/controllers/home_controller.dart';
import 'package:flutter_gaya_2/providers/user_provider.dart';
import 'package:flutter_gaya_2/routes.dart';
import 'package:flutter_gaya_2/features/home/tabs/cart_tab.dart';
import 'package:flutter_gaya_2/features/home/tabs/home_tab.dart';
import 'package:flutter_gaya_2/features/home/tabs/profile_tab.dart';
import 'package:flutter_gaya_2/features/home/tabs/transaction_tab.dart';
import 'package:flutter_gaya_2/features/home/widgets/bottom_nav_bar_android.dart';
import 'package:flutter_gaya_2/features/home/widgets/bottom_nav_bar_ios.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // _showLoginStatusDialog();
      }
    });
  }

  void _showLoginStatusDialog() {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            final userData = userProvider.userData;
            return AlertDialog(
              title: const Text('Login Status'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Status: ${userProvider.isLoggedIn ? 'Logged In' : 'Not Logged In'}'),
                  if (userData != null) ...[
                    const SizedBox(height: 10),
                    Text('Email: ${userProvider.userEmail}'),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
                if (userProvider.isLoggedIn)
                  TextButton(
                    onPressed: () async {
                      await userProvider.logout();
                      if (mounted) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.login,
                          (route) => false,
                        );
                      }
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  void _onTabTapped(int index) {
    final controller = Provider.of<HomeController>(context, listen: false);
    controller.changeTabIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: _showLoginStatusDialog,
          ),
        ],
      ),
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
    super.dispose();
  }
}
