import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';
import 'package:t_store/data/services/firebase_storage_service.dart';
import 'package:t_store/features/shop/models/product_model.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/utils/exceptions/format_exceptions.dart';
import 'package:t_store/utils/exceptions/platform_exceptions.dart';
import 'package:t_store/utils/popups/full_screen_loader.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<SanPhamModel>> laySanPhamNoiBat({int limit = 4}) async {
    try {
      final snapshot = (limit == -1)
          ? await _db
              .collection("SanPham")
              .where("IsFeatured", isEqualTo: true)
              .get()
          : await _db
              .collection("SanPham")
              .where("IsFeatured", isEqualTo: true)
              .limit(4)
              .get();

      return snapshot.docs.map((e) => SanPhamModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw "Đã xảy ra lỗi. Vui lòng thử lại";
    }
  }

  //Getall Products
    Future<List<SanPhamModel>> layTatCaSanPhamNoiBat() async {
    try {
      final snapshot = await _db
          .collection("SanPham")
          .where("IsFeatured", isEqualTo: true)
          .get();

      return snapshot.docs.map((e) => SanPhamModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw "Đã xảy ra lỗi. Vui lòng thử lại";
    }
  }

  //Getall Products
   Future<List<SanPhamModel>> layDanhSachSanPhamTheoQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<SanPhamModel> productsList = querySnapshot.docs
          .map((e) => SanPhamModel.fromQuerySnapshot(e))
          .toList();

      return productsList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw "Đã xảy ra lỗi. Vui lòng thử lại";
    }
  }

    Future<List<SanPhamModel>> laySanPhamYeuThich(List<String> productIds) async {
    try {
      final snapshot = await _db
          .collection("SanPham")
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      return snapshot.docs
          .map((querySnapshot) => SanPhamModel.fromSnapshot(querySnapshot))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw "Đã xảy ra lỗi. Vui lòng thử lại";
    }
  }

 Future<List<SanPhamModel>> laySanPhamTheoThuongHieu(
      {required String brandId, int limit = -1}) async {
    try {
      final querySnapshot = (limit == -1)
          ? await _db
              .collection("SanPham")
              .where("Brand.Id", isEqualTo: brandId)
              .get()
          : await _db
              .collection("SanPham")
              .where("Brand.Id", isEqualTo: brandId)
              .limit(limit)
              .get();
      final products = querySnapshot.docs
          .map((doc) => SanPhamModel.fromSnapshot(doc))
          .toList();
      return products;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw "Đã xảy ra lỗi. Vui lòng thử lại";
    }
  }

  Future<List<SanPhamModel>> laySanPhamTheoDanhMuc(
      {required String categoryId, int limit = -1}) async {
    try {
      QuerySnapshot productsCategoryQuery = (limit == -1)
          ? await _db
              .collection("DanhMucSanPham")
              .where("categoryId", isEqualTo: categoryId)
              .get()
          : await _db
              .collection("DanhMucSanPham")
              .where("categoryId", isEqualTo: categoryId)
              .limit(limit)
              .get();
      List<String> productIds = productsCategoryQuery.docs
          .map((doc) => doc["productId"] as String)
          .toList();
      if (productIds.isEmpty) {
        return [];
      }
      final productsQuery = await _db
          .collection("SanPham")
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      List<SanPhamModel> products = productsQuery.docs
          .map((doc) => SanPhamModel.fromSnapshot(doc))
          .toList();
      return products;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      throw "Đã xảy ra lỗi. Vui lòng thử lại";
    }
  }
}
