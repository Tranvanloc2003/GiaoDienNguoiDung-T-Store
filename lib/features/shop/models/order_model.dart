import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/features/personalization/models/address_model.dart';
import 'package:t_store/features/shop/models/cart_item_model.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class DonHangModel {
  final String id;
  final String maNguoiDung;
  final OrderStatus trangThai;
  final double tongTien;
  final DateTime ngayDatHang;
  final String phuongThucThanhToan;
  final DiaChiModel? diaChi;
  final DateTime? ngayGiaoHang;
  final List<GioHangSanPhamModel> danhSachSanPham;

  DonHangModel({
    required this.id,
    this.maNguoiDung = "",
    required this.trangThai,
    required this.tongTien,
    required this.ngayDatHang,
    this.phuongThucThanhToan = "PayPal",
    this.ngayGiaoHang,
    this.diaChi,
    required this.danhSachSanPham,
  });

  String get ngayDatHangDinhDang => THelperFunctions.getFormattedDate(ngayDatHang);

  String get ngayGiaoHangDinhDang => ngayGiaoHang != null
      ? THelperFunctions.getFormattedDate(ngayGiaoHang!)
      : "";

  String get trangThaiDonHangText {
    switch (trangThai) {
      case OrderStatus.dangXuLi:
        return "Đang xử lí";
      case OrderStatus.xacNhanDon:
        return "Đã xác nhận";
      case OrderStatus.chuanBiHang:
        return "Chuẩn bị hàng";
      case OrderStatus.dangGiaoHang:
        return "Đang giao hàng";
      case OrderStatus.daGiaoHang:
        return "Đã giao hàng";
      case OrderStatus.huyDon:
        return "Đã hủy";
    }
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'userId': maNguoiDung,
      'status': trangThai.toString(),
      'totalAmount': tongTien,
      'orderDate': ngayDatHang,
      'paymentMethod': phuongThucThanhToan,
      'address': diaChi?.toJson(),
      'deliveryDate': ngayGiaoHang,
      'items': danhSachSanPham.map((item) => item.toJson()).toList(),
    };
  }

  factory DonHangModel.fromSnapShot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return DonHangModel(
        id: data['id'] as String,
        maNguoiDung: data['userId'] as String,
        trangThai: OrderStatus.values
            .firstWhere((element) => element.toString() == data["status"]),
        tongTien: data['totalAmount'] as double,
        ngayDatHang: (data["orderDate"] as Timestamp).toDate(),
        phuongThucThanhToan: data['paymentMethod'] as String,
        diaChi: DiaChiModel.fromMap(data["address"] as Map<String, dynamic>),
        ngayGiaoHang: data['deliveryDate'] != null
            ? (data["deliveryDate"] as Timestamp).toDate()
            : null,
        danhSachSanPham: (data["items"] as List<dynamic>)
            .map((itemData) =>
                GioHangSanPhamModel.fromJson(itemData as Map<String, dynamic>))
            .toList());
  }
}