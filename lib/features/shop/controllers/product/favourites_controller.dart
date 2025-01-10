import 'dart:convert';

import 'package:get/get.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/data/repositories/product/product_repository.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/local_storage/storage_utility.dart';

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();

  final favourites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    khoiTaoYeuThich();
  }

  void khoiTaoYeuThich() {
    final json = TLocalStorage.instance().readData("favourites");
    if (json != null) {
      final storedFavourites = jsonDecode(json) as Map<String, dynamic>;
      favourites.assignAll(
          storedFavourites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool kiemTraYeuThich(String productId) {
    return favourites[productId] ?? false;
  }

  void chuyenDoiSanPhamYeuThich(String productId) {
    if (!favourites.containsKey(productId)) {
      favourites[productId] = true;
      luuYeuThichVaoBoNho();
      TLoaders.customToast(message: "Đã thêm sản phẩm vào danh sách yêu thích");
    } else {
      TLocalStorage.instance().removeData(productId);
      favourites.remove(productId);
      luuYeuThichVaoBoNho();
      favourites.refresh();
      TLoaders.customToast(
          message: "Đã xóa sản phẩm khỏi danh sách yêu thích");
    }
  }

  void luuYeuThichVaoBoNho() {
    final encodedFavourites = json.encode(favourites);
    TLocalStorage.instance().writeData("favourites", encodedFavourites);
  }

  Future<List<SanPhamModel>> laySanPhamYeuThich() async {
    return await ProductRepository.instance
        .laySanPhamYeuThich(favourites.keys.toList());
  }
}
