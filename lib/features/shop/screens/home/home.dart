import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/chatbot/chatbot.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:t_store/common/widgets/layouts/grid_layout.dart';
import 'package:t_store/common/widgets/products/product_cards/product_cards_vertical.dart';
import 'package:t_store/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/personalization/controllers/chatbot_controller.dart';
import 'package:t_store/features/shop/controllers/product/product_controller.dart';
import 'package:t_store/features/shop/screens/all_products/all_products.dart';
import 'package:t_store/features/shop/screens/home/widget/home_appbar.dart';
import 'package:t_store/features/shop/screens/home/widget/home_categories.dart';
import 'package:t_store/features/shop/screens/home/widget/promo_slider.dart';
import 'package:t_store/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    Get.put(ChatBotController(), permanent: true);
    
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const TPrimaryHeaderContainer(
                  child: Column(
                    children: [
                      // Thanh tiêu đề
                      THomeAppBar(),
                      SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),
                     
                      // Danh mục
                      Column(
                        children: [
                          // Tiêu đề
                          Padding(
                            padding: EdgeInsets.only(left: TSizes.defaultSpace),
                            child: TSectionHeading(
                              title: "Danh mục phổ biến",
                              showActionButton: false,
                              textColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          // Danh sách danh mục
                          THomeCategories(),
                        ],
                      ),
                      SizedBox(
                        height: TSizes.spaceBtwSections,
                      ),
                    ],
                  ),
                ),
                // Nội dung chính
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 15.0),
                    child: Column(
                      children: [
                        // Slider khuyến mãi
                        const TPromoSlider(),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        // Tiêu đề
                        TSectionHeading(
                          title: "Sản phẩm nổi bật",
                          onPressed: () => Get.to(() => AllProductsScreen(
                                title: "Sản phẩm nổi bật",
                                query: FirebaseFirestore.instance
                                    .collection("SanPham")
                                    .where("IsFeatured", isEqualTo: true)
                                    .limit(6),
                                futureMethod: controller.layTatCaSanPhamNoiBat(),
                              )),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwInputFields,
                        ),
                        // Lưới sản phẩm
                        Obx(() {
                          if (controller.dangTai.value) {
                            return const TVerticalProductShimmer();
                          }
                          if (controller.danhSachSanPham.isEmpty) {
                            return Center(
                              child: Text(
                                "Không tìm thấy dữ liệu",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .apply(color: Colors.white),
                              ),
                            );
                          }
                          return TGridLayout(
                            itemCount: controller.danhSachSanPham.length,
                            itemBuilder: (_, index) => TProductCardVertical(
                              product: controller.danhSachSanPham[index],
                            ),
                          );
                        })
                      ],
                    ))
              ],
            ),
          ),
          const ChatBot(),
        ],
      ),
    );
  }
}
