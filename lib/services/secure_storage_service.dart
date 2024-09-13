import '../config/config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService._internal();
  factory SecureStorageService() => _instance;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  SecureStorageService._internal();

  Future<String?> read() async {
    return await _secureStorage.read(key: Config.secureStorageAppKey);
  }

  Future<void> save(String token) async {
    await _secureStorage.write(key: Config.secureStorageAppKey, value: token);
  }

  Future<void> delete() async {
    await _secureStorage.delete(key: Config.secureStorageAppKey);
  }
}
