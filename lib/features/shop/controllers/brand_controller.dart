import 'package:get/get.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/data/repositories/brand/brand_repository.dart';
import 'package:t_store/data/repositories/product/product_repository.dart';
import 'package:t_store/features/shop/models/brand_model.dart';
import 'package:t_store/features/shop/models/product_model.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  // Variables
  RxBool isLoading = true.obs;
  final RxList<ThuongHieuModel> allBrands = <ThuongHieuModel>[].obs;
  final RxList<ThuongHieuModel> featuredBrands = <ThuongHieuModel>[].obs;
  final brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    layThuongHieuNoiBat();
    super.onInit();
  }

  // Changed from getFeaturedBrands() to layThuongHieuNoiBat()
  Future<void> layThuongHieuNoiBat() async {
    try {
      isLoading.value = true;

      final brands = await brandRepository.layTatCaThuongHieu();
      allBrands.assignAll(brands);
      featuredBrands.assignAll(
          allBrands.where((brand) => brand.thuongHieuNoiBat ?? false).take(4));
    } catch (e) {
      TLoaders.errorSnackBar(title: "Lỗi!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Changed from getBrandProducts() to laySanPhamTheoThuongHieu()
  Future<List<SanPhamModel>> laySanPhamTheoThuongHieu(
      {required String brandId, int limit = -1}) async {
    try {
      final products = await ProductRepository.instance
          .laySanPhamTheoThuongHieu(brandId: brandId, limit: limit);
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: "Lỗi!", message: e.toString());
      return [];
    }
  }

  // Changed from getBrandForCategory() to layThuongHieuTheoDanhMuc()
  Future<List<ThuongHieuModel>> layThuongHieuTheoDanhMuc(String categoryId) async {
    try {
      final brands = await brandRepository.layThuongHieuTheoDanhMuc(categoryId);
      return brands;
    } catch (e) {
      TLoaders.errorSnackBar(title: "Lỗi!", message: e.toString());
      return [];
    }
  }
}
