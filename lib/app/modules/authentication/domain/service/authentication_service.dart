import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_pay/app/modules/authentication/data/model/register_model.dart';
import 'package:smart_pay/app/modules/authentication/data/model/user_model.dart';
import 'package:smart_pay/app/shared/shared.dart';

import 'package:smart_pay/core/framework/base_service/service_response.dart';

import '../../data/model/login_model.dart';
import '../../data/model/verify_email_model.dart';

class AuthenticationService {
  static Future<ServiceResponse<String>> getEmailToken(String email) {
    return serveFuture<String>(
      function: (fail) async {
        final r = await HTTP.post('auth/email', body: {"email": email});

        if (r.is200or201) {
          final body = jsonDecode(r.body);
          return body['data']['token'];
        }

        if (r.is400or422) {
          final body = jsonDecode(r.body);
          return fail(body['message'] ?? defaultError);
        }
        return fail("Something went wrong");
      },
    );
  }

  static Future<ServiceResponse<void>> verifyEmailToken(
      VerifyEmailModel model) async {
    return serveFuture<void>(
      function: (fail) async {
        final r = await HTTP.post('auth/email/verify', body: model.toJson());

        if (r.is200or201) {
          await SecureStorage.write(
              key: SecureStorageKeys.email, value: model.email);
          return;
        }

        if (r.is400or422) {
          return fail("Token is invalid or expired.");
        }

        if (r.is500) {
          return fail("Server error");
        }

        return fail(defaultError);
      },
    );
  }

  static Future<ServiceResponse<User>> login(LoginModel model) async {
    return serveFuture<User>(
      function: (fail) async {
        final r = await HTTP.post('auth/login', body: model.toJson());
        if (r.is200or201) {
          final body = jsonDecode(r.body);
          final user = body['data']['user'];
          final token = body['data']['token'];
          await SecureStorage.write(
            key: SecureStorageKeys.email,
            value: model.email,
          );
          await SecureStorage.write(
            key: SecureStorageKeys.password,
            value: model.password,
          );
          HTTP.addHeader(key: "AUTHORIZATION", value: "Bearer $token");
          return User.fromJson(user);
        }

        if (r.is400or422) {
          return fail("Invalid credentials");
        }
        return fail("Something went wrong");
      },
    );
  }

  static Future<ServiceResponse<void>> logout() async {
    return serveFuture<void>(
      function: (fail) async {
        final r = await HTTP.post('auth/logout', body: {});
        if (r.is200or201) {
          return;
        }
        return fail("Something went wrong");
      },
    );
  }

  static Future<ServiceResponse<User>> register(RegisterModel model) async {
    return serveFuture<User>(
      function: (fail) async {
        final r = await HTTP.post('auth/register', body: model.toJson());

        if (r.is200or201) {
          final body = jsonDecode(r.body);
          final user = body['data']['user'];
          final token = body['data']['token'];
          await SecureStorage.write(
              key: SecureStorageKeys.email, value: model.email);
          await SecureStorage.write(
              key: SecureStorageKeys.password, value: model.password);
          HTTP.addHeader(key: "AUTHORIZATION", value: "$token");
          return User.fromJson(user);
        }

        if (r.is400or422) {
          final body = jsonDecode(r.body);
          return fail(body['message'] ?? defaultError);
        }
        return fail("Something went wrong");
      },
    );
  }
}

final userProvider = StateProvider<User?>((ref) {
  return null;
});
