import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/data/repositories/user/user_repository.dart';
import 'package:t_store/features/personalization/controllers/user_controller.dart';
import 'package:t_store/features/personalization/screens/profile/profile.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  // Các biến
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    initializeNames();
  }

  Future<void> initializeNames() async {
    firstName.text = userController.user.value.hoTen;
    lastName.text = userController.user.value.ho;
  }

  Future<void> updateUserName() async {
    try {
      // Đang tải
      TFullScreenLoader.openLoadingDialog(
          "Đang cập nhật thông tin của bạn...", TImages.doccerAnimation);

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
      if (!updateUserNameFormKey.currentState!.validate()) {
        // Tắt màn hình tải
        TFullScreenLoader.stopLoading();
        return;
      }
      Map<String, dynamic> name = {
        "FirstName": firstName.text.trim(),
        "LastName": lastName.text.trim()
      };
      // Cập nhật tên trong firebase
      await userRepository.capNhatMotTruong(name);

      // Cập nhật tên trong controller để phản ánh trong trạng thái
      userController.user.value.hoTen = firstName.text.trim();
      userController.user.value.ho = lastName.text.trim();
      // Tắt màn hình tải
      TFullScreenLoader.stopLoading();

      // Hiển thị thông báo thành công
      TLoaders.succcesSnackBar(
          title: "Chúc mừng", message: "Tên của bạn đã được cập nhật");

      // Chuyển đến màn hình xác thực email
      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(
          title: "Dữ liệu chưa được lưu",
          message:
              "Đã xảy ra lỗi khi lưu thông tin của bạn. Bạn có thể lưu lại thông tin trong hồ sơ của mình");
    }
  }
}
