import 'dart:io';

import 'package:flutter/foundation.dart';

class RegisterModel {
  String email;
  String password;

  String fullName;
  String username;
  String country;

  RegisterModel({
    required this.email,
    required this.password,
    required this.fullName,
    required this.username,
    required this.country,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "device_name": _getDeviceName(),
      "username": username,
      "full_name": fullName,
      "country": country,
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
      //LIKELY NOT!
      return 'n/a';
  }
}
