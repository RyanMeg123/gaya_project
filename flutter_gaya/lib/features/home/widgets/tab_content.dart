import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabContent extends StatelessWidget {
  final String title;
  final Icon icon;

  const TabContent({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(height: 20.h),
          Text(title, style: const TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
