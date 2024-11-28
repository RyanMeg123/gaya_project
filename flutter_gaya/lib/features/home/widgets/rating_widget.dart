import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RatingWidget extends StatelessWidget {
  final double rating; // e.g., 3.5 out of 5
  final int maxRating; // max rating, e.g., 5 stars

  const RatingWidget({
    super.key,
    required this.rating,
    this.maxRating = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (index) {
        return Icon(
          index < rating
              ? MdiIcons.star
              : (index < rating + 0.5
                  ? MdiIcons.starHalf
                  : MdiIcons.starOutline),
          color: Colors.amber,
          size: 24.sp,
        );
      }),
    );
  }
}
