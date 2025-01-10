import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/data/services/firebase_storage_service.dart';
import 'package:t_store/features/shop/models/brand_model.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/utils/exceptions/format_exceptions.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  
  Future<List<ThuongHieuModel>> layTatCaThuongHieu() async {
    try {
      final snapshot = await _db.collection("ThuongHieu").get();
      final result = snapshot.docs
          .map((document) => ThuongHieuModel.fromSnapshot(document))
          .toList();
      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Đã xảy ra lỗi. Vui lòng thử lại.";
    }
  }

  
  Future<List<ThuongHieuModel>> layThuongHieuTheoDanhMuc(String categoryId) async {
    try {
      QuerySnapshot brandCategoryQuery = await _db
          .collection("ThuongHieuSanPham")
          .where("categoryId", isEqualTo: categoryId)
          .get();
      if (brandCategoryQuery.docs.isEmpty) {
        return [];
      }
      List<String> brandIds = brandCategoryQuery.docs
          .map((doc) => doc["brandId"] as String)
          .toList();

      final brandsQuery = await _db
          .collection("ThuongHieu")
          .where(FieldPath.documentId, whereIn: brandIds)
          .limit(2)
          .get();
      List<ThuongHieuModel> brands =
          brandsQuery.docs.map((doc) => ThuongHieuModel.fromSnapshot(doc)).toList();

      return brands;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Đã xảy ra lỗi. Vui lòng thử lại.";
    }
  }

 
}
