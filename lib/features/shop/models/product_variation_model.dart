class BienTheSanPhamModel {
  final String id;
  String maSanPham;
  String hinhAnh;
  String? moTa;
  double gia;
  double giaGiam;
  int tonKho;
  Map<String, String> giaTriThuocTinh;

  BienTheSanPhamModel({
    required this.id,
    this.maSanPham = "",
    this.hinhAnh = "",
    this.moTa = "",
    this.gia = 0.0,
    this.giaGiam = 0.0,
    this.tonKho = 0,
    required this.giaTriThuocTinh,
  });

  static BienTheSanPhamModel empty() => BienTheSanPhamModel(
        id: "",
        giaTriThuocTinh: {},
      );

  toJson() {
    return {
      'Id': id,
      'SKU': maSanPham,
      'Image': hinhAnh,
      'Description': moTa,
      'Price': gia,
      'SalePrice': giaGiam,
      'Stock': tonKho,
      'AttributeValues': giaTriThuocTinh,
    };
  }

  factory BienTheSanPhamModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) {
      return BienTheSanPhamModel.empty();
    }

    return BienTheSanPhamModel(
        id: data['Id'] ?? "",
        maSanPham: data['SKU'] ?? "",
        hinhAnh: data['Image'] ?? "",
        moTa: data['Description'] ?? "",
        gia: double.parse((data['Price'] ?? 0.0).toString()),
        giaGiam: double.parse((data['SalesPrice'] ?? 0.0).toString()),
        tonKho: data['Stock'] ?? 0,
        giaTriThuocTinh: Map<String, String>.from(
          (data['AttributeValues']),
        ));
  }
}