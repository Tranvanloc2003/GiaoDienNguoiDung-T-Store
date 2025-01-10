import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/data/repositories/product/product_repository.dart';
import 'package:t_store/features/shop/models/product_model.dart';

class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedSortOption = "Tên".obs;
  final RxList<SanPhamModel> products = <SanPhamModel>[].obs;

  void sapXepSanPham(String sortOption) {
    selectedSortOption.value = sortOption;
    switch (sortOption) {
      case "Tên":
        products.sort((a, b) => a.tenSanPham.compareTo(b.tenSanPham));
        break;
      case "Giá cao":
        products.sort((a, b) => b.gia.compareTo(a.gia));
        break;
      case "Giá thấp":
        products.sort((a, b) => a.gia.compareTo(b.gia));
        break;
      case "Mới nhất":
        products.sort((a, b) => a.ngayTao!.compareTo(b.ngayTao!));
        break;
      case "Khuyến mãi":
        products.sort((a, b) {
          if (b.giaGiam > 0) {
            return b.giaGiam.compareTo(a.giaGiam);
          } else if (a.giaGiam > 0) {
            return -1;
          } else {
            return 1;
          }
        });
        break;
      default:
        products.sort((a, b) => a.tenSanPham.compareTo(b.tenSanPham));
    }
  }

  void ganDanhSachSanPham(List<SanPhamModel> products) {
    this.products.assignAll(products);
    sapXepSanPham("Tên");
  }

  // Changed from fetchProductsByQuery() to laySanPhamTheoQuery()
  Future<List<SanPhamModel>> laySanPhamTheoQuery(Query? query) async {
    try {
      if (query == null) return [];
      final products = await repository.layDanhSachSanPhamTheoQuery(query);
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: "Lỗi!", message: e.toString());
      return [];
    }
  }
}
