import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/tab_model.dart';
import '../widgets/map/amap_widget.dart';
import '../widgets/tracking/delivery_progress.dart';

class TrackingOrderPage extends StatefulWidget {
  final OrderItem orderItem;

  const TrackingOrderPage({
    super.key,
    required this.orderItem,
  });

  @override
  State<TrackingOrderPage> createState() => _TrackingOrderPageState();
}

class _TrackingOrderPageState extends State<TrackingOrderPage> {
  late Timer _locationUpdateTimer;
  double _progress = 0.0;
  final Map<String, Marker> _markers = <String, Marker>{};
  final Map<String, Polyline> _polylines = <String, Polyline>{};

  // 定义起点和终点
  final LatLng _startLocation = const LatLng(39.909187, 116.397451);
  final LatLng _endLocation = const LatLng(39.904989, 116.405285);

  // 当前位置
  late LatLng _currentLocation;

  // 添加路况信息
  final Map<String, String> _trafficInfo = {
    'estimatedTime': '25 mins',
    'distance': '3.2 km',
    'trafficCondition': 'Light', // Light, Moderate, Heavy
  };

  // 添加派送员信息
  final Map<String, String> _deliveryInfo = {
    'name': 'John Delivery',
    'phone': '+1 234 5678 900',
    'rating': '4.8',
    'deliveries': '1.2k',
  };

  @override
  void initState() {
    super.initState();
    _currentLocation = _startLocation;
    _setupMarkers();
    _setupPolyline();
    _startLocationUpdates();
  }

  void _setupMarkers() {
    _markers['delivery'] = Marker(
      position: _currentLocation,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );

    _markers['destination'] = Marker(
      position: _endLocation,
      icon: BitmapDescriptor.defaultMarker,
    );
  }

  void _setupPolyline() {
    _polylines['route'] = Polyline(
      points: [_currentLocation, _endLocation],
      width: 6,
      color: const Color(0xFF2B39B8),
    );
  }

