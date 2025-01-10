import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/controllers/product/cart_controller.dart';
import 'package:t_store/features/shop/controllers/product/variation_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/features/shop/screens/checkout/checkout.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_image_slider.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});
  final SanPhamModel product;
  
  @override
  Widget build(BuildContext context) {
    final variationController = Get.put(VariationController());
    final cartController = Get.put(CartController());

    return WillPopScope(
      onWillPop: () async {
        variationController.resetSelectedAttributes();
        return true;
      },
      child: Scaffold(
        // Giỏ hàng dưới cùng
        bottomNavigationBar: TBottomAddToCart(
          product: product,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            // Slider ảnh sản phẩm
            TProductImageSlider(
              product: product,
            ),

            // Chi tiết sản phẩm
            Padding(
              padding: const EdgeInsets.only(
                  right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  // Đánh giá và nút chia sẻ
                  const TRatingAndShare(),

                  // Giá, tiêu đề, tồn kho và thương hiệu
                  TProductMetaData(
                    product: product,
                  ),

                  // Thuộc tính sản phẩm
                  if (product.loaiSanPham == ProductType.variable.toString())
                    TProductAttributes(
                      product: product,
                    ),
                  if (product.loaiSanPham == ProductType.variable.toString())
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),

                  // Nút thanh toán
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                            try {
                              // Thêm sản phẩm vào giỏ hàng
                              cartController.addToCart(product);
                              
                              // Đợi 1 chút để đảm bảo giỏ hàng đã được cập nhật
                              await Future.delayed(const Duration(milliseconds: 300));
                              
                              // Kiểm tra nếu sản phẩm đã được thêm vào giỏ hàng thành công
                              if (cartController.danhSachGioHang.any((item) => item.maSanPham == product.id)) {
                                // Chuyển sang trang checkout
                                Get.to(() => const CheckOutScreen());
                              }
                            } catch (e) {
                              Get.snackbar(
                                'Lỗi',
                                'Không thể thêm sản phẩm vào giỏ hàng',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          },
                      child: Text(
                        "Thanh toán",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .apply(color: Colors.white),
                      )
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  // Mô tả
                  const TSectionHeading(
                    title: "Mô tả",
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  ReadMoreText(
                    product.moTa ?? "Đây là mô tả sản phẩm.",
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: "  Xem thêm",
                    trimExpandedText: "  Thu gọn",
                    moreStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  // Đánh giá
                  const Divider(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                 
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
