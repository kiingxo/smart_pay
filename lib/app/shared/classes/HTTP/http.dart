import 'dart:convert';

import 'package:smart_pay/core/framework/environments/environment.dart';
import 'package:http/http.dart' as http;

class HTTP {
  static String get baseUrl => EnvironmentSetup.baseUrl;

  static final Map<String, String> _headers = Map<String, String>.from(
    {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },
  );

  static Map<String, String> get _getHeaders =>
      Map<String, String>.from(_headers);

  static List<String> headerLog = [];

  static addHeader({
    required String key,
    required String value,
  }) {
    _headers[key] = value;
    headerLog.add("$key: $value");
  }

  static Future<http.Response> post(
    String path, {
    required Map<String, dynamic> body,
  }) async {
    final url = '$baseUrl/$path';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: _getHeaders,
    );
    return response;
  }

  static Future<http.Response> get(
    String path, {
    required Map<String, dynamic> body,
  }) async {
    final url = '$baseUrl/$path';
    final response = await http.get(
      Uri.parse(url),
      headers: _getHeaders,
    );
    return response;
  }
}
