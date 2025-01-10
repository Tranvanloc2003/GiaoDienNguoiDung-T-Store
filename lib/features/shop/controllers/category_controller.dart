import 'package:get/get.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/data/repositories/category/category_repository.dart';
import 'package:t_store/data/repositories/product/product_repository.dart';
import 'package:t_store/features/shop/models/category_model.dart';
import 'package:t_store/features/shop/models/product_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final _categoryRepositroy = Get.put(CategoryRepository());
  RxList<DanhMucModel> allCategories = <DanhMucModel>[].obs;
  RxList<DanhMucModel> featuredCategories = <DanhMucModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    layDanhSachDanhMuc();
  }

  // Changed from fetchCategories() to layDanhSachDanhMuc()
  Future<void> layDanhSachDanhMuc() async {
    try {
      isLoading.value = true;

      final categories = await _categoryRepositroy.layTatCaDanhMuc();
      allCategories.assignAll(categories);

      featuredCategories.assignAll(allCategories
          .where((category) => category.danhMucNoiBat && category.maDanhMucCha.isEmpty)
          .take(8)
          .toList());
    } catch (e) {
      TLoaders.errorSnackBar(title: "Lỗi!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Changed from getSubCategories() to layDanhMucCon()
  Future<List<DanhMucModel>> layDanhMucCon(String categoryId) async {
    try {
      final subCategories =
          await _categoryRepositroy.layDanhMucCon(categoryId);
      return subCategories;
    } catch (e) {
      TLoaders.errorSnackBar(title: "Lỗi!", message: e.toString());
      return [];
    }
  }

  // Changed from getCategoryProducts() to laySanPhamTheoDanhMuc()
  Future<List<SanPhamModel>> laySanPhamTheoDanhMuc(
      {required String categoryId, int limit = 4}) async {
    try {
      final products = await ProductRepository.instance
          .laySanPhamTheoDanhMuc(categoryId: categoryId, limit: limit);
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: "Lỗi!", message: e.toString());
      return [];
    }
  }
}
