import 'package:flutter/material.dart';
import 'package:smart_pay/app/shared/classes/secure/secure_storage.dart';
import 'package:smart_pay/core/framework/environments/environment.dart';

class Setups {
  static void init() async {
    WidgetsFlutterBinding.ensureInitialized();
    SecureStorage.init();
    EnvironmentSetup.run(environment: Environment.live);
  }
}
