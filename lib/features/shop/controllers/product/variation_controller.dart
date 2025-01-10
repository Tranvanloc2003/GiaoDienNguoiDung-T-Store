import 'package:get/get.dart';
import 'package:t_store/features/shop/controllers/product/cart_controller.dart';
import 'package:t_store/features/shop/controllers/product/image_controller.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/features/shop/models/product_variation_model.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  // Biến
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = "".obs;
  Rx<BienTheSanPhamModel> selectedVariation =
      BienTheSanPhamModel.empty().obs;

  // Chọn thuộc tính và biến thể
  void onAttributesSelected(
      SanPhamModel product, attributeName, attributeValue) {
    // Thêm thuộc tính vào selectedAttributes khi được chọn
    final selectedAttributes =
        Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    final selectedVariation = product.bienTheSanPham!.firstWhere(
        (variation) => isSameAttributeValues(
            variation.giaTriThuocTinh, selectedAttributes),
        orElse: () => BienTheSanPhamModel.empty());

    // Hiển thị hình ảnh biến thể đã chọn làm hình ảnh chính
    if (selectedVariation.hinhAnh.isNotEmpty) {
      ImageController.instance.anhSanPhamHienTai.value =
          selectedVariation.hinhAnh;
    }
    // Hiển thị số lượng biến thể đã chọn trong giỏ hàng
    if (selectedVariation.id.isNotEmpty) {
      final cartController = CartController.instance;
      cartController.soLuongSanPhamTrongGio.value = cartController
          .getVariationQuantityInCart(product.id, selectedVariation.id);
    }
    getProductVariationStockStatus();
    this.selectedVariation.value = selectedVariation;
  }

  // Kiểm tra nếu thuộc tính đã chọn khớp với thuộc tính biến thể
  bool isSameAttributeValues(Map<String, dynamic> variationAttributes,
      Map<String, dynamic> selectedAttributes) {
    if (variationAttributes.length != selectedAttributes.length) return false;

    // Nếu bất kỳ thuộc tính nào khác nhau thì trả về false, ví dụ: [Xanh,Lớn][Xanh,Nhỏ]
    for (final key in variationAttributes.keys) {
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }
    return true;
  }

  String getVariationPrice() {
    return (selectedVariation.value.giaGiam > 0
            ? selectedVariation.value.giaGiam
            : selectedVariation.value.gia)
        .toString();
  }

  // Kiểm tra tình trạng tồn kho của thuộc tính
  Set<String?> getAttributesAvailabilityInVariations(
    List<BienTheSanPhamModel> variations,
    String attributeName,
  ) {
    // Kiểm tra các biến thể để xem thuộc tính nào còn hàng và số lượng > 0
    final availableVaraiationAttributeValues = variations
        .where((variation) =>
            variation.giaTriThuocTinh[attributeName] != null &&
            variation.giaTriThuocTinh[attributeName]!.isNotEmpty &&
            variation.tonKho > 0)
        .map((variation) => variation.giaTriThuocTinh[attributeName])
        .toSet();
    return availableVaraiationAttributeValues;
  }

  // Kiểm tra tình trạng tồn kho của thuộc tính
  void getProductVariationStockStatus() {
    variationStockStatus.value =
        selectedVariation.value.tonKho > 0 ? "Còn hàng" : "Hết hàng";
  }

  // Đặt lại thuộc tính đã chọn khi chuyển sản phẩm
  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = "";
    selectedVariation.value = BienTheSanPhamModel.empty();
  }
}
