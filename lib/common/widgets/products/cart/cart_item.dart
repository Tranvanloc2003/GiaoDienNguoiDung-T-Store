import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/images/rounded_image.dart';
import 'package:t_store/common/widgets/texts/brand_title_text_with_verifiacion_icon.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/features/shop/models/cart_item_model.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
    required this.cartItem,
  });
  final GioHangSanPhamModel cartItem;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //Image
        TRoundedImage(
          isNetworkImage: true,
          imageUrl: cartItem.hinhAnh ?? "",
          height: 60.0,
          width: 60.0,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: THelperFunctions.isDarkMode(context)
              ? TColors.darkerGrey
              : TColors.light,
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),

        //Tiêu đề, Giá và Kích thước
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBrandTitleTextWithVerificationIcon(
                  title: cartItem.tenThuongHieu ?? ""),
              Flexible(child: TProductTitleText(title: cartItem.tenSanPham)),
                //Thuộc tính
              if (cartItem.bienTheDaChon != null)
                Text.rich(TextSpan(
                    children: (cartItem.bienTheDaChon ?? {})
                        .entries
                        .map((e) => TextSpan(children: [
                              TextSpan(
                                  text: "${e.key}  ",
                                  style: Theme.of(context).textTheme.bodySmall),
                              TextSpan(
                                  text: "${e.value}  ",
                                  style: Theme.of(context).textTheme.bodyLarge)
                            ]))
                        .toList()))
            ],
          ),
        )
      ],
    );
  }
}
