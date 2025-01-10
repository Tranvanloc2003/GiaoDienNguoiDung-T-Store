// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class DanhMucModel {
  String id;
  String tenDanhMuc;
  String hinhAnh;
  String maDanhMucCha;
  bool danhMucNoiBat;

  DanhMucModel({
    required this.id,
    required this.tenDanhMuc,
    required this.hinhAnh,
    this.maDanhMucCha = "",
    required this.danhMucNoiBat,
  });
  
  static DanhMucModel empty() => DanhMucModel(
        id: "",
        tenDanhMuc: "",
        hinhAnh: "",
        danhMucNoiBat: false,
      );

  Map<String, dynamic> toJson() {
    return {
      "Name": tenDanhMuc,
      "Image": hinhAnh,
      "ParentId": maDanhMucCha,
      "IsFeatured": danhMucNoiBat,
    };
  }

  factory DanhMucModel.fromSnaphot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return DanhMucModel(
        id: document.id,
        tenDanhMuc: data["Name"] ?? "",
        hinhAnh: data["Image"] ?? "",
        danhMucNoiBat: data["IsFeatured"] ?? false,
        maDanhMucCha: data["ParentId"] ?? "",
      );
    } else {
      return DanhMucModel.empty();
    }
  }
}