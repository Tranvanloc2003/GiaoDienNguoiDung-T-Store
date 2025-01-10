import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/products/cart/add_remove_button.dart';
import 'package:t_store/common/widgets/products/cart/cart_item.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/features/shop/controllers/product/cart_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
    this.showAddRemoveButton = true,
  });
  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(
      () => ListView.separated(
        padding: const EdgeInsets.only(top: 15.0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (_, __) => const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        itemCount: controller.danhSachGioHang.length,
        itemBuilder: (_, index) {
          return Obx(() {
            final item = controller.danhSachGioHang[index];
            return Column(
              children: [
                // Sản phẩm trong giỏ hàng
                TCartItem(
                  cartItem: item,
                ),
                // Hiển thị nút thêm/xóa nếu được yêu cầu
                if (showAddRemoveButton) ...[
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  // Nút thêm/xóa
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 70.0,
                          ),
                          TProductQuantityWithAddRemoveButton(
                            quantity: item.soLuong,
                            add: () => controller.addOneToCart(item),
                            remove: () => controller.removeOneFromCrt(item),
                          )
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: TProductPriceText(
                              price: (item.gia * item.soLuong)
                                  .toStringAsFixed(1)))
                    ],
                  ),
                ]
              ],
            );
          });
        },
      ),
    );
  }
}
