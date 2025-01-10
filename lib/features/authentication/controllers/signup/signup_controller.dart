import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:t_store/common/widgets/loaders/loaders.dart";
import "package:t_store/data/repositories/authentication/authentication_repository.dart";
import "package:t_store/data/repositories/user/user_repository.dart";
import "package:t_store/features/authentication/models/user_model.dart";
import "package:t_store/features/authentication/screens/signup/verify_email.dart";
import "package:t_store/utils/constants/image_strings.dart";
import "package:t_store/utils/helpers/network_manager.dart";
import "package:t_store/utils/popups/full_screen_loader.dart";

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  // Biến
  final hidePassword = true.obs;
  final privacyPolicy = false.obs;

  final email = TextEditingController();
  final lastName = TextEditingController();
  final firstName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  // Đăng ký
  void dangKyTaiKhoan() async {
    try {
      // Hiển thị loading
      TFullScreenLoader.openLoadingDialog(
          "Đang xử lý thông tin của bạn...", TImages.doccerAnimation);

      // Kiểm tra kết nối internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Đóng loading
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'Không có kết nối Internet',
            message: 
                "Bạn chưa kết nối mạng. Vui lòng kết nối để tiếp tục.");
        return;
      }

      // Xác thực form
      if (!signUpFormKey.currentState!.validate()) {
        // Đóng loading
        TFullScreenLoader.stopLoading();
        return;
      }

      // Kiểm tra chấp nhận điều khoản
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
            title: "Chấp nhận điều khoản",
            message: 
                "Để tạo tài khoản, bạn phải đọc và chấp nhận Chính sách quyền riêng tư & Điều khoản sử dụng");
      }

      // Đăng ký người dùng trong Firebase Authentication & lưu dữ liệu người dùng vào Firebase
      final userCredential = await AuthenticationRepository.instance
          .dangKyEmailMatKhau(
              email.text.trim(), password.text.trim());

      // Lưu thông tin người dùng đã xác thực vào firebase firestore
      final newUser = NguoiDungModel(
          id: userCredential.user!.uid,
          hoTen: firstName.text.trim(),
          ho: lastName.text.trim(),
          tenNguoiDung: userName.text.trim(),
          email: email.text.trim(),
          soDienThoai: phoneNumber.text.trim(),
          anhDaiDien: "");
      final userRepository = Get.put(UserRepository());
      await userRepository.luuThongTinNguoiDung(newUser);

      // Đóng loading
      TFullScreenLoader.stopLoading();

      // Hiển thị thông báo thành công
      TLoaders.succcesSnackBar(
          title: "Chúc mừng",
          message: "Tài khoản của bạn đã được tạo. Xác thực email để tiếp tục");

      // Chuyển đến màn hình xác thực email
      Get.to(() => VerifyEmailScreen(
            email: email.text.trim(),
          ));
    } catch (e) {
      // Đóng loading
      TFullScreenLoader.stopLoading();
      // Hiển thị thông báo lỗi
      TLoaders.errorSnackBar(title: "Ôi không!", message: e.toString());
    }
  }
}
