import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProductDetailCarousel extends StatefulWidget {
  final List<String> images;
  final VoidCallback? onBackPressed;
  final VoidCallback? onFavoritePressed;

  const ProductDetailCarousel({
    super.key,
    required this.images,
    this.onBackPressed,
    this.onFavoritePressed,
  });

  @override
  State<ProductDetailCarousel> createState() => _ProductDetailCarouselState();
}

class _ProductDetailCarouselState extends State<ProductDetailCarousel> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        if (_currentIndex < widget.images.length - 1) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
        _startAutoPlay();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildDotIndicator() {
    return SizedBox(
      width: 88.w,
      height: 4.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.images.asMap().entries.map((entry) {
          final index = entry.key;
          final isSelected = index == _currentIndex;

          return Container(
            width: isSelected ? 24.w : 12.w,
            height: 4.h,
            margin: EdgeInsets.only(
              left: index == 0 ? 0 : 4.w,
            ),
            decoration: ShapeDecoration(
              color: isSelected
                  ? const Color.fromRGBO(43, 57, 185, 1)
                  : const Color.fromRGBO(88, 88, 88, 0.21),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.r),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 404.h + statusBarHeight,
      color: const Color(0xFFC4C4C4),
      child: Stack(
        children: [
          // 图片轮播
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.images.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.asset(
                  widget.images[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),

          // 顶部按钮
          Positioned(
            top: statusBarHeight + 14.h,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 返回按钮
                  GestureDetector(
                    onTap: widget.onBackPressed,
                    child: const Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                    ),
                  ),
                  // 收藏按钮
                  GestureDetector(
                    onTap: widget.onFavoritePressed,
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Icon(
                        MdiIcons.heart,
                        color: Colors.black,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 指示器
          Positioned(
            bottom: 130.h,
            left: 0,
            right: 0,
            child: Center(
              child: _buildDotIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
