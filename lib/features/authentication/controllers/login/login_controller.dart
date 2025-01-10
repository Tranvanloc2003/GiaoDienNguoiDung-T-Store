import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    super.onInit();
    email.text = localStorage.read("REMEMBER_ME_EMAIL") ?? "";
    password.text = localStorage.read("REMEMBER_ME_PASSWORD") ?? "";
  }

  // Changed from emailAndPasswordSignin() to dangNhapEmailMatKhau()
  Future<void> dangNhapEmailMatKhau() async {
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

      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      if (rememberMe.value) {
        localStorage.write("REMEMBER_ME_EMAIL", email.text.trim());
        localStorage.write("REMEMBER_ME_PASSWORD", password.text.trim());
      }

      await AuthenticationRepository.instance
          .dangNhapEmailMatKhau(email.text.trim(), password.text.trim());

      TFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Ôi không!", message: e.toString());
    }
  }

  // Changed from googleSignIn() to dangNhapGoogle()
  Future<void> dangNhapGoogle() async {
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

      final userCredentials =
          await AuthenticationRepository.instance.dangNhapGoogle();

      await userController.luuThongTinNguoiDung(userCredentials);

      TFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: "Ôi không!", message: e.toString());
    }
  }
}
