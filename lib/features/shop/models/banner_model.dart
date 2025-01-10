import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BannerModel {
  String duongDanAnh;
  final String manHinhDich;
  final bool hoatDong;
  
  BannerModel({
    required this.duongDanAnh,
    required this.manHinhDich,
    required this.hoatDong,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'ImageUrl': duongDanAnh,
      'TargetScreen': manHinhDich,
      'Active': hoatDong,
    };
  }

  factory BannerModel.fromSnaphot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return BannerModel(
      duongDanAnh: data['ImageUrl'] ?? "",
      manHinhDich: data['TargetScreen'] ?? "",
      hoatDong: data['Active'] ?? false,
    );
  }
}