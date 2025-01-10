import 'package:get/get.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/data/repositories/banners/banners_repositoty.dart';
import 'package:t_store/features/shop/models/banner_model.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  // Variables
  final carauselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    layDuLieuBanner();
    super.onInit();
  }

 
  void capNhatChiSoTrang(index) {
    carauselCurrentIndex.value = index;
  }


  Future<void> layDuLieuBanner() async {
    try {
      isLoading.value = true;

      final bannerRepository = Get.put(BannerRepository());
      final banners = await bannerRepository.layDanhSachBanner();

      this.banners.assignAll(banners);
    } catch (e) {
      TLoaders.errorSnackBar(title: "Lỗi!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
