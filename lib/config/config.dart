import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get apiUrl {
    return dotenv.env['API_BASE_URL'] ?? '';
  }
}
