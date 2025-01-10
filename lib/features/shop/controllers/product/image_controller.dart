import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  RxString anhSanPhamHienTai = "".obs;

  List<String> getAllProductImages(SanPhamModel sanPham) {
    Set<String> danhSachAnh = {};
    
    anhSanPhamHienTai.value = sanPham.anhDaiDien;

    if (sanPham.loaiSanPham == ProductType.single.toString()) {
      if (sanPham.danhSachAnh != null) {
        danhSachAnh.addAll(sanPham.danhSachAnh!);
      }
    } else {
      if (sanPham.bienTheSanPham != null || sanPham.bienTheSanPham!.isNotEmpty) {
        danhSachAnh.addAll(sanPham.bienTheSanPham!.map((bienThe) => bienThe.hinhAnh));
      }
    }
    return danhSachAnh.toList();
  }

  //ShowImage Popup
  void showEnlargeImage(String image) {
    Get.to(
        fullscreenDialog: true,
        () => Dialog.fullscreen(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: TSizes.defaultSpace * 2,
                        horizontal: TSizes.defaultSpace),
                    child: CachedNetworkImage(imageUrl: image),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 150.0,
                      child: OutlinedButton(
                          onPressed: () => Get.back(),
                          child: Text(
                            "Close",
                            style: Theme.of(Get.context!).textTheme.titleMedium,
                          )),
                    ),
                  )
                ],
              ),
            ));
  }
}
