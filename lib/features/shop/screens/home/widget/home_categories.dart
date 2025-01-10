import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/image_text_widdgets/vertical_image_text.dart';
import 'package:t_store/common/widgets/shimmers/category_shimmer.dart';
import 'package:t_store/features/shop/controllers/category_controller.dart';
import 'package:t_store/features/shop/screens/sub_category/sub_categories.dart';
import 'package:t_store/utils/constants/sizes.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Obx(() {
      if (categoryController.isLoading.value) {
        return const TCategoryShimmer();
      }
      if (categoryController.featuredCategories.isEmpty) {
        return Center(
          child: Text(
            "Không tìm thấy dữ liệu",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: Colors.white),
          ),
        );
      }
      return SizedBox(
        height: 120.0,
        child: ListView.builder(
            itemCount: categoryController.featuredCategories.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: TSizes.defaultSpace),
            itemBuilder: (_, index) {
              final category = categoryController.featuredCategories[index];
              return TVerticalImageText(
                image: category.hinhAnh,
                title: category.tenDanhMuc,
                onTap: () => Get.to(() => SubCategoriesScreen(
                      category: category,
                    )),
              );
            }),
      );
    });
  }
}
