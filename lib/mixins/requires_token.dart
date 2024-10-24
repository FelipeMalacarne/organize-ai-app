import 'package:organize_ai_app/services/secure_storage_service.dart';

mixin RequiresToken {
  Future<String?> getToken() async {
    return await SecureStorageService().read();
  }

  Future<void> setToken(String token) async {
    await SecureStorageService().save(token);
  }

  Future<void> deleteToken() async {
    await SecureStorageService().delete();
  }
}
