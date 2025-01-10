import 'dart:async';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:t_store/common/widgets/loaders/loaders.dart';

/// Quản lý trạng thái kết nối mạng và cung cấp phương thức kiểm tra, xử lý thay đổi kết nối.
class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  /// Khởi tạo network manager và thiết lập stream để liên tục kiểm tra trạng thái kết nối.
  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  /// Cập nhật trạng thái kết nối dựa trên thay đổi và hiển thị thông báo khi không có kết nối internet.
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus.value = result;
    if (_connectionStatus.value == ConnectivityResult.none) {
      TLoaders.warningSnackBar(
          title: 'Không có kết nối Internet',
          message: 'Bạn chưa kết nối mạng. Vui lòng kết nối để tiếp tục.');
    }
  }

  /// Kiểm tra trạng thái kết nối internet.
  /// Trả về `true` nếu đã kết nối, `false` nếu ngược lại.
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Hủy hoặc đóng stream kết nối đang hoạt động.
  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}
