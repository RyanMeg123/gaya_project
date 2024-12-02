import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCarousel extends StatefulWidget {
  final List<String> imgList;

  const CustomCarousel({
    super.key,
    required this.imgList,
  });

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 18.h),
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            height: 174.h,
            aspectRatio: 16 / 9,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: widget.imgList.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: item.startsWith('http')
                        ? Image.network(
                            item,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/home/banner1.png',
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.asset(
                            item,
                            fit: BoxFit.cover,
                          ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imgList.asMap().entries.map((entry) {
            return Container(
              width: _currentIndex == entry.key ? 24.0 : 12.0,
              height: 4.h,
              margin: EdgeInsets.symmetric(horizontal: 2.w),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: _currentIndex == entry.key
                    ? const Color.fromRGBO(43, 57, 185, 1)
                    : const Color.fromRGBO(0, 0, 0, 0.21),
                borderRadius: BorderRadius.circular(16.r),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
