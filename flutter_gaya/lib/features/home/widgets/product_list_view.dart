import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../models/tab_model.dart';
import 'product_card.dart';

class ProductListView extends StatelessWidget {
  final List<ProductDetails> products;
  final bool isGridView;
  final ScrollController scrollController;
  final Function(ProductDetail) onProductTap;
  final Function(String) onViewChange;

  const ProductListView({
    super.key,
    required this.products,
    required this.isGridView,
    required this.scrollController,
    required this.onProductTap,
    required this.onViewChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        SizedBox(height: 20.h),
        Expanded(
          child: _buildProductList(),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildProductCount(),
        _buildViewToggleButtons(),
      ],
    );
  }

  Widget _buildProductCount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${products.length} products',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Based your filter',
          style: TextStyle(
            color: const Color.fromRGBO(119, 119, 119, 1),
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildViewToggleButtons() {
    return Row(
      children: [
        // _buildViewToggleButton(
        //   isGrid: false,
        //   icon: MdiIcons.viewSequential,
        //   onTap: () => onViewChange('column'),
        // ),
        SizedBox(width: 8.w),
        _buildViewToggleButton(
          isGrid: true,
          icon: MdiIcons.viewGrid,
          onTap: () => onViewChange('grid'),
        ),
      ],
    );
  }

  Widget _buildViewToggleButton({
    required bool isGrid,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    const bool isSelected = true;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 48.w,
        height: 48.h,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color:
                isSelected ? const Color.fromRGBO(43, 57, 185, 1) : Colors.grey,
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(
          icon,
          color:
              isSelected ? const Color.fromRGBO(43, 57, 185, 1) : Colors.grey,
        ),
      ),
    );
  }

  Widget _buildProductList() {
    if (products.isEmpty) {
      return const Center(child: Text('No products found'));
    }

    final rowCount = (products.length / 2).ceil();

    return ListView.builder(
      controller: scrollController,
      itemCount: rowCount,
      itemBuilder: (context, index) => _buildProductItem(index),
    );
  }

  Widget _buildProductItem(int index) {
    if (isGridView && index * 2 + 1 < products.length) {
      return Row(
        children: [
          Expanded(child: _buildProductCard(index * 2)),
          SizedBox(width: 10.w),
          Expanded(child: _buildProductCard(index * 2 + 1)),
        ],
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _buildProductCard(index),
    );
  }

  Widget _buildProductCard(int index) {
    final product = products[index];
    return ProductCard(
      isGridView: isGridView,
      productId: product.productId,
      productImg: product.imageUrl ?? '',
      name: product.name ?? '',
      discountAmount: product.discountAmount ?? 0,
      originalPrice: product.originalPrice ?? 0,
      discountPrice: product.discountPrice,
      collectAmount: product.collectAmount ?? 0,
      onTap: () => onProductTap(product),
    );
  }
}
