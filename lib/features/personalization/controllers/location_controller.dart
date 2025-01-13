import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/store_model.dart';

class LocationController extends GetxController {
  static LocationController get instance => Get.find();

  final RxList<DaiLyModel> danhSachDaiLy = <DaiLyModel>[
    DaiLyModel(
      id: '1',
      ten: 'T-Store Chi nhánh 1',
      diaChi: '123 Nguyễn Văn A, Q.1, TP.HCM',
      viDo: 10.771423,
      kinhDo: 106.698471,
      soDienThoai: '028.1234.5678',
      gioMoCua: '8:00 - 22:00'
    ),
    DaiLyModel(
      id: '2', 
      ten: 'T-Store Chi nhánh 2',
      diaChi: '456 Lê Văn B, Q.2, TP.HCM',
      viDo: 10.780000,
      kinhDo: 106.700000,
      soDienThoai: '028.2345.6789',
      gioMoCua: '8:00 - 22:00'
    ),
    DaiLyModel(
      id: '3',
      ten: 'T-Store Chi nhánh 3', 
      diaChi: '789 Trần Văn C, Q.3, TP.HCM',
      viDo: 10.790000,
      kinhDo: 106.710000,
      soDienThoai: '028.3456.7890',
      gioMoCua: '8:00 - 22:00'
    ),
  ].obs;

  final Rx<DaiLyModel?> selectedStore = Rx<DaiLyModel?>(null);

  Set<Marker> getMarkers() {
    return danhSachDaiLy.map((store) {
      return Marker(
        markerId: MarkerId(store.id),
        position: LatLng(store.viDo, store.kinhDo),
        infoWindow: InfoWindow(
          title: store.ten,
          snippet: store.diaChi,
        ),
        onTap: () {
          selectedStore.value = store;
        },
      );
    }).toSet();
  }
}