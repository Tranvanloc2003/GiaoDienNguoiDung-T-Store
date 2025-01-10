import 'package:get/get.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/data/repositories/product/product_repository.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/constants/enums.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final _khoSanPham = Get.put(ProductRepository());
  RxList<SanPhamModel> danhSachSanPham = <SanPhamModel>[].obs;
  final dangTai = false.obs;
  RxString truyXuatTimKiem = ''.obs;
  @override
  void onInit() {
    super.onInit();
    laySanPhamNoiBat();
  }

  Future<void> laySanPhamNoiBat() async {
    try {
      dangTai.value = true;
      final products = await _khoSanPham.laySanPhamNoiBat(limit: -1);
      danhSachSanPham.assignAll(products);
    } catch (e) {
      TLoaders.errorSnackBar(title: "Lỗi!", message: e.toString());
    } finally {
      dangTai.value = false;
    }
  }

  Future<List<SanPhamModel>> layTatCaSanPhamNoiBat() async {
    try {
      final products = await _khoSanPham.laySanPhamNoiBat();
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: "Lỗi!", message: e.toString());
      return [];
    }
  }

  String layGiaSanPham(SanPhamModel sanPham) {
    double giaThapNhat = double.infinity;
    double giaCaoNhat = 0.0;

    if (sanPham.loaiSanPham == ProductType.single.toString()) {
      return (sanPham.giaGiam > 0 ? sanPham.giaGiam : sanPham.gia).toString();
    } else {
      for (var bienThe in sanPham.bienTheSanPham!) {
        double giaHienTai = bienThe.giaGiam > 0.0 ? bienThe.giaGiam : bienThe.gia;
        if (giaHienTai < giaThapNhat) giaThapNhat = giaHienTai;
        if (giaHienTai > giaCaoNhat) giaCaoNhat = giaHienTai;
      }
      return giaThapNhat.isEqual(giaCaoNhat) 
          ? giaCaoNhat.toString() 
          : "$giaThapNhat - $giaCaoNhat\đ";
    }
  }

  String? tinhPhanTramGiamGia(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  String layTrangThaiKho(int stock) {
    return stock > 0 ? "Còn hàng" : "Hết hàng";
  }
  Future<List<SanPhamModel>> timKiemSanPham(String query) async {
  try {
    // Return all products if query is empty
    if (query.isEmpty) return danhSachSanPham;
    
    // Filter featuredProducts based on search query
    return danhSachSanPham.where((product) {
      final titleMatch = product.tenSanPham.toLowerCase().contains(query.toLowerCase());
      final brandMatch = product.thuongHieu?.tenThuongHieu.toLowerCase().contains(query.toLowerCase()) ?? false;
      return titleMatch || brandMatch;
    }).toList();
    
  } catch (e) {
    TLoaders.errorSnackBar(title: "Search Error", message: e.toString());
    return [];
  }
}
}
