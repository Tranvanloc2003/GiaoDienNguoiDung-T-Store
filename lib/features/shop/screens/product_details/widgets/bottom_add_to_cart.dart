import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/icons/circular_icon.dart';
import 'package:t_store/features/shop/controllers/product/cart_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class TBottomAddToCart extends StatelessWidget {
  const TBottomAddToCart({super.key, required this.product});
  final SanPhamModel product;
  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product);
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(
          color: dark ? TColors.darkerGrey : TColors.light,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(TSizes.cardRadiusLg),
            topRight: Radius.circular(TSizes.cardRadiusLg),
          )),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                TCircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: TColors.darkGrey,
                  width: 40.0,
                  height: 40.0,
                  color: TColors.white,
                  onPressed: () => controller.soLuongSanPhamTrongGio.value < 1
                      ? null
                      : controller.soLuongSanPhamTrongGio -= 1,
                ),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                Text(controller.soLuongSanPhamTrongGio.value.toString(),
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                TCircularIcon(
                  icon: Iconsax.add,
                  backgroundColor: TColors.black,
                  width: 40.0,
                  height: 40.0,
                  color: TColors.white,
                  onPressed: () => controller.soLuongSanPhamTrongGio += 1,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: controller.soLuongSanPhamTrongGio.value < 1
                  ? null
                  : () => controller.addToCart(product),
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(TSizes.md),
                  backgroundColor: TColors.black,
                  side: const BorderSide(color: TColors.black)),
              child: Text(
                "Thêm vào giỏ",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
