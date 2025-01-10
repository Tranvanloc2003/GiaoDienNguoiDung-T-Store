import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/images/circular_image.dart';
import 'package:t_store/common/widgets/texts/brand_title_text_with_verifiacion_icon.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/features/shop/controllers/product/product_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key, required this.product});
  final SanPhamModel product;
  
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage =
        controller.tinhPhanTramGiamGia(product.gia, product.giaGiam);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Giá và giá khuyến mãi
        Row(
          children: [
            // Nhãn giảm giá
            TRoundedContainer(
              radius: TSizes.sm,
              backgroundColor: TColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.xs),
              child: Text(
                "$salePercentage%",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.black),
              ),
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            // Giá
            if (product.loaiSanPham == ProductType.single.toString() &&
                product.giaGiam > 0)
              Text(
                "${product.gia}\đ",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(decoration: TextDecoration.lineThrough),
              ),
            if (product.loaiSanPham == ProductType.single.toString() &&
                product.giaGiam > 0)
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
            TProductPriceText(
              price: controller.layGiaSanPham(product),
              isLarge: true,
            )
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),

        // Tiêu đề
        TProductTitleText(title: product.tenSanPham),
        const SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),
        // Trạng thái tồn kho
        Row(
          children: [
            const TProductTitleText(title: "Trạng thái"),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(controller.layTrangThaiKho(product.tonKho),
                style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        // Thương hiệu
        const SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),
        Row(
          children: [
            TCircularImage(
              image: (product.thuongHieu != null) ? product.thuongHieu!.hinhAnh : "",
              width: 40,
              height: 40,
              overlayColor: dark ? TColors.white : TColors.black,
            ),
            TBrandTitleTextWithVerificationIcon(
              title: (product.thuongHieu != null) ? product.thuongHieu!.tenThuongHieu : "",
              brandTextSize: TextSizes.large,
            ),
          ],
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),
      ],
    );
  }
}
