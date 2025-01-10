import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/features/shop/models/brand_model.dart';
import 'package:t_store/features/shop/models/product_attribute_model.dart';
import 'package:t_store/features/shop/models/product_variation_model.dart';

class SanPhamModel {
  String id;
  int tonKho;
  String? maSanPham;
  double gia;
  String tenSanPham;
  DateTime? ngayTao;
  double giaGiam;
  String anhDaiDien;
  bool? sanPhamNoiBat;
  ThuongHieuModel? thuongHieu;
  String? moTa;
  String? maDanhMuc;
  List<String>? danhSachAnh;
  String loaiSanPham;
  List<ThuocTinhSanPhamModel>? thuocTinhSanPham;
  List<BienTheSanPhamModel>? bienTheSanPham;

  SanPhamModel({
    required this.id,
    required this.tonKho,
    required this.gia,
    required this.tenSanPham,
    required this.anhDaiDien,
    required this.loaiSanPham,
    this.giaGiam = 0.0,
    this.maSanPham,
    this.ngayTao,
    this.thuongHieu,
    this.moTa,
    this.sanPhamNoiBat,
    this.maDanhMuc,
    this.danhSachAnh,
    this.thuocTinhSanPham,
    this.bienTheSanPham,
  });

  static SanPhamModel empty() => SanPhamModel(
        id: "",
        tonKho: 0,
        gia: 0,
        tenSanPham: "",
        anhDaiDien: "",
        loaiSanPham: "",
      );

  toJson() {
    return {
      'SKU': maSanPham,
      'Title': tenSanPham,
      'Stock': tonKho,
      'Price': gia,
      'Images': danhSachAnh ?? [],
      'Thumbnail': anhDaiDien,
      'SalePrice': giaGiam,
      'IsFeatured': sanPhamNoiBat,
      'CategoryId': maDanhMuc,
      'Brand': thuongHieu!.toJson(),
      'Description': moTa,
      'ProductType': loaiSanPham,
      'date': ngayTao?.millisecondsSinceEpoch,
      'ProductAttributes': thuocTinhSanPham != null
          ? thuocTinhSanPham!.map((e) => e.toJson()).toList()
          : [],
      'ProductVariations': bienTheSanPham != null
          ? bienTheSanPham!.map((e) => e.toJson()).toList()
          : [],
    };
  }

  factory SanPhamModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) {
      return SanPhamModel.empty();
    }
    final data = document.data()!;
    return SanPhamModel(
      id: document.id,
      tenSanPham: data["Title"],
      maSanPham: data["SKU"],
      tonKho: data['Stock'] ?? 0,
      sanPhamNoiBat: data["IsFeatured"] ?? false,
      gia: double.parse((data["Price"] ?? 0.0).toString()),
      giaGiam: double.parse((data["SalePrice"] ?? 0.0).toString()),
      anhDaiDien: data["Thumbnail"] ?? "",
      maDanhMuc: data["CategoryId"] ?? "",
      moTa: data["Description"] ?? "",
      loaiSanPham: data["ProductType"] ?? "",
      thuongHieu: ThuongHieuModel.fromJson(data["Brand"]),
      danhSachAnh: data["Images"] != null ? List<String>.from(data["Images"]) : [],
      thuocTinhSanPham: (data["ProductAttributes"] as List<dynamic>)
          .map((e) => ThuocTinhSanPhamModel.fromJson(e))
          .toList(),
      bienTheSanPham: (data["ProductVariations"] as List<dynamic>)
          .map((e) => BienTheSanPhamModel.fromJson(e))
          .toList(),
    );
  }

  factory SanPhamModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> document) {
    final data = document.data() as Map<String, dynamic>;
    return SanPhamModel(
      id: document.id,
      tenSanPham: data["Title"] ?? "",
      maSanPham: data["SKU"] ?? "",
      tonKho: data['Stock'] ?? 0,
      sanPhamNoiBat: data["IsFeatured"] ?? false,
      gia: double.parse((data["Price"] ?? 0.0).toString()),
      giaGiam: double.parse((data["SalePrice"] ?? 0.0).toString()),
      anhDaiDien: data["Thumbnail"] ?? "",
      maDanhMuc: data["CategoryId"] ?? "",
      moTa: data["Description"] ?? "",
      loaiSanPham: data["ProductType"] ?? "",
      thuongHieu: ThuongHieuModel.fromJson(data["Brand"]),
      danhSachAnh: data["Images"] != null ? List<String>.from(data["Images"]) : [],
      thuocTinhSanPham: (data["ProductAttributes"] as List<dynamic>)
          .map((e) => ThuocTinhSanPhamModel.fromJson(e))
          .toList(),
      bienTheSanPham: (data["ProductVariations"] as List<dynamic>)
          .map((e) => BienTheSanPhamModel.fromJson(e))
          .toList(),
    );
  }
}