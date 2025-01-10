import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/brands/brand_showcase.dart';
import 'package:t_store/common/widgets/shimmers/boxes_shimmer.dart';
import 'package:t_store/common/widgets/shimmers/list_tile_shimmer.dart';
import 'package:t_store/features/shop/controllers/brand_controller.dart';
import 'package:t_store/features/shop/models/category_model.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/cloud_helper_functions.dart';

class TCategoryBrands extends StatelessWidget {
  const TCategoryBrands({super.key, required this.category});
  final DanhMucModel category;
  
  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return FutureBuilder(
        future: brandController.layThuongHieuTheoDanhMuc(category.id),
        builder: (context, snapshot) {
          const loader = Column(
            children: [
              TListTileShimmer(),
              SizedBox(height: TSizes.spaceBtwItems),
              TBoxesShimmer(),
              SizedBox(height: TSizes.spaceBtwItems)
            ],
          );

          // Add proper snapshot state handling
          final widget = TCloudHelperFunctions.checkMultiRecordState(
            snapshot: snapshot,
            loader: loader,
            nothingFound: const SizedBox(), // Empty widget if nothing found
          );
          if (widget != null) return widget;

          // Only proceed if we have valid data
          final brands = snapshot.data!;
          if (brands.isEmpty) return const SizedBox();

          return Column(
            children: brands.map((brand) {
              return FutureBuilder(
                future: brandController.laySanPhamTheoThuongHieu(brandId: brand.id, limit: 3),
                builder: (context, productSnapshot) {
                  if (!productSnapshot.hasData || productSnapshot.data == null) {
                    return loader;
                  }

                  final products = productSnapshot.data!;
                  if (products.isEmpty) return const SizedBox();

                  return Column(
                    children: [
                      TBrandShowCase(
                        brand: brand,
                        images: products.map((e) => e.anhDaiDien).toList(),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems),
                    ],
                  );
                },
              );
            }).toList(),
          );
        });
  }
}
