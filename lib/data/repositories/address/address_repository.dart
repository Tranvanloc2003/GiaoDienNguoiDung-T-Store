import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';
import 'package:t_store/features/personalization/models/address_model.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<DiaChiModel>> layDiaChiNguoiDung() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw "Không thể tìm thấy thông tin người dùng. Vui lòng thử lại sau vài phút.";
      }

      final result = await _db
          .collection("NguoiDung")
          .doc(userId)
          .collection("DiaChi")
          .get();
      return result.docs
          .map((documentSnapShot) =>
              DiaChiModel.fromDocumentSnapshot(documentSnapShot))
          .toList();
    } catch (e) {
      throw "Đã xảy ra lỗi trong khi lấy thông tin địa chỉ. Vui lòng thử lại sau.";
    }
  }

  Future<void> capNhatTruongDaChon(String addressId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      await _db
          .collection("NguoiDung")
          .doc(userId)
          .collection("DiaChi")
          .doc(addressId)
          .update({"SelectedAddress": selected});
    } catch (e) {
      throw "Không thể cập nhật lựa chọn địa chỉ của bạn. Vui lòng thử lại sau.";
    }
  }

  Future<String> themDiaChi(DiaChiModel address) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentAddress = await _db
          .collection("NguoiDung")
          .doc(userId)
          .collection("DiaChi")
          .add(address.toJson());
      return currentAddress.id;
    } catch (e) {
      throw "Không thể thêm địa chỉ của bạn. Vui lòng thử lại sau.";
    }
  }
}