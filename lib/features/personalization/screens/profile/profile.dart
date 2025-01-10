import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/images/circular_image.dart';
import 'package:t_store/common/widgets/shimmers/shimmer.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/features/personalization/screens/profile/change_name.dart';
import 'package:t_store/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          "Hồ sơ",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      // Phần thân
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Ảnh đại diện
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.anhDaiDien;
                      final image =
                          networkImage.isNotEmpty ? networkImage : TImages.user;
                      if (controller.imageUploading.value) {
                        return const TShimmerEffect(
                          height: 80.0,
                          width: 80.0,
                          radius: 80.0,
                        );
                      } else {
                        return CircleAvatar(
                          radius: 42.5,
                          backgroundColor: TColors.primary,
                          foregroundColor: TColors.primary,
                          child: TCircularImage(
                            image: image,
                            fit: BoxFit.cover,
                            width: 80.0,
                            height: 80.0,
                            isNetworkImage: networkImage.isNotEmpty,
                          ),
                        );
                      }
                    }),
                    TextButton(
                        onPressed: () => controller.taiLenAnhDaiDien(),
                        child: Text(
                          "Thay đổi ảnh đại diện",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .apply(color: TColors.primary),
                        ))
                  ],
                ),
              ),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Thông tin hồ sơ
              const TSectionHeading(
                title: "Thông tin hồ sơ",
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(
                title: "Họ tên",
                value: controller.user.value.tenDayDu,
                needIcon: true,
                onPressed: () => Get.to(() => const ChangeName()),
              ),
              TProfileMenu(
                title: "Tên người dùng",
                value: controller.user.value.tenNguoiDung,
                onPressed: () {},
              ),

              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Thông tin chi tiết người dùng
              const TSectionHeading(
                title: "Thông tin chi tiết người dùng",
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(
                title: "ID người dùng",
                icon: Iconsax.copy,
                needIcon: true,
                value: controller.user.value.id,
                onPressed: () {},
              ),
              TProfileMenu(
                title: "Email",
                value: controller.user.value.email,
                onPressed: () {},
              ),
              TProfileMenu(
                title: "Số điện thoại",
                value: controller.user.value.soDienThoaiDinhDang,
                onPressed: () {},
              ),
              TProfileMenu(
                title: "Giới tính",
                value: "Nam",
                onPressed: () {},
              ),
              TProfileMenu(
                title: "Ngày sinh",
                value: "12/08/2003",
                onPressed: () {},
              ),

              const Divider(),

              Center(
                child: TextButton(
                  onPressed: () => controller.canhBaoXoaTaiKhoan(),
                  child: Text(
                    "Đóng tài khoản",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: Colors.red),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
