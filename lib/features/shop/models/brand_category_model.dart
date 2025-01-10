import 'package:cloud_firestore/cloud_firestore.dart';

class DanhMucThuongHieuModel {
  final String maThuongHieu;
  final String maDanhMuc;

  DanhMucThuongHieuModel({
    required this.maThuongHieu,
    required this.maDanhMuc,
  });

  Map<String, dynamic> toJson() {
    return {
      "brandId": maThuongHieu,
      "categoryId": maDanhMuc,
    };
  }

  factory DanhMucThuongHieuModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return DanhMucThuongHieuModel(
      maThuongHieu: data["brandId"] as String,
      maDanhMuc: data["categoryId"] as String,
    );
  }
}