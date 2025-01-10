import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/common/widgets/success_screen/success_screen.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/data/repositories/order/order_repository.dart';
import 'package:t_store/features/personalization/controllers/address_controller.dart';
import 'package:t_store/features/shop/controllers/product/cart_controller.dart';
import 'package:t_store/features/shop/controllers/product/checkout_controller.dart';
import 'package:t_store/features/shop/models/order_model.dart';
import 'package:t_store/navigation_menu.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  Future<List<DonHangModel>> layDonHangNguoiDung() async {
    try {
      final userOrders = await orderRepository.layDonHangNguoiDung();
      return userOrders;
    } catch (e) {
      TLoaders.warningSnackBar(title: "Lỗi!", message: e.toString());
      return [];
    }
  }

  void xuLyDonHang(double totalAmount) async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "Đang xử lý đơn hàng", TImages.pencilAnimation);

      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) return;

      final order = DonHangModel(
        id: UniqueKey().toString(),
        maNguoiDung: userId,
        trangThai: OrderStatus.dangXuLi,
        tongTien: totalAmount,
        ngayDatHang: DateTime.now(),
        phuongThucThanhToan: checkoutController.selectedPaymentMethod.value.tenPhuongThuc,
        diaChi: addressController.selectedAddress.value,
        ngayGiaoHang: DateTime.now(),
        danhSachSanPham: cartController.danhSachGioHang.toList(),
      );

      await orderRepository.luuDonHang(order, userId);

      cartController.clearCart();
      TFullScreenLoader.stopLoading();
      Get.off(() => SuccessScreen(
            isLottie: true,
            image: TImages.orderCompletedAnimation,
            title: "Thanh toán thành công!",
            subTitle: "Đơn hàng của bạn sẽ được giao sớm",
            onPressed: () => Get.offAll(() => const NavigationMenu()),
          ));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Lỗi!", message: e.toString());
    }
  }
}
