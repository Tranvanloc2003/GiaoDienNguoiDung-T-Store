import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/personalization/controllers/address_controller.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/validators/validation.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          "Thêm địa chỉ mới",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
              key: controller.addressFormKey,
              child: Column(
                children: [
                  const Text(
                      "Thêm địa chỉ giao hàng mới với tên người nhận"),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  TextFormField(
                    controller: controller.hoTen, // Changed from name
                    validator: (value) =>
                        TValidator.validateEmptyText("Họ tên", value),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.user),
                      labelText: "Họ tên",
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  TextFormField(
                    controller: controller.soDienThoai, // Changed from phoneNumber
                    validator: TValidator.validatePhoneNumber,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.mobile),
                        labelText: "Số điện thoại"),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.duong, // Changed from street
                          validator: (value) =>
                              TValidator.validateEmptyText("Đường", value),
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.building_31),
                              labelText: "Đường"),
                        ),
                      ),
                      const SizedBox(
                        width: TSizes.spaceBtwInputFields,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: controller.maZip, // Changed from postalCode
                          validator: (value) => TValidator.validateEmptyText(
                              "Mã bưu điện", value),
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.code),
                              labelText: "Mã bưu điện"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.thanhPho, // Changed from city
                          validator: (value) =>
                              TValidator.validateEmptyText("Thành phố", value),
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.building),
                              labelText: "Thành phố"),
                        ),
                      ),
                      const SizedBox(
                        width: TSizes.spaceBtwInputFields,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: controller.tinh, // Changed from state
                          validator: (value) =>
                              TValidator.validateEmptyText("Tỉnh", value),
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.activity),
                              labelText: "Tỉnh"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwInputFields,
                  ),
                  TextFormField(
                    controller: controller.quocGia, // Changed from country
                    validator: (value) =>
                        TValidator.validateEmptyText("Quốc gia", value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.global), 
                        labelText: "Quốc gia"),
                  ),
                  const SizedBox(
                    height: TSizes.defaultSpace,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => controller.themDiaChiMoi(),
                      child: Text(
                        "Lưu",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .apply(color: Colors.white),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
