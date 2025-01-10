import 'package:cloud_firestore/cloud_firestore.dart';

class ThuongHieuModel {
  String id;
  String tenThuongHieu;
  String hinhAnh;
  bool? thuongHieuNoiBat;
  int? soLuongSanPham;

  ThuongHieuModel({
    required this.id,
    required this.tenThuongHieu,
    required this.hinhAnh,
    this.thuongHieuNoiBat,
    this.soLuongSanPham,
  });

  static ThuongHieuModel empty() => ThuongHieuModel(id: "", tenThuongHieu: "", hinhAnh: "");

  toJson() {
    return {
      "Id": id,
      "Name": tenThuongHieu,
      "Image": hinhAnh,
      "IsFeatured": thuongHieuNoiBat,
      "ProductsCount": soLuongSanPham,
    };
  }

  factory ThuongHieuModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) {
      return ThuongHieuModel.empty();
    }
    return ThuongHieuModel(
        id: data["Id"] ?? "",
        tenThuongHieu: data["Name"] ?? "",
        hinhAnh: data["Image"] ?? "",
        thuongHieuNoiBat: data["IsFeatured"] ?? false,
        soLuongSanPham: int.parse((data["ProductsCount"] ?? 0).toString()));
  }

  factory ThuongHieuModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ThuongHieuModel(
          id: document.id,
          tenThuongHieu: data["Name"] ?? "",
          hinhAnh: data["Image"] ?? "",
          thuongHieuNoiBat: data["IsFeatured"] ?? false,
          soLuongSanPham: data["ProductsCount"] ?? 0);
    } else {
      return ThuongHieuModel.empty();
    }
  }
}