import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/scheduler.dart';

// Services & Providers
import '../../../services/api_service.dart';
import '../../../providers/user_provider.dart';
import '../../../providers/transaction_provider.dart';

class TransactionTab extends StatefulWidget {
  const TransactionTab({super.key});

  @override
  State<TransactionTab> createState() => _TransactionTabState();
}

class _TransactionTabState extends State<TransactionTab> {
  final TextEditingController _searchController = TextEditingController();
  List<TransactionItem> _allTransactions = [];
  List<TransactionItem> _filteredTransactions = [];
  bool _isLoading = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterTransactions);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _loadTransactions();
      _isInitialized = true;
    }
  }

  Future<void> _loadTransactions() async {
    if (!mounted) return;
    
    setState(() => _isLoading = true);
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final transactionProvider =
          Provider.of<TransactionProvider>(context, listen: false);

      if (userProvider.userId == null) {
        throw Exception('User not logged in');
      }

      await transactionProvider.loadUserTransactions(userProvider.userId!);
      
      if (!mounted) return;
      
      setState(() {
        _allTransactions = transactionProvider.transactions
            .map((t) => TransactionItem(
                  title: t['type'] ?? 'Shopping',
                  date: DateFormat('dd MMM yyyy, h:mma')
                      .format(DateTime.parse(t['createdAt'])),
                  amount:
                      '-\$${double.parse(t['amount'].toString()).toStringAsFixed(2)}',
                  iconBgColor: _getIconBgColor(t['type']),
                  icon: _getIconData(t['type']),
                ))
            .toList();

        _filteredTransactions = _allTransactions;
      });
    } catch (e) {
      print('Error loading transactions: $e');
      if (mounted) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString() == 'User not logged in'
                  ? 'Please login to view transactions'
                  : 'Failed to load transactions'),
              backgroundColor: Colors.red,
            ),
          );
        });
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
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
    return Consumer<TransactionProvider>(
      builder: (context, transactionProvider, _) {
        return Column(
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
                  // 标题
                  Padding(
                    padding: EdgeInsets.only(top: 64.h),
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

                  // 总支出金额
                  Column(
                    children: [
                      Text(
                        'Your total expenses',
                        style: TextStyle(
                          color: const Color(0xFF87F0FF),
                          fontSize: 22.5.sp,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        '\$${transactionProvider.totalExpenses.toStringAsFixed(2)}',
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

            SizedBox(height: 26.h),

            // 交易列表区域
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
                    // 搜索栏
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

                    // 交易列表
                    Expanded(
                      child: transactionProvider.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : _filteredTransactions.isEmpty
                              ? Center(
                                  child: Text(
                                    'No transactions found',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 30.w),
                                  itemCount: _filteredTransactions.length,
                                  itemBuilder: (context, index) {
                                    final transaction =
                                        _filteredTransactions[index];
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
        );
      },
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

  Color _getIconBgColor(String type) {
    switch (type) {
      case 'Shopping':
        return const Color(0xFFFFCF81);
      case 'Medicine':
        return const Color(0xFFE09FFF);
      case 'Sport':
        return const Color(0xEA00DADE);
      case 'Travel':
        return const Color(0xEAFF8787);
      default:
        return Colors.grey;
    }
  }

  IconData _getIconData(String type) {
    switch (type) {
      case 'Shopping':
        return MdiIcons.cartOutline;
      case 'Medicine':
        return MdiIcons.pill;
      case 'Sport':
        return MdiIcons.basketball;
      case 'Travel':
        return MdiIcons.airplane;
      default:
        return MdiIcons.helpCircleOutline;
    }
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
