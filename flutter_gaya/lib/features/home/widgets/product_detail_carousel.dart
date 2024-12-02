import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductDetailCarousel extends StatelessWidget {
  final List<String> images;
  final VoidCallback onBackPressed;
  final VoidCallback? onFavoritePressed;

  const ProductDetailCarousel({
    super.key,
    required this.images,
    required this.onBackPressed,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 364.h,
            viewportFraction: 1.0,
            enableInfiniteScroll: false,
          ),
          items: images.map((imageUrl) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: imageUrl.startsWith('http')
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/home/product1.png',
                              fit: BoxFit.cover,
                            );
                          },
                        )
                      : Image.asset(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                );
              },
            );
          }).toList(),
        ),
        // ... 其他代码保持不变
      ],
    );
  }
}
