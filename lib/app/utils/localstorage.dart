import 'package:get_storage/get_storage.dart';

abstract class LocalStorage {
  bool has(String key);
  dynamic read(String key);
  void write(String key, dynamic value);
}

class GetStorageService implements LocalStorage {
  final box = GetStorage();

  @override
  bool has(String key) => box.hasData(key);

  @override
  read(String key) => box.read(key);

  @override
  void write(String key, value) => box.write(key, value);
}