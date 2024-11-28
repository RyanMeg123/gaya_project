import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color.fromRGBO(219, 219, 219, 1), // 设置顶部边框的颜色
            width: 2, // 设置顶部边框的宽度
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        selectedItemColor: const Color.fromRGBO(43, 57, 185, 1),
        unselectedItemColor: const Color.fromRGBO(185, 188, 211, 1),
        elevation: 8.0,
        type: BottomNavigationBarType.fixed, // 这样可以避免图标和文字的大小变化
        iconSize: 24.0, // 设置固定的图标大小
        selectedFontSize: 12.0, // 设置选中项的文字大小
        unselectedFontSize: 12.0, // 设置未选中项的文字大小
        items: [
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.bankTransfer), label: 'Transaction'),
          BottomNavigationBarItem(icon: Icon(MdiIcons.cart), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(MdiIcons.account), label: 'Profile'),
        ],
      ),
    );
  }
}
