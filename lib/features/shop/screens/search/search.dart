import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/products/product_cards/product_cards_vertical.dart';
import 'package:t_store/common/widgets/products/sortable/sortable_products.dart';
import 'package:t_store/common/widgets/search/search_product.dart';
import 'package:t_store/features/shop/controllers/product/product_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/constants/sizes.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final controller = Get.put(ProductController());
  final textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: const Text('Tìm kiếm sản phẩm'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            // Search Field
            SearchProductWidgets(textEditingController: textEditingController, controller: controller,hintText: 'Tìm kiếm sản phẩm...'),
            const SizedBox(height: TSizes.spaceBtwSections),

            const SizedBox(height: TSizes.spaceBtwSections),
            // Search Results
            Expanded(
              child: Obx(
                () => FutureBuilder(
                  future:
                      controller.timKiemSanPham(controller.truyXuatTimKiem.value),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
                      return const Center(
                        child: Text('Không tìm thấy sản phẩm...'),
                      );
                    }

                    final products = snapshot.data as List<SanPhamModel>;
                    TSortableProducts(
                      products: products,
                    );

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: TSizes.gridViewSpacing,
                        crossAxisSpacing: TSizes.gridViewSpacing,
                        mainAxisExtent: 288,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) => TProductCardVertical(
                        product: products[index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

