import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/common/widgets/success_screen/success_screen.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/text_strings.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    guiEmailXacThuc();
    datThoiGianTuChuyenHuong();
    super.onInit();
  }

  // Changed from sendEmailVerification() to guiEmailXacThuc()
  guiEmailXacThuc() async {
    try {
      await AuthenticationRepository.instance.guiXacThucEmail();
      TLoaders.succcesSnackBar(
          title: "Đã gửi email",
          message: "Vui lòng kiểm tra hộp thư đến và xác thực email của bạn.");
    } catch (e) {
      TLoaders.errorSnackBar(title: "Ôi không!", message: e.toString());
    }
  }

  // Changed from setTimerForAutoRedirect() to datThoiGianTuChuyenHuong()
  datThoiGianTuChuyenHuong() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(SuccessScreen(
          isLottie: true,
          image: TImages.successfullyRegisterAnimation,
          title: TTexts.yourAccountCreatedTitle,
          subTitle: TTexts.yourAccountCreatedSubTitle,
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        ));
      }
    });
  }

  // Changed from checkEmailVerificationStatus() to kiemTraTrangThaiXacThucEmail()
  kiemTraTrangThaiXacThucEmail() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(SuccessScreen(
        isLottie: true,
        image: TImages.successfullyRegisterAnimation,
        title: TTexts.yourAccountCreatedTitle,
        subTitle: TTexts.yourAccountCreatedSubTitle,
        onPressed: () => AuthenticationRepository.instance.screenRedirect(),
      ));
    }
  }
}