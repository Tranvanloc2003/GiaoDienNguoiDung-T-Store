import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:t_store/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:t_store/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/features/personalization/screens/address/address.dart';
import 'package:t_store/features/personalization/screens/locations/store_location.dart';
import 'package:t_store/features/personalization/screens/profile/profile.dart';
import 'package:t_store/features/shop/controllers/settings_controller.dart';
import 'package:t_store/features/shop/screens/cart/cart.dart';
import 'package:t_store/features/shop/screens/load_data/load_data.dart';
import 'package:t_store/features/shop/screens/order/order.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          // Phần đầu
          TPrimaryHeaderContainer(
            child: Column(
              children: [
                // Thanh ứng dụng
                TAppBar(
                  title: Text(
                    "Tài khoản",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: TColors.white),
                  ),
                ),
                // Thẻ hồ sơ người dùng
                TUserProfileTile(
                  onPressed: () => Get.to(() => const ProfileScreen()),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems * 1.5,
                )
              ],
            ),
          ),
          // Phần thân
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                // Cài đặt tài khoản
                const TSectionHeading(
                  title: "Cài đặt tài khoản",
                  showActionButton: false,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),

                TSettingMenuTile(
                  onTap: () => Get.to(() => const UserAddressScreen()),
                  icon: Iconsax.safe_home,
                  title: "Địa chỉ của tôi",
                  subtitle: "Thiết lập địa chỉ giao hàng",
                ),
                TSettingMenuTile(
                  onTap: () => Get.to(() => const CartScreen()),
                  icon: Iconsax.shopping_cart,
                  title: "Giỏ hàng",
                  subtitle: "Thêm, xóa sản phẩm và chuyển đến thanh toán",
                ),
                TSettingMenuTile(
                  onTap: () => Get.to(() => const OrderScreen()),
                  icon: Iconsax.bag_tick,
                  title: "Đơn hàng của tôi",
                  subtitle: "Đơn hàng đang xử lý và đã hoàn thành",
                ),
                const TSettingMenuTile(
                  icon: Iconsax.bank,
                  title: "Tài khoản của tôi",
                  subtitle: "Rút tiền về tài khoản ngân hàng đã đăng ký",
                ),
                TSettingMenuTile(
                  onTap: () => Get.to(() => const StoreLocationsScreen()),
                  icon: Iconsax.location,
                  title: "Địa chỉ các đại lý",
                  subtitle: "Danh sách các đại lý gần bạn",
                  
                ),
                const TSettingMenuTile(
                  icon: Iconsax.notification,
                  title: "Thông báo",
                  subtitle: "Thiết lập các loại thông báo",
                ),
                const TSettingMenuTile(
                  icon: Iconsax.security_card,
                  title: "Quyền riêng tư",
                  subtitle: "Quản lý dữ liệu và tài khoản liên kết",
                ),

                const SizedBox(height: TSizes.spaceBtwSections),
                
                // Cài đặt ứng dụng
                const TSectionHeading(
                  title: "Cài đặt ứng dụng",
                  showActionButton: false,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                
                // TSettingMenuTile(
                //   onTap: () => Get.to(() => const LoadDataScreen()),
                //   icon: Iconsax.document_upload,
                //   title: "Tải dữ liệu",
                //   subtitle: "Tải dữ liệu lên Firebase Cloud",
                // ),
                TSettingMenuTile(
                  icon: Iconsax.location,
                  title: "Vị trí",
                  subtitle: "Đề xuất dựa trên vị trí",
                  trailing: Obx(
                    () => Switch(
                      value: controller.geoLocationSwitch.value,
                      onChanged: (value) =>
                          controller.geoLocationSwitch.value = value,
                    ),
                  ),
                ),
                TSettingMenuTile(
                  icon: Iconsax.security_user,
                  title: "Chế độ an toàn",
                  subtitle: "Kết quả tìm kiếm phù hợp mọi lứa tuổi",
                  trailing: Obx(
                    () => Switch(
                      value: controller.safeModeSwitch.value,
                      onChanged: (value) =>
                          controller.safeModeSwitch.value = value,
                    ),
                  ),
                ),
                TSettingMenuTile(
                  icon: Iconsax.image,
                  title: "Chất lượng hình ảnh HD",
                  subtitle: "Thiết lập chất lượng hình ảnh hiển thị",
                  trailing: Obx(
                    () => Switch(
                      value: controller.hdImgQualitySwitch.value,
                      onChanged: (value) =>
                          controller.hdImgQualitySwitch.value = value,
                    ),
                  ),
                ),

                // Nút đăng xuất
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () =>
                          AuthenticationRepository.instance.dangXuat(),
                      child: Text("Đăng xuất",
                          style: Theme.of(context).textTheme.titleMedium)),
                ),
                const SizedBox(height: TSizes.spaceBtwSections * 2),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
