import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/chips/choice_chip.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/controllers/product/variation_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key, required this.product});
  final SanPhamModel product;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());
    return Obx(
      () => Column(
        children: [
          // Hiển thị giá và mô tả của thuộc tính đã chọn
          if (controller.selectedVariation.value.id.isNotEmpty)
            TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
              child: Column(
                children: [
                  // Tiêu đề, giá và trạng thái tồn kho
                  Row(
                    children: [
                      const TSectionHeading(
                        title: "Biến thể",
                        showActionButton: false,
                      ),
                      const SizedBox(
                        width: TSizes.spaceBtwItems,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const TProductTitleText(
                                title: "Giá : ",
                                smallSize: true,
                              ),

                              // Giá gốc
                              if (controller.selectedVariation.value.giaGiam > 0)
                                Text(
                                  "${controller.selectedVariation.value.gia}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .apply(
                                          decoration: TextDecoration.lineThrough),
                                ),
                              const SizedBox(
                                width: TSizes.spaceBtwItems,
                              ),
                              // Giá khuyến mãi
                              TProductPriceText(
                                  price: controller.getVariationPrice())
                            ],
                          ),
                          Row(
                            children: [
                              const TProductTitleText(
                                title: "Kho :   ",
                                smallSize: true,
                              ),
                              Text(controller.variationStockStatus.value,
                                  style: Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  TProductTitleText(
                    title: controller.selectedVariation.value.moTa ?? "",
                    smallSize: true,
                    maxlines: 4,
                  )
                ],
              ),
            ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: product.thuocTinhSanPham!
                  .map(
                    (attribute) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TSectionHeading(
                          title: attribute.tenThuocTinh ?? "",
                          showActionButton: false,
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems / 2,
                        ),
                        Obx(
                          () => Wrap(
                              spacing: 8,
                              children: attribute.danhSachGiaTri!.map((attributeValue) {
                                final isSelected = controller
                                        .selectedAttributes[attribute.tenThuocTinh] ==
                                    attributeValue;
                                final available = controller
                                    .getAttributesAvailabilityInVariations(
                                        product.bienTheSanPham!,
                                        attribute.tenThuocTinh!)
                                    .contains(attributeValue);
                                return TChoiceChip(
                                  text: attributeValue,
                                  selected: isSelected,
                                  onSelected: available
                                      ? (selected) {
                                          if (selected && available) {
                                            controller.onAttributesSelected(
                                                product,
                                                attribute.tenThuocTinh ?? "",
                                                attributeValue);
                                          }
                                        }
                                      : null,
                                );
                              }).toList()),
                        )
                      ],
                    ),
                  )
                  .toList()),
        ],
      ),
    );
  }
}
