import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/utils/formatters/formatter.dart';

class NguoiDungModel {
  final String id;
  String hoTen;
  String ho;
  final String tenNguoiDung;
  final String email;
  String soDienThoai;
  String anhDaiDien;

  NguoiDungModel({
    required this.id,
    required this.hoTen,
    required this.ho,
    required this.tenNguoiDung,
    required this.email,
    required this.soDienThoai,
    required this.anhDaiDien,
  });

  String get tenDayDu => "$hoTen $ho";

  String get soDienThoaiDinhDang => TFormatter.formatPhoneNumber(soDienThoai);

  static List<String> nameParts(tenDayDu) => tenDayDu.split(" ");

  static String generateUserName(tenDayDu) {
    List<String> phanTen = tenDayDu.split(" ");
    String hoTen = phanTen[0].toLowerCase();
    String ho = phanTen.length > 1 ? phanTen[1].toLowerCase() : "";

    String tenNguoiDungCamelCase = "$hoTen$ho";
    String tenNguoiDungKetHop = "tstore_$tenNguoiDungCamelCase";
    return tenNguoiDungKetHop;
  }

  static NguoiDungModel empty() => NguoiDungModel(
      id: "",
      hoTen: "",
      ho: "",
      tenNguoiDung: "",
      email: "",
      soDienThoai: "",
      anhDaiDien: "");

  Map<String, dynamic> toJson() {
    return {
      "FirstName": hoTen,
      "LastName": ho,
      "UserName": tenNguoiDung,
      "Email": email,
      "PhoneNumber": soDienThoai,
      "ProfilePicture": anhDaiDien
    };
  }

  factory NguoiDungModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> taiLieu) {
    if (taiLieu.data() != null) {
      final duLieu = taiLieu.data()!;
      return NguoiDungModel(
        id: taiLieu.id,
        hoTen: duLieu["FirstName"] ?? "",
        ho: duLieu["LastName"] ?? "",
        tenNguoiDung: duLieu["UserName"] ?? "",
        email: duLieu["Email"] ?? "",
        soDienThoai: duLieu["PhoneNumber"] ?? "",
        anhDaiDien: duLieu["ProfilePicture"] ?? "",
      );
    } else {
      return NguoiDungModel.empty();
    }
  }
}
