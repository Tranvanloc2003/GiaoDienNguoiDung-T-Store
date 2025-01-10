// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/utils/formatters/formatter.dart';

class DiaChiModel {
  String id;
  final String hoTen;
  final String soDienThoai; 
  final String duong;
  final String thanhPho;
  final String tinh;
  final String maZip;
  final String quocGia;
  final DateTime? thoiGian;
  bool diaChiDaChon;

  DiaChiModel({
    required this.id,
    required this.hoTen,
    required this.soDienThoai,
    required this.duong,
    required this.thanhPho,
    required this.tinh,
    required this.maZip,
    required this.quocGia,
    this.thoiGian,
    this.diaChiDaChon = true,
  });

  String get soDienThoaiDinhDang => TFormatter.formatPhoneNumber(soDienThoai);

  static DiaChiModel empty() => DiaChiModel(
        id: "",
        hoTen: "",
        soDienThoai: "",
        duong: "",
        thanhPho: "",
        tinh: "",
        maZip: "",
        quocGia: "",
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Id': id,
      'Name': hoTen,
      'PhoneNumber': soDienThoai,
      'Street': duong,
      'City': thanhPho,
      'State': tinh,
      'PostalCode': maZip,
      'Country': quocGia,
      'DateTime': DateTime.now(),
      'SelectedAddress': diaChiDaChon,
    };
  }

  factory DiaChiModel.fromMap(Map<String, dynamic> data) {
    return DiaChiModel(
      id: data['Id'] as String,
      hoTen: data['Name'] as String,
      soDienThoai: data['PhoneNumber'] as String,
      duong: data['Street'] as String,
      thanhPho: data['City'] as String,
      tinh: data['State'] as String,
      maZip: data['PostalCode'] as String,
      quocGia: data['Country'] as String,
      thoiGian: (data['DateTime'] as Timestamp).toDate(),
      diaChiDaChon: data['SelectedAddress'] as bool,
    );
  }

  factory DiaChiModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return DiaChiModel(
      id: snapshot.id,
      hoTen: data['Name'] ?? "",
      soDienThoai: data['PhoneNumber'] ?? "",
      duong: data['Street'] ?? "",
      thanhPho: data['City'] ?? "",
      tinh: data['State'] ?? "",
      maZip: data['PostalCode'] ?? "",
      quocGia: data['Country'] ?? "",
      thoiGian: (data['DateTime'] as Timestamp).toDate(),
      diaChiDaChon: data['SelectedAddress'] as bool,
    );
  }

  @override
  String toString() {
    return "$duong, $thanhPho, $tinh $maZip, $quocGia";
  }
}