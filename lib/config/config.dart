import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get apiUrl {
    return dotenv.env['API_BASE_URL'] ?? '';
  }

  static String get secureStorageAppKey {
    return dotenv.env['SECURE_STORAGE_APP_KEY'] ?? '';
  }
}
