import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:t_store/data/repositories/authentication/authentication_repository.dart';

import 'package:t_store/features/shop/models/order_model.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  // Biến
  final _db = FirebaseFirestore.instance;

  Future<List<DonHangModel>> layDonHangNguoiDung() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw "Không thể tìm thấy thông tin người dùng. Vui lòng thử lại sau vài phút";
      }
      final result =
          await _db.collection("NguoiDung").doc(userId).collection("DonHang").get();

      return result.docs
          .map((documentSnapshot) => DonHangModel.fromSnapShot(documentSnapshot))
          .toList();
    } catch (e) {
      throw "Đã xảy ra lỗi khi lấy thông tin đơn hàng. Vui lòng thử lại sau";
    }
  }

  Future<void> luuDonHang(DonHangModel order, String userId) async {
    try {
      await _db
          .collection("NguoiDung")
          .doc(userId)
          .collection("DonHang")
          .add(order.toJson());
    } catch (e) {
      throw "Đã xảy ra lỗi khi lưu thông tin đơn hàng. Vui lòng thử lại sau";
    }
  }
}
