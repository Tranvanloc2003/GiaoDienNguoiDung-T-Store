import 'package:flutter/material.dart';
import 'package:t_store/features/shop/controllers/product/cart_controller.dart';
import 'package:t_store/features/shop/screens/checkout/widgets/pricing_text.dart';
import 'package:t_store/utils/helpers/pricing_calculator.dart';

class TBillingAmountSection extends StatelessWidget {
  const TBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.tongGiaGioHang.value;
    return Column(
      children: [
        TRowPricingText(
          title: "Tạm tính",
          value: "$subTotal\đ",
          valuTextStyle: Theme.of(context).textTheme.bodyMedium,
        ),
        TRowPricingText(
          title: "Phí vận chuyển",
          value:
              "${TPricingCalculator.calculateShippingCost(subTotal, "US")}\đ",
        ),
        TRowPricingText(
          title: "Thuế",
          value: "${TPricingCalculator.calculateTax(subTotal, "US")}\đ",
        ),
        TRowPricingText(
          title: "Tổng cộng",
          value: "${TPricingCalculator.calculateTotalPrice(subTotal, "US")}\đ",
          valuTextStyle: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
