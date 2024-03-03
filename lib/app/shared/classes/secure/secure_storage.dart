import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static late FlutterSecureStorage secureStorage;

  static void init() {
    secureStorage = const FlutterSecureStorage();
  }

  static Future<void> write({
    required String key,
    required String value,
  }) async {
    await secureStorage.write(
      key: key,
      value: value,
    );
  }

  static Future<String?> retrive({required String key}) async {
    final data = await secureStorage.read(
      key: key,
    );
    return data;
  }

  static Future<void> clear() async {
    await secureStorage.deleteAll();
  }
}

class SecureStorageKeys {
  static String password = "password";
  static String email = "email";
  static String pin = "pin";
}
