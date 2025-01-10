import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/data/repositories/address/address_repository.dart';
import 'package:t_store/features/personalization/models/address_model.dart';
import 'package:t_store/features/personalization/screens/address/add_new_address.dart';
import 'package:t_store/features/personalization/screens/address/widgets/single_address.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/cloud_helper_functions.dart';
import 'package:t_store/utils/helpers/network_manager.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  // Các biến
  final hoTen = TextEditingController();
  final soDienThoai = TextEditingController();
  final duong = TextEditingController();
  final maZip = TextEditingController();
  final thanhPho = TextEditingController();
  final tinh = TextEditingController();
  final quocGia = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  Rx<DiaChiModel> selectedAddress = DiaChiModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  Future<List<DiaChiModel>> layTatCaDiaChiNguoiDung() async {
    try {
      final addresses = await addressRepository.layDiaChiNguoiDung();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.diaChiDaChon,
          orElse: () => DiaChiModel.empty());
      return addresses;
    } catch (e) {
      TLoaders.errorSnackBar(
          title: "Không tìm thấy địa chỉ!", message: e.toString());
      return [];
    }
  }

    Future chonDiaChi(DiaChiModel newSelectedAddress) async {
    try {
      Get.dialog(
          barrierDismissible: false,
          Center(
            child: Container(
              color: Colors.transparent,
              child: Container(
                height: 50.0,
                width: 50.0,
                padding: const EdgeInsets.all(12.5),
                decoration: const BoxDecoration(
                    color: TColors.primary, shape: BoxShape.circle),
                child: const CircularProgressIndicator(
                  color: TColors.white,
                  strokeWidth: 4,
                ),
              ),
            ),
          ));
      // Xóa trường đã chọn
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.capNhatTruongDaChon(
            selectedAddress.value.id, false);
      }
      // Gán địa chỉ đã chọn
      newSelectedAddress.diaChiDaChon = true;
      selectedAddress.value = newSelectedAddress;

      // Đặt trường "selected" thành true
      await addressRepository.capNhatTruongDaChon(
          selectedAddress.value.id, true);

      Get.back();
    } catch (e) {
      TLoaders.errorSnackBar(
          title: "Không tìm thấy địa chỉ!", message: e.toString());
      return [];
    }
  }

  void datLaiBieuMau() {
    hoTen.clear();
    soDienThoai.clear();
    duong.clear();
    maZip.clear();
    thanhPho.clear();
    tinh.clear();
    quocGia.clear();
    addressFormKey.currentState?.reset();
  }

  Future themDiaChiMoi() async {
    try {
      TFullScreenLoader.openLoadingDialog(
          "Đang lưu địa chỉ", TImages.doccerAnimation);

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        TLoaders.warningSnackBar(
            title: 'Không có kết nối Internet',
            message:
                "Bạn chưa kết nối mạng. Vui lòng kết nối để tiếp tục.");
        return;
      }
      if (!addressFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final address = DiaChiModel(
          id: "",
          hoTen: hoTen.text.trim(),
          soDienThoai: soDienThoai.text.trim(),
          duong: duong.text.trim(),
          thanhPho: thanhPho.text.trim(),
          tinh: tinh.text.trim(),
          maZip: maZip.text.trim(),
          quocGia: quocGia.text.trim(),
          diaChiDaChon: true);
      final id = await addressRepository.themDiaChi(address);

      address.id = id;
      await chonDiaChi(address);

      TFullScreenLoader.stopLoading();
      TLoaders.succcesSnackBar(
          title: 'Chúc mừng!',
          message: "Địa chỉ của bạn đã được lưu thành công.");

      refreshData.toggle();

      datLaiBieuMau();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(
          title: 'Không tìm thấy địa chỉ!', message: e.toString());
    }
  }

 Future<dynamic> hienThiPopupChonDiaChiMoi(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => Container(
              padding: const EdgeInsets.all(TSizes.lg),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TSectionHeading(
                      title: "Chọn địa chỉ",
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    FutureBuilder(
                        future: layTatCaDiaChiNguoiDung(),
                        builder: (_, snapshot) {
                          // Hàm trợ giúp
                          final response =
                              TCloudHelperFunctions.checkMultiRecordState(
                                  snapshot: snapshot);
                          if (response != null) return response;

                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (_, index) => TSingleAddress(
                                  address: snapshot.data![index],
                                  onTap: () async {
                                    await chonDiaChi(snapshot.data![index]);
                                    Get.back();
                                  }));
                        }),
                    const SizedBox(
                      height: TSizes.defaultSpace * 2,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () =>
                            Get.to(() => const AddNewAddressScreen()),
                        child: const Text("Thêm địa chỉ mới"),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
