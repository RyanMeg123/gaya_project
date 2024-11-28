import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gaya_2/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../controllers/home_controller.dart';
import 'package:provider/provider.dart';

class TransactionTab extends StatefulWidget {
  const TransactionTab({super.key});

  @override
  State<TransactionTab> createState() => _TransactionTabState();
}

class _TransactionTabState extends State<TransactionTab> {
  final TextEditingController _searchController = TextEditingController();
  final List<TransactionItem> _allTransactions = [
    TransactionItem(
      title: 'Shopping',
      date: '15 Mar 2019, 8:20PM',
      amount: '-\$120',
      iconBgColor: const Color(0xFFFFCF81),
      icon: MdiIcons.cartOutline,
    ),
    TransactionItem(
      title: 'Medicine',
      date: '13 Mar 2019, 12:10AM',
      amount: '-\$89.50',
      iconBgColor: const Color(0xFFE09FFF),
      icon: MdiIcons.pill,
    ),
    TransactionItem(
      title: 'Sport',
      date: '10 Mar 2019, 6:50PM',
      amount: '-\$20.50',
      iconBgColor: const Color(0xEA00DADE),
      icon: MdiIcons.basketball,
    ),
    TransactionItem(
      title: 'Travel',
      date: '3 Mar 2019, 5:50PM',
      amount: '-\$399',
      iconBgColor: const Color(0xEAFF8787),
      icon: MdiIcons.airplane,
    ),
    TransactionItem(
      title: 'Shopping',
      date: '5 Mar 2019, 7:20PM',
      amount: '-\$255',
      iconBgColor: const Color(0xFFFFCF81),
      icon: MdiIcons.cartOutline,
    ),
    TransactionItem(
      title: 'Sport',
      date: '25 mar 2019, 6:32PM',
      amount: '-\$20.50',
      iconBgColor: const Color(0xEA00DADE),
      icon: MdiIcons.basketball,
    ),
  ];
  List<TransactionItem> _filteredTransactions = [];

  @override
  void initState() {
    super.initState();
    _filteredTransactions = _allTransactions;
    _searchController.addListener(_filterTransactions);
  }

  void _filterTransactions() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredTransactions = _allTransactions.where((transaction) {
        return transaction.title.toLowerCase().contains(query) ||
            transaction.date.toLowerCase().contains(query) ||
            transaction.amount.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleBack(BuildContext context) {
    // 直接返回到上一页，让 HomePage 自己处理状态
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _handleBack(context);
        return false;
      },
      child: Column(
        children: [
          // 顶部蓝色背景
          Container(
            width: 375.w,
            height: 245.h,
            decoration: ShapeDecoration(
              color: const Color(0xFF3C43FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(62.r),
                  bottomRight: Radius.circular(62.r),
                ),
              ),
            ),
            child: Column(
              children: [
                // 标题和返回按钮
                Padding(
                  padding: EdgeInsets.only(top: 64.h, left: 0.w, right: 0.w),
                  child: Row(
                    children: [
                      // IconButton(
                      //   icon: const Icon(CupertinoIcons.back,
                      //       color: Colors.white),
                      //   onPressed: () => _handleBack(context),
                      // ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Transactions',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.5.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // 总支出金额
                Column(
                  children: [
                    Text(
                      'Your total expences',
                      style: TextStyle(
                        color: const Color(0xFF87F0FF),
                        fontSize: 22.5.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      '\$1063.30',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 26),

          // 交易列表区域（包含搜索栏）
          Expanded(
            child: Container(
              decoration: ShapeDecoration(
                color: const Color(0xF73C43FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(62.r),
                    topRight: Radius.circular(62.r),
                  ),
                ),
              ),
              child: Column(
                children: [
                  // 搜索栏（固定在顶部）
                  Container(
                    width: 315.w,
                    height: 53.h,
                    margin: EdgeInsets.only(top: 20.h),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF05199E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 37.w),
                        Icon(
                          MdiIcons.magnify,
                          color: const Color(0xFF3D56FA),
                          size: 22.sp,
                        ),
                        SizedBox(width: 7.w),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            style: TextStyle(
                              color: const Color(0xFF3D56FA),
                              fontSize: 20.sp,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                color: const Color(0xFF3D56FA),
                                fontSize: 20.sp,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // 交易列表（可滚动）
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      itemCount: _filteredTransactions.length,
                      itemBuilder: (context, index) {
                        final transaction = _filteredTransactions[index];
                        return _buildTransactionItem(
                          transaction.title,
                          transaction.date,
                          transaction.amount,
                          transaction.iconBgColor,
                          transaction.icon,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(
    String title,
    String date,
    String amount,
    Color iconBgColor,
    IconData icon,
  ) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Row(
        children: [
          // 图标
          Container(
            width: 49.w,
            height: 48.h,
            decoration: ShapeDecoration(
              color: iconBgColor,
              shape: const OvalBorder(),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 14.w),
          // 标题和日期
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: const Color(0xFFFCFCFE),
                    fontSize: 20.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  date,
                  style: TextStyle(
                    color: const Color(0xFF80E0FF),
                    fontSize: 12.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // 金额
          Text(
            amount,
            style: TextStyle(
              color: const Color(0xFFFCFCFE),
              fontSize: 16.sp,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

// 添加交易项数据模型
class TransactionItem {
  final String title;
  final String date;
  final String amount;
  final Color iconBgColor;
  final IconData icon;

  TransactionItem({
    required this.title,
    required this.date,
    required this.amount,
    required this.iconBgColor,
    required this.icon,
  });
}
