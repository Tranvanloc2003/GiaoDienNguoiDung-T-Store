import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/features/authentication/screens/login/login.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  // Biến
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  // Cập nhật chỉ số trang
  void updatePageIndicator(index) {
    currentPageIndex.value = index;
  }

  // Điều hướng khi nhấn vào chấm trang
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  // Chuyển đến trang tiếp theo
  void nextPage() {
    if (currentPageIndex.value == 2) {
      final storage = GetStorage();
      storage.write("isFirstTime", false);
      Get.offAll(const LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  // Bỏ qua tất cả các trang
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}
