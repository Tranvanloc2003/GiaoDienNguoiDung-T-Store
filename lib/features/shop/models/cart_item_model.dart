class GioHangSanPhamModel {
  String maSanPham;
  String tenSanPham;
  double gia;
  String? hinhAnh;
  int soLuong;
  String maBienThe;
  String? tenThuongHieu;
  Map<String, String>? bienTheDaChon;

  GioHangSanPhamModel({
    required this.maSanPham,
    required this.soLuong,
    this.maBienThe = "",
    this.hinhAnh,
    this.gia = 0.0,
    this.tenSanPham = "",
    this.tenThuongHieu,
    this.bienTheDaChon,
  });

  static GioHangSanPhamModel empty() => GioHangSanPhamModel(maSanPham: "", soLuong: 0);

  Map<String, dynamic> toJson() {
    return {
      "productId": maSanPham,
      "title": tenSanPham,
      "price": gia,
      "image": hinhAnh,
      "quantity": soLuong,
      "variationId": maBienThe,
      "brandName": tenThuongHieu,
      "selectedVariation": bienTheDaChon
    };
  }

  factory GioHangSanPhamModel.fromJson(Map<String, dynamic> json) {
    return GioHangSanPhamModel(
        maSanPham: json['productId'] as String,
        tenSanPham: json['title'] as String,
        gia: json['price']?.toDouble(),
        hinhAnh: json['image'],
        soLuong: json['quantity'] as int,
        maBienThe: json['variationId'] as String,
        tenThuongHieu: json['brandName'],
        bienTheDaChon: json["selectedVariation"] != null
            ? Map<String, String>.from(json["selectedVariation"])
            : null);
  }
}