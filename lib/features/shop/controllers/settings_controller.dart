import 'package:get/get.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  //Biến
  RxBool geoLocationSwitch = true.obs;
  RxBool safeModeSwitch = false.obs;
  RxBool hdImgQualitySwitch = false.obs;
}
