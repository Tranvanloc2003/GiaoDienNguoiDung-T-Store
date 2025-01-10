import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/data/services/firebase_storage_service.dart';
import 'package:t_store/features/shop/models/category_model.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/utils/exceptions/format_exceptions.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;


  Future<List<DanhMucModel>> layTatCaDanhMuc() async {
    try {
      final snapshot = await _db.collection("DanhMuc").get();
      final list = snapshot.docs
          .map((document) => DanhMucModel.fromSnaphot(document))
          .toList();
      return list;
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

  Future<List<DanhMucModel>> layDanhMucCon(String categoryId) async {
    try {
      final snapshot = await _db
          .collection("DanhMuc")
          .where("ParentId", isEqualTo: categoryId)
          .get();
      final list = snapshot.docs
          .map((document) => DanhMucModel.fromSnaphot(document))
          .toList();
      return list;
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
