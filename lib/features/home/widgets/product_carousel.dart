import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProductCarousel extends StatefulWidget {
  final List<String> images;
  final VoidCallback? onBackPressed;
  final VoidCallback? onFavoritePressed;

  const ProductCarousel({
    super.key,
    required this.images,
    this.onBackPressed,
    this.onFavoritePressed,
  });

  @override
  State<ProductCarousel> createState() => _ProductCarouselState();
}

class _ProductCarouselState extends State<ProductCarousel> {
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
      child: Stack(
        children: widget.images.asMap().entries.map((entry) {
          final index = entry.key;
          final isSelected = index == _currentIndex;
          final leftPosition =
              index == 0 ? 0.0 : 16.0 * index + (index > 1 ? 12.0 : 0.0);

          return Positioned(
            left: leftPosition.w,
            top: 0,
            child: Container(
              width: isSelected ? 24.w : 12.w,
              height: 4.h,
              decoration: ShapeDecoration(
                color: isSelected
                    ? const Color(0xFF2B39B8)
                    : const Color(0x35585858),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.r),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 377.w,
          height: 404.h,
          child: Stack(
            children: [
              // 第一层背景
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 377.w,
                  height: 404.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFFC4C4C4),
                  ),
                ),
              ),
              // 第二层内容
              Positioned(
                left: 0,
                top: 0,
                child: SizedBox(
                  width: 377.w,
                  height: 404.h,
                  child: Stack(
                    children: [
                      // 内层背景
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 377.w,
                          height: 404.h,
                          decoration: const BoxDecoration(
                            color: Color(0xFFC4C4C4),
                          ),
                        ),
                      ),
                      // 图片轮播
                      Positioned(
                        left: -1.w,
                        top: -14.h,
                        child: SizedBox(
                          width: 378.w,
                          height: 473.h,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: widget.images.length,
                            onPageChanged: (index) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(widget.images[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      // 指示器
                      Positioned(
                        bottom: 40.h,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: _buildDotIndicator(),
                        ),
                      ),
                      // 返回按钮
                      Positioned(
                        left: 16.w,
                        top: 44.h,
                        child: GestureDetector(
                          onTap: widget.onBackPressed,
                          child: Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Icon(
                              MdiIcons.chevronLeft,
                              color: Colors.black,
                              size: 24.sp,
                            ),
                          ),
                        ),
                      ),
                      // 收藏按钮
                      Positioned(
                        right: 16.w,
                        top: 44.h,
                        child: GestureDetector(
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
