import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../controllers/wishlist_controller.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final TextEditingController _searchController = TextEditingController();
  late WishlistController _wishlistController;
  List<WishlistItem> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _wishlistController = context.read<WishlistController>();
    _filteredItems = _wishlistController.items;
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = _wishlistController.searchItems(query);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WishlistController>(
      builder: (context, controller, child) {
        final featuredItems =
            _filteredItems.where((item) => item.isFeatured).toList();
        final otherItems =
            _filteredItems.where((item) => !item.isFeatured).toList();

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Wishlist',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
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
          body: Column(
            children: [
              // 搜索栏
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w),
                child: Container(
                  height: 54.h,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFEFEFEF),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 23.w),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search Here',
                            hintStyle: TextStyle(
                              color: const Color(0xFF797979),
                              fontSize: 16.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Icon(
                        MdiIcons.magnify,
                        color: const Color(0xFF797979),
                        size: 24.sp,
                      ),
                      SizedBox(width: 15.w),
                    ],
                  ),
                ),
              ),

              // 推荐商品网格
              if (featuredItems.isNotEmpty)
                Container(
                  height: 162.h,
                  margin: EdgeInsets.only(top: 27.h),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 13.w),
                    itemCount: featuredItems.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          _buildFeaturedItem(
                            featuredItems[index],
                            controller,
                          ),
                          if (index < featuredItems.length - 1)
                            SizedBox(width: 20.w),
                        ],
                      );
                    },
                  ),
                ),

              // 其他商品列表标题
              if (otherItems.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 13.w, top: 27.h),
                        child: Text(
                          'Others',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 10),

              // 其他商品列表
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 13.w),
                  itemCount: otherItems.length,
                  itemBuilder: (context, index) {
                    final item = otherItems[index];
                    return _buildListItem(
                      item,
                      controller,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 修改构建方法，添加收藏功能
  Widget _buildFeaturedItem(WishlistItem item, WishlistController controller) {
    return Container(
      width: 205.w,
      height: 162.h,
      decoration: ShapeDecoration(
        color: const Color(0xFFC4C4C4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
        ),
      ),
      child: Stack(
        children: [
          // 商品图片
          ClipRRect(
            borderRadius: BorderRadius.circular(18.r),
            child: Image.asset(
              item.imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // 渐变遮罩
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 65.h,
            child: Container(
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: const Alignment(0.00, -1.00),
                  end: const Alignment(0, 1),
                  colors: [Colors.black.withOpacity(0), Colors.black],
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
              ),
            ),
          ),
          // 商品信息
          Positioned(
            left: 19.w,
            bottom: 26.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  item.price,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          // 收藏按钮
          Positioned(
            right: 16.w,
            bottom: 20.h,
            child: GestureDetector(
              onTap: () => controller.toggleFavorite(item),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 心形图标（作为边框）
                  Icon(
                    MdiIcons.heart,
                    color: item.isLiked ? Colors.white : Colors.grey,
                    size: 23.sp,
                  ),
                  // 心形图标（内部填充）
                  Icon(
                    MdiIcons.heart,
                    color:
                        item.isLiked ? const Color(0xFF2B39B8) : Colors.white,
                    size: 18.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(WishlistItem item, WishlistController controller) {
    return Container(
      width: 343.w,
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.r),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 2,
            offset: Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            // 商品图片
            Container(
              width: 93.w,
              height: 88.h,
              decoration: ShapeDecoration(
                color: const Color(0xFFC4C4C4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.r),
                ),
                image: DecorationImage(
                  image: AssetImage(item.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 14.w),
            // 商品信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  if (item.variant != null)
                    Text(
                      'Variant : ${item.variant}',
                      style: TextStyle(
                        color: const Color(0xFF777777),
                        fontSize: 12.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  SizedBox(height: 12.h),
                  Text(
                    item.price,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            // 收藏按钮
            GestureDetector(
              onTap: () => controller.toggleFavorite(item),
              child: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Icon(
                  MdiIcons.heart,
                  color: const Color(0xFF2B39B8),
                  size: 24.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
