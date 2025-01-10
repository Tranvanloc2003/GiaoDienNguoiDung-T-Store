// ignore_for_file: public_member_api_docs, sort_constructors_first
class ThanhToanModel {
  String tenPhuongThuc;
  String hinhAnh;
  ThanhToanModel({
    required this.tenPhuongThuc,
    required this.hinhAnh,
  });

  static ThanhToanModel empty() => ThanhToanModel(tenPhuongThuc: "", hinhAnh: "");
}