  void _startLocationUpdates() {
    _locationUpdateTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _progress = (_progress + 0.05).clamp(0.0, 1.0);
        if (_progress >= 1.0) {
          timer.cancel();
        }
        _updateDeliveryLocation();
      });
    });
  }

  void _updateDeliveryLocation() {
    final newLat = _startLocation.latitude +
        (_endLocation.latitude - _startLocation.latitude) * _progress;
    final newLng = _startLocation.longitude +
        (_endLocation.longitude - _startLocation.longitude) * _progress;

    setState(() {
      _currentLocation = LatLng(newLat, newLng);

      // 更新标记
      _markers['delivery'] = Marker(
        position: _currentLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );

      // 更新路线
      _polylines['route'] = Polyline(
        points: [_currentLocation, _endLocation],
        width: 6,
        color: const Color(0xFF2B39B8),
      );
    });
  }

  @override
  void dispose() {
    _locationUpdateTimer.cancel();
    super.dispose();
  }

  // 添加路况信息卡片
  Widget _buildTrafficInfoCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 预计时间
          Column(
            children: [
              Icon(
                Icons.access_time,
                color: const Color(0xFF2B39B8),
                size: 24.sp,
              ),
              SizedBox(height: 8.h),
              Text(
                _trafficInfo['estimatedTime']!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Est. Time',
                style: TextStyle(
                  color: const Color(0xFF777777),
                  fontSize: 12.sp,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),

          // 分隔线
          Container(
            height: 40.h,
            width: 1.w,
            color: const Color(0xFFE0E0E0),
          ),

          // 距离
          Column(
            children: [
              Icon(
                Icons.directions_car,
                color: const Color(0xFF2B39B8),
                size: 24.sp,
              ),
              SizedBox(height: 8.h),
              Text(
                _trafficInfo['distance']!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Distance',
                style: TextStyle(
                  color: const Color(0xFF777777),
                  fontSize: 12.sp,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),

          // 分隔线
          Container(
            height: 40.h,
            width: 1.w,
            color: const Color(0xFFE0E0E0),
          ),

          // 路况状况
          Column(
            children: [
              Icon(
                _getTrafficIcon(),
                color: _getTrafficColor(),
                size: 24.sp,
              ),
              SizedBox(height: 8.h),
              Text(
                _trafficInfo['trafficCondition']!,
                style: TextStyle(
                  color: _getTrafficColor(),
                  fontSize: 16.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Traffic',
                style: TextStyle(
                  color: const Color(0xFF777777),
                  fontSize: 12.sp,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 获取路况图标
  IconData _getTrafficIcon() {
    switch (_trafficInfo['trafficCondition']) {
      case 'Light':
        return Icons.traffic_rounded;
      case 'Moderate':
        return Icons.traffic_rounded;
      case 'Heavy':
        return Icons.traffic_rounded;
      default:
        return Icons.traffic_rounded;
    }
  }

  // 获取路况颜色
  Color _getTrafficColor() {
    switch (_trafficInfo['trafficCondition']) {
      case 'Light':
        return const Color(0xFF1DB73F); // 绿色
      case 'Moderate':
        return const Color(0xFFFFB800); // 黄色
      case 'Heavy':
        return const Color(0xFFE83737); // 红色
      default:
        return const Color(0xFF777777);
    }
  }

  // 添加联系方式处理函数
  Future<void> _handleCall() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: _deliveryInfo['phone'],
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Could not launch phone call',
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Poppins',
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _handleMessage() {
    // 显示消息对话框
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildMessageDialog(),
    );
  }

  Widget _buildMessageDialog() {
    final TextEditingController messageController = TextEditingController();

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          // 标题栏
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 15.h,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: const Color(0xFFE0E0E0),
                  width: 1.h,
                ),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: const Color(0xFFD1D5FF),
                  child: Icon(
                    MdiIcons.accountOutline,
                    color: const Color(0xFF2B39B8),
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  _deliveryInfo['name']!,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.close, size: 24.sp),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          // 消息列表
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.w),
              children: [
                _buildMessageBubble(
                  'Hi, I\'m on my way to deliver your order.',
                  isDeliveryMan: true,
                  time: '10:30 AM',
                ),
                _buildMessageBubble(
                  'Ok, thank you! Please be careful.',
                  isDeliveryMan: false,
                  time: '10:31 AM',
                ),
              ],
            ),
          ),

          // 输入框
          Container(
            padding: EdgeInsets.all(20.w).copyWith(
              bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(
                        color: const Color(0xFF777777),
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2B39B8),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                    onPressed: () {
                      if (messageController.text.isNotEmpty) {
                        // TODO: 处理发送消息
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(
    String message, {
    required bool isDeliveryMan,
    required String time,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment:
            isDeliveryMan ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDeliveryMan) ...[
            CircleAvatar(
              radius: 16.r,
              backgroundColor: const Color(0xFFD1D5FF),
              child: Icon(
                MdiIcons.accountOutline,
                color: const Color(0xFF2B39B8),
                size: 20.sp,
              ),
            ),
            SizedBox(width: 8.w),
          ],
          Column(
            crossAxisAlignment: isDeliveryMan
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 10.h,
                ),
                decoration: BoxDecoration(
                  color: isDeliveryMan
                      ? const Color(0xFFF5F5F5)
                      : const Color(0xFF2B39B8),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  message,
                  style: TextStyle(
                    color: isDeliveryMan ? Colors.black : Colors.white,
                    fontSize: 14.sp,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                time,
                style: TextStyle(
                  color: const Color(0xFF777777),
                  fontSize: 12.sp,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          if (!isDeliveryMan) ...[
            SizedBox(width: 8.w),
            CircleAvatar(
              radius: 16.r,
              backgroundColor: const Color(0xFFD1D5FF),
              child: Icon(
                Icons.person,
                color: const Color(0xFF2B39B8),
                size: 20.sp,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tracking Order',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            height: 0.05,
            letterSpacing: -0.24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(MdiIcons.arrowLeft, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 地图部分
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Stack(
                children: [
                  CustomAMapWidget(
                    iosKey: '68d8c02969855570a237d70f71134dc1',
                    androidKey: '你的安卓key',
                    initialLocation: _startLocation,
                    markers: Set<Marker>.of(_markers.values),
                    polylines: Set<Polyline>.of(_polylines.values),
                  ),
                  // 添加路况信息卡片
                  Positioned(
                    bottom: 10.h,
                    left: 0,
                    right: 0,
                    child: _buildTrafficInfoCard(),
                  ),
                ],
              ),
            ),

            // // 添加配送进度指示器
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            //   child: DeliveryProgress(progress: _progress),
            // ),

            // 订单信息
            Container(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 订单编号和状态
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order #${widget.orderItem.orderNumber}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD1D5FF),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          widget.orderItem.status,
                          style: TextStyle(
                            color: const Color(0xFF2B39B8),
                            fontSize: 14.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // 派送员信息卡片
                  Container(
                    padding: EdgeInsets.all(15.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25.r,
                              backgroundColor: const Color(0xFFD1D5FF),
                              child: Icon(
                                MdiIcons.accountOutline,
                                color: const Color(0xFF2B39B8),
                                size: 30.sp,
                              ),
                            ),
                            SizedBox(width: 15.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _deliveryInfo['name']!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: const Color(0xFFFFB800),
                                        size: 16.sp,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        '${_deliveryInfo['rating']} (${_deliveryInfo['deliveries']} Deliveries)',
                                        style: TextStyle(
                                          color: const Color(0xFF777777),
                                          fontSize: 14.sp,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _handleCall,
                                icon: Icon(
                                  MdiIcons.phone,
                                  size: 20.sp,
                                ),
                                label: Text(
                                  'Call',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2B39B8),
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: _handleMessage,
                                icon: Icon(
                                  MdiIcons.message,
                                  size: 20.sp,
                                ),
                                label: Text(
                                  'Message',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFF2B39B8),
                                  side: const BorderSide(
                                    color: Color(0xFF2B39B8),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
