import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/data/repositories/user/user_repository.dart';
import 'package:t_store/features/authentication/models/user_model.dart';
import 'package:t_store/features/authentication/screens/login/login.dart';
import 'package:t_store/features/personalization/screens/profile/re_authenticate_user_login_form.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  // Các biến
  final profileLoading = false.obs;
  Rx<NguoiDungModel> user = NguoiDungModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  final hidePassword = true.obs;
  final verifEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  final imageUploading = false.obs;

  @override
  void onInit() {
    super.onInit();
    layThongTinNguoiDung();
  }

  Future<void> layThongTinNguoiDung() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.layThongTinNguoiDung();
      this.user(user);
    } catch (e) {
      user(NguoiDungModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Lưu thông tin người dùng cho bất kỳ nhà cung cấp đăng ký nào
  Future<void> luuThongTinNguoiDung(UserCredential? userCredentials) async {
    try {
      // Đầu tiên cập nhật Rx User và sau đó kiểm tra xem dữ liệu người dùng đã được lưu chưa. Nếu chưa thì lưu dữ liệu mới
      await layThongTinNguoiDung();
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          // Tách tên thành họ và tên
          final nameParts =
              NguoiDungModel.nameParts(userCredentials.user!.displayName ?? "");
          final userName = NguoiDungModel.generateUserName(
              userCredentials.user!.displayName ?? "");

          // Ánh xạ dữ liệu
          final user = NguoiDungModel(
              id: userCredentials.user!.uid,
              hoTen: nameParts[0],
              ho: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : "",
              tenNguoiDung: userName,
              email: userCredentials.user!.email ?? "",
              soDienThoai: userCredentials.user!.phoneNumber ?? "",
              anhDaiDien: userCredentials.user!.photoURL ?? "");
          // Lưu dữ liệu người dùng
          await userRepository.luuThongTinNguoiDung(user);
        }
      }
    } catch (e) {
      TLoaders.warningSnackBar(
          title: "Dữ liệu chưa được lưu",
          message:
              "Đã xảy ra lỗi khi lưu thông tin của bạn. Bạn có thể lưu lại thông tin trong hồ sơ của mình");
    }
  }

  // Cảnh báo xóa tài khoản
    void canhBaoXoaTaiKhoan() {
    Get.defaultDialog(
        titlePadding: const EdgeInsets.only(top: TSizes.defaultSpace),
        contentPadding: const EdgeInsets.all(TSizes.md),
        title: "Xóa tài khoản",
        middleText:
            "Bạn có chắc chắn muốn xóa vĩnh viễn tài khoản của mình không? Hành động này không thể hoàn tác và tất cả dữ liệu của bạn sẽ bị xóa vĩnh viễn",
        confirm: ElevatedButton(
            onPressed: () async => xoaTaiKhoanNguoiDung(),
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.5, vertical: 12.5),
                backgroundColor: Colors.red,
                side: const BorderSide(color: Colors.red)),
            child: Text(
              "Xóa",
              style: Theme.of(Get.overlayContext!)
                  .textTheme
                  .titleMedium!
                  .apply(color: Colors.white),
            )),
        cancel: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.5, vertical: 12.5),
            ),
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: Text(
              "Hủy",
              style: Theme.of(Get.overlayContext!).textTheme.titleMedium!,
            )));
  }

  // Xóa tài khoản người dùng
  void xoaTaiKhoanNguoiDung() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "Đang xử lý", TImages.doccerAnimation);

      // Đầu tiên xác thực lại người dùng
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        // Xác thực lại email
        // Người dùng đăng nhập bằng Google
        if (provider == "google.com") {
          await auth.dangNhapGoogle();
          await auth.xoaTaiKhoan();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        // Người dùng đăng nhập bằng email và mật khẩu
        } else if (provider == "password") {
          TFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: "Ôi không!", message: e.toString());
    }
  }

  // Xác thực lại trước khi xóa
  Future<void> xacThucLaiEmailMatKhau() async {
    try {
      // Đang tải
      TFullScreenLoader.openLoadingDialog(
          "Đang xử lý...", TImages.doccerAnimation);

      // Kiểm tra kết nối Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // Tắt màn hình tải
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'Không có kết nối Internet',
            message:
                "Bạn chưa kết nối mạng. Vui lòng kết nối để tiếp tục.");
        return;
      }

      // Xác thực biểu mẫu
      if (!reAuthFormKey.currentState!.validate()) {
        // Tắt màn hình tải
        TFullScreenLoader.stopLoading();
        return;
      }

      // Đăng ký người dùng trong Firebase Authentication & lưu dữ liệu người dùng trong Firebase
      await AuthenticationRepository.instance
          .xacThucLaiEmailMatKhau(
              verifEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.xoaTaiKhoan();

      // Tắt màn hình tải
      TFullScreenLoader.stopLoading();

      // Chuyển hướng
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      // Tắt màn hình tải
      TFullScreenLoader.stopLoading();
      // Hiển thị thông báo lỗi
      TLoaders.errorSnackBar(title: "Ôi không!", message: e.toString());
    }
  }

  // Tải lên ảnh đại diện
    taiLenAnhDaiDien() async {
    try {
      imageUploading.value = true;
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        // Tải ảnh lên
        final imageUrl =
            await userRepository.taiLenHinhAnh("Users/Images/Profile/", image);

        // Cập nhật thông tin ảnh người dùng
        Map<String, dynamic> json = {"ProfilePicture": imageUrl};
        await userRepository.capNhatMotTruong(json);

        user.value.anhDaiDien = imageUrl;
        user.refresh();

        TLoaders.succcesSnackBar(
            title: "Chúc mừng",
            message: "Ảnh đại diện của bạn đã được cập nhật");
      }
    } catch (e) {
      TLoaders.errorSnackBar(
          title: "Ôi không!", message: "Đã xảy ra lỗi: $e");
    } finally {
      imageUploading.value = false;
    }
  }
}
