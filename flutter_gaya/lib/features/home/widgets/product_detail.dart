import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/tab_model.dart';
import 'product_detail_carousel.dart';
import 'product_info.dart';
import 'product_bottom_bar.dart';
import '../../../features/home/controllers/cart_controller.dart';

class ProductDetailWidget extends StatefulWidget {
  final ProductDetail product;
  final VoidCallback? onFavoritePressed;
  final VoidCallback? onAddToCartPressed;
  final CartController cartController;

  const ProductDetailWidget({
    super.key,
    required this.product,
    this.onFavoritePressed,
    this.onAddToCartPressed,
    required this.cartController,
  });

  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget>
    with SingleTickerProviderStateMixin {
  String selectedSize = 'Medium';
  bool isCollapsed = false;
  bool _isExpanded = false;
  double _startDragY = 0;
  double _currentOffset = 0;
  double _dragDistance = 0;

  // 修改关键尺寸和阈值
  final double _maxOffset = 242.h;
  final double _dragThreshold = 30.h; // 降低拖动阈值，使触发更容易
  final double _dragResistance = 0.5; // 添加拖动阻尼系数

  // 添加动画控制器
  late AnimationController _cartAnimationController;
  Offset? _startOffset;
  final GlobalKey _productKey = GlobalKey();

  List<String> get _productImages {
    final imageUrl = widget.product.imageUrl;
    if (imageUrl == null || imageUrl.isEmpty) {
      return List.filled(3, 'assets/images/home/product1.png');
    }
    // 如果是网络图片，返回相同的URL
    if (imageUrl.startsWith('http')) {
      return List.filled(3, imageUrl);
    }
    // 如果是本地图片，使用本地路径
    return List.filled(3, imageUrl);
  }

  void _handleDragStart(DragStartDetails details) {
    _startDragY = details.globalPosition.dy;
    _dragDistance = 0;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _dragDistance = _startDragY - details.globalPosition.dy;

    // 增加阻尼效果
    double dampedDragDistance = _dragDistance * 0.3; // 降低阻尼系数

    if (_isExpanded && _dragDistance < 0) {
      double newOffset = _maxOffset + dampedDragDistance;
      if (newOffset < 0) newOffset = 0;
      setState(() {
        _currentOffset = newOffset;
        isCollapsed = newOffset > _dragThreshold;
      });
    } else if (!_isExpanded && _dragDistance > 0) {
      double newOffset = dampedDragDistance;
      if (newOffset > _maxOffset) newOffset = _maxOffset;
      setState(() {
        _currentOffset = newOffset;
        isCollapsed = newOffset > _dragThreshold;
      });
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    final bool shouldExpand = velocity < -300 || // 降低速度阈值
        (_dragDistance.abs() > _dragThreshold && _dragDistance > 0);
    final bool shouldCollapse = velocity > 300 || // 降低速度阈值
        (_dragDistance.abs() > _dragThreshold && _dragDistance < 0);

    setState(() {
      if (shouldExpand) {
        _isExpanded = true;
        isCollapsed = true;
        _currentOffset = _maxOffset;
      } else if (shouldCollapse) {
        _isExpanded = false;
        isCollapsed = false;
        _currentOffset = 0;
      } else {
        // 恢复到最近的状态
        _currentOffset = _isExpanded ? _maxOffset : 0;
        isCollapsed = _isExpanded;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // 初始化动画控制器
    _cartAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _cartAnimationController.dispose();
    super.dispose();
  }

  // 添加购物车动画效果
  void _playAddToCartAnimation() {
    // 获取商品图片的位置
    final RenderBox? productBox =
        _productKey.currentContext?.findRenderObject() as RenderBox?;
    if (productBox == null) return;

    final productPosition = productBox.localToGlobal(Offset.zero);
    _startOffset = productPosition;

    // 创建一个临时的悬浮商品图片
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) {
        return AnimatedBuilder(
          animation: _cartAnimationController,
          builder: (context, child) {
            // 计算贝塞尔曲线路径
            final double t = _cartAnimationController.value;

            // 起点：商品位置
            final Offset start = _startOffset!;
            // 终点：购物车按钮位置（屏幕底部中间）
            final Offset end = Offset(
              MediaQuery.of(context).size.width / 2,
              MediaQuery.of(context).size.height - 40.h,
            );
            // 控制点：用于创建抛物线效果
            final Offset control = Offset(
              end.dx,
              start.dy - 100.h,
            );

            // 计算当前位置
            final double x =
                _calculateBezierPoint(t, start.dx, control.dx, end.dx);
            final double y =
                _calculateBezierPoint(t, start.dy, control.dy, end.dy);

            // 缩放和透明度效果
            final double scale = 1 - t * 0.3;
            final double opacity = 1 - t * 0.3;

            return Positioned(
              right: x - -30.w,
              top: y - 30.h,
              child: Transform.scale(
                scale: scale,
                child: Opacity(
                  opacity: opacity,
                  child: Container(
                    width: 130.w,
                    height: 130.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: widget.product.imageUrl?.startsWith('http') ?? false
                        ? Image.network(
                            widget.product.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/home/product1.png',
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.asset(
                            widget.product.imageUrl ??
                                'assets/images/home/product1.png',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    // 显示动画
    Overlay.of(context).insert(overlayEntry);

    // 播放动画
    _cartAnimationController.forward().then((_) {
      // 确保在动画完成后移除悬浮图片
      overlayEntry.remove();
      _cartAnimationController.reset();

      // 添加到购物车
      widget.cartController.addToCart(widget.product, selectedSize);

      // 显示提示
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Added to cart'),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  // 计算贝塞尔曲线上的点
  double _calculateBezierPoint(
      double t, double start, double control, double end) {
    return (1 - t) * (1 - t) * start + 2 * (1 - t) * t * control + t * t * end;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomBarHeight = 85.h;
    final infoMinHeight = screenHeight - 364.h;
    final infoMaxHeight = screenHeight * 0.8;

    return Scaffold(
      body: SizedBox(
        height: screenHeight,
        child: Stack(
          children: [
            // 使用新的轮播图组件
            ProductDetailCarousel(
              key: _productKey, // 添加 key 用于获取位置
              images: _productImages,
              onBackPressed: () => Navigator.pop(context),
              onFavoritePressed: widget.onFavoritePressed,
            ),

            // 商品详情信息面板
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400), // 增加动画时间
              curve: Curves.easeInOutCubic, // 使用更平滑的动画曲线
              top: _isExpanded ? screenHeight * 0.1 : 364.h - _currentOffset,
              left: 0,
              right: 0,
              height: _isExpanded ? infoMaxHeight : infoMinHeight,
              child: GestureDetector(
                onVerticalDragStart: _handleDragStart,
                onVerticalDragUpdate: _handleDragUpdate,
                onVerticalDragEnd: _handleDragEnd,
                child: ProductInfo(
                  product: widget.product,
                  selectedSize: selectedSize,
                  onSizeSelected: (size) {
                    setState(() {
                      selectedSize = size;
                    });
                  },
                  isCollapsed: isCollapsed,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ProductBottomBar(
        onAddToCartPressed: () {
          _playAddToCartAnimation(); // 只调用动画方法，其他逻辑移到动画完成后
        },
      ),
    );
  }
}
