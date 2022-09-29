import 'package:shared_preferences/shared_preferences.dart';

class StorageService{

  StorageService._();

  static StorageService? _instance;
  static Future<StorageService> getInstance() async {
    if(_instance == null){
      _instance = StorageService._();
      _instance!._storage = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  SharedPreferences? _storage;

  Future<void> setString(String key, String value) async {
    _storage!.setString(key, value);
  }
  Future<void> setInt(String key, int value) async {
    _storage!.setInt(key, value);
  }

  String? getString(String key){
    return _storage!.getString(key);
  }
  int? getInt(String key){
    return _storage!.getInt(key);
  }

  void remove(String key) {
    _storage?.remove(key);
  }

}