import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  // Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  // Changed from sendPasswordResetEmail() to guiEmailKhoiPhucMatKhau()
  Future<void> guiEmailKhoiPhucMatKhau() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "Đang đăng nhập...", TImages.doccerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'Không có kết nối Internet',
            message: "Bạn chưa kết nối mạng. Vui lòng kết nối để tiếp tục.");
        return;
      }

      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .guiEmailKhoiPhucMatKhau(email.text.trim());

      TFullScreenLoader.stopLoading();

      TLoaders.succcesSnackBar(
          title: "Đã gửi email",
          message: "Đã gửi liên kết đặt lại mật khẩu qua email".tr);

      Get.to(() => ResetPassword(email: email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Ôi không!", message: e.toString());
    }
  }

  // Changed from resendPasswordResetEmail() to guiLaiEmailKhoiPhucMatKhau()
  Future<void> guiLaiEmailKhoiPhucMatKhau(String email) async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "Đang đăng nhập...", TImages.doccerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'Không có kết nối Internet',
            message: "Bạn chưa kết nối mạng. Vui lòng kết nối để tiếp tục.");
        return;
      }

      await AuthenticationRepository.instance.guiEmailKhoiPhucMatKhau(email);

      TFullScreenLoader.stopLoading();

      TLoaders.succcesSnackBar(
          title: "Đã gửi email",
          message: "Đã gửi liên kết đặt lại mật khẩu qua email".tr);
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Ôi không!", message: e.toString());
    }
  }
}
