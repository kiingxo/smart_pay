import 'dart:io';

import 'package:flutter/foundation.dart';

class LoginModel {
  String email;
  String password;

  LoginModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "device_name": _getDeviceName()
    };
  }
}

String _getDeviceName() {
  if (kIsWeb) {
    return "web";
  }
  switch (Platform.operatingSystem) {
    case 'android':
      return 'android';
    case 'ios':
      return 'ios';
    default:
      return 'n/a';
  }
}
