import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/list_tiles/payment_tile.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/models/payment_method_model.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<ThanhToanModel> selectedPaymentMethod =
      ThanhToanModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value =
        ThanhToanModel(tenPhuongThuc: "Paypal", hinhAnh: TImages.paypal);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(TSizes.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TSectionHeading(
                      title: "Chọn phương thức thanh toán",
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    TPaymentTile(
                        paymentMethod: ThanhToanModel(
                            tenPhuongThuc: "Paypal", hinhAnh: TImages.paypal)),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    TPaymentTile(
                        paymentMethod: ThanhToanModel(
                            tenPhuongThuc: "Google Pay", hinhAnh: TImages.googlePay)),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    TPaymentTile(
                        paymentMethod: ThanhToanModel(
                            tenPhuongThuc: "Apple Pay", hinhAnh: TImages.applePay)),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    TPaymentTile(
                        paymentMethod: ThanhToanModel(
                            tenPhuongThuc: "VISA", hinhAnh: TImages.visa)),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    TPaymentTile(
                        paymentMethod: ThanhToanModel(
                            tenPhuongThuc: "Thẻ MasterCard", hinhAnh: TImages.masterCard)),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    TPaymentTile(
                        paymentMethod: ThanhToanModel(
                            tenPhuongThuc: "Paytm", hinhAnh: TImages.paytm)),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    TPaymentTile(
                        paymentMethod: ThanhToanModel(
                            tenPhuongThuc: "Paystack", hinhAnh: TImages.paystack)),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    TPaymentTile(
                        paymentMethod: ThanhToanModel(
                            tenPhuongThuc: "Thẻ tín dụng", hinhAnh: TImages.creditCard)),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    )
                  ],
                ),
              ),
            ));
  }
}
