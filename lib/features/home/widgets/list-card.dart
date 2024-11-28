import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gaya_2/models/tab_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListCard extends StatefulWidget {
  final List<Item> CardList;
  final Function(int) onCardTap;

  const ListCard({super.key, required this.CardList, required this.onCardTap});
  @override
  State<StatefulWidget> createState() {
    return _ListCardState();
  }
}

class _ListCardState extends State<ListCard> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 28.w, right: 28.w),
      child: Column(
        children: [
          SizedBox(height: 30.h),
          GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1),
              itemCount: widget.CardList.length,
              itemBuilder: (context, index) {
                final item = widget.CardList[index];
                return SizedBox(
                  height: 144.h,
                  child: GestureDetector(
                    onTap: () => widget.onCardTap(index),
                    child: Card(
                      color: const Color.fromRGBO(43, 57, 185, 1),
                      child: Stack(children: [
                        Positioned(
                          bottom: 10.h,
                          right: 0,
                          child: Opacity(
                            opacity: 1, // 设置水印透明度
                            child: item.watermark != null
                                ? Image.asset(
                                    item.watermark ?? '',
                                    // width: 80, // 设置水印图片大小
                                    fit: BoxFit.cover,
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(item.iconUrl),
                              SizedBox(
                                height: 19.h,
                              ),
                              Text(
                                item.typeName,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.sp),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              AutoSizeText(
                                item.shortName,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${item.collectionNumber} Collections',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.sp),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
