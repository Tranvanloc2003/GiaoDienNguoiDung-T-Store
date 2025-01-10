class ThuocTinhSanPhamModel {
  String? tenThuocTinh;
  final List<String>? danhSachGiaTri;

  ThuocTinhSanPhamModel({
    this.tenThuocTinh,
    this.danhSachGiaTri,
  });

  toJson() {
    return {
      "Name": tenThuocTinh,
      "Values": danhSachGiaTri,
    };
  }

  factory ThuocTinhSanPhamModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) {
      return ThuocTinhSanPhamModel();
    }
    return ThuocTinhSanPhamModel(
        tenThuocTinh: data.containsKey("Name") ? data["Name"] : "",
        danhSachGiaTri: List<String>.from(data["Values"]));
  }
}