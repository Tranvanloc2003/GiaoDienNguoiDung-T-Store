import 'package:get_storage/get_storage.dart';

class TLocalStorage {
  late final GetStorage _storage;
  // Instance Singleton
  static TLocalStorage? _instance;

  TLocalStorage._internal();

  factory TLocalStorage.instance() {
    _instance ??= TLocalStorage._internal();
    return _instance!;
  }

  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance = TLocalStorage._internal();
    _instance!._storage = GetStorage(bucketName);
  }

  // Phương thức chung để lưu dữ liệu
  Future<void> writeData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  // Phương thức chung để đọc dữ liệu
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  // Phương thức chung để xóa dữ liệu
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  // Xóa tất cả dữ liệu trong bộ nhớ
  Future<void> clearAll() async {
    await _storage.erase();
  }
}


