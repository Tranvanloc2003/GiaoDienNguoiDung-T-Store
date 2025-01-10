import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/features/shop/controllers/product/variation_controller.dart';
import 'package:t_store/features/shop/models/cart_item_model.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/local_storage/storage_utility.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  RxInt soLuongGioHang = 0.obs;
  RxDouble tongGiaGioHang = 0.0.obs;
  RxInt soLuongSanPhamTrongGio = 0.obs;
  RxList<GioHangSanPhamModel> danhSachGioHang = <GioHangSanPhamModel>[].obs;
  final bienTheController = VariationController.instance;

  CartController() {
    loadCartItems();
  }

  void addToCart(SanPhamModel sanPham) {
    if (soLuongSanPhamTrongGio.value < 1) {
      TLoaders.customToast(message: "Vui lòng chọn số lượng");
      return;
    }

    if (sanPham.loaiSanPham == ProductType.variable.toString() &&
        bienTheController.selectedVariation.value.id.isEmpty) {
      TLoaders.customToast(message: "Vui lòng chọn biến thể");
      return;
    }

    if (sanPham.loaiSanPham == ProductType.variable.toString()) {
      if (bienTheController.selectedVariation.value.tonKho < 1) {
        TLoaders.warningSnackBar(
            title: "Hết hàng!", message: "Biến thể đã chọn đã hết hàng");
        return;
      } else {
        if (sanPham.tonKho < 1) {
          TLoaders.warningSnackBar(
              title: "Hết hàng!", message: "Sản phẩm đã chọn đã hết hàng");
          return;
        }
      }
    }

    final sanPhamDaChon =
        convertToCartItem(sanPham, soLuongSanPhamTrongGio.value);

    int index = danhSachGioHang.indexWhere((item) =>
        item.maSanPham == sanPhamDaChon.maSanPham &&
        item.maBienThe == sanPhamDaChon.maBienThe);

    if (index >= 0) {
      danhSachGioHang[index].soLuong = sanPhamDaChon.soLuong;
    } else {
      danhSachGioHang.add(sanPhamDaChon);
    }
    updateCart();
    TLoaders.customToast(message: "Sản phẩm đã được thêm vào giỏ hàng");
  }

  void addOneToCart(GioHangSanPhamModel item) {
    int index = danhSachGioHang.indexWhere((cartItem) =>
        cartItem.maSanPham == item.maSanPham &&
        cartItem.maBienThe == item.maBienThe);
    if (index >= 0) {
      danhSachGioHang[index].soLuong += 1;
    } else {
      danhSachGioHang.add(item);
    }
    updateCart();
  }

  void removeOneFromCrt(GioHangSanPhamModel item) {
    int index = danhSachGioHang.indexWhere((cartItem) =>
        cartItem.maSanPham == item.maSanPham &&
        cartItem.maBienThe == item.maBienThe);
    if (index >= 0) {
      if (danhSachGioHang[index].soLuong > 1) {
        danhSachGioHang[index].soLuong -= 1;
      } else {
        danhSachGioHang[index].soLuong == 1
            ? removeFromCartDialog(index)
            : danhSachGioHang.removeAt(index);
      }
    }
    updateCart();
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
        textConfirm: "Xóa",
        buttonColor: TColors.primary,
        titlePadding: const EdgeInsets.only(top: 15),
        contentPadding: const EdgeInsets.all(15),
        title: "Xóa sản phẩm",
        middleText: "Bạn có chắc chắn muốn xóa sản phẩm này?",
        onConfirm: () {
          danhSachGioHang.removeAt(index);
          updateCart();
          TLoaders.customToast(message: "Đã xóa sản phẩm khỏi giỏ hàng");
          Get.back();
        },
        onCancel: () => () => Get.back());
  }

  GioHangSanPhamModel convertToCartItem(SanPhamModel sanPham, int soLuong) {
    if (sanPham.loaiSanPham == ProductType.single.toString()) {
      bienTheController.resetSelectedAttributes();
    }
    final bienThe = bienTheController.selectedVariation.value;
    final isVariation = bienThe.id.isNotEmpty;
    final gia = isVariation
        ? bienThe.giaGiam > 0.0
            ? bienThe.giaGiam
            : bienThe.gia
        : sanPham.giaGiam > 0.0
            ? sanPham.giaGiam
            : sanPham.gia;
    return GioHangSanPhamModel(
        maSanPham: sanPham.id,
        tenSanPham: sanPham.tenSanPham,
        gia: gia,
        soLuong: soLuong,
        maBienThe: bienThe.id,
        hinhAnh: isVariation ? bienThe.hinhAnh : sanPham.anhDaiDien,
        tenThuongHieu: sanPham.thuongHieu != null ? sanPham.thuongHieu!.tenThuongHieu : "",
        bienTheDaChon: isVariation ? bienThe.giaTriThuocTinh : null);
  }

  void updateCart() {
    updateCartTotals();
    saveCartItems();
    danhSachGioHang.refresh();
  }

  void updateCartTotals() {
    double tinhTongGia = 0.0;
    int tinhSoLuong = 0;
    for (var item in danhSachGioHang) {
      tinhTongGia += (item.gia) * item.soLuong.toDouble();
      tinhSoLuong += item.soLuong;
    }
    tongGiaGioHang.value = tinhTongGia;
    soLuongGioHang.value = tinhSoLuong;
  }

  void saveCartItems() {
    final danhSachGioHangJson = danhSachGioHang.map((item) => item.toJson()).toList();
    TLocalStorage.instance().writeData("cartItems", danhSachGioHangJson);
  }

  void loadCartItems() {
    final danhSachJson =
        TLocalStorage.instance().readData<List<dynamic>>("cartItems");
    if (danhSachJson != null) {
      danhSachGioHang.assignAll(danhSachJson
          .map((item) => GioHangSanPhamModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = danhSachGioHang
        .where((item) => item.maSanPham == productId)
        .fold(0, (previousValue, element) => previousValue + element.soLuong);
    return foundItem;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = danhSachGioHang.firstWhere(
        (item) =>
            item.maSanPham == productId && item.maBienThe == variationId,
        orElse: () => GioHangSanPhamModel.empty());
    return foundItem.soLuong;
  }

  void clearCart() {
    soLuongSanPhamTrongGio.value = 0;
    danhSachGioHang.clear();
    updateCart();
  }

  void updateAlreadyAddedProductCount(SanPhamModel sanPham) {
    if (sanPham.loaiSanPham == ProductType.single.toString()) {
      soLuongSanPhamTrongGio.value = getProductQuantityInCart(sanPham.id);
    } else {
      final bienTheId = bienTheController.selectedVariation.value.id;
      if (bienTheId.isNotEmpty) {
        soLuongSanPhamTrongGio.value =
            getVariationQuantityInCart(sanPham.id, bienTheId);
      } else {
        soLuongSanPhamTrongGio.value = 0;
      }
    }
  }
}
