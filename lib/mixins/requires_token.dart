import 'package:organize_ai_app/services/secure_storage_service.dart';

mixin RequiresToken {
  Future<String?> getToken() async {
    return await SecureStorageService().read();
  }
}
