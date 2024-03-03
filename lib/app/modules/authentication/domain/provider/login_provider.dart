import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_pay/app/modules/authentication/data/model/login_model.dart';
import 'package:smart_pay/app/modules/authentication/data/model/user_model.dart';
import 'package:smart_pay/app/modules/authentication/domain/service/authentication_service.dart';
import 'package:smart_pay/app/shared/classes/secure/secure_storage.dart';
import 'package:smart_pay/core/framework/base_service/service_response.dart';

final loginProvider = Provider<LoginProvider>((ref) {
  return LoginProvider();
});

class LoginProvider {
  void login({
    required LoginModel model,
    required ValueChanged<ServiceResponse<User>> onDone,
  }) async {
    final operation = await AuthenticationService.login(
      model,
    );
    onDone(operation);
  }

  Future<void> loginWithPin(
    String pin, {
    required ValueChanged<ServiceResponse<User>> onDone,
  }) async {
    final cachedPin = await SecureStorage.retrive(key: SecureStorageKeys.pin);

    if (cachedPin == null) {
      onDone(serveError(error: "Please login with email and password"));
      return;
    }

    final cachedEmail =
        await SecureStorage.retrive(key: SecureStorageKeys.email) ?? "";
    final cachedPassword =
        await SecureStorage.retrive(key: SecureStorageKeys.password) ?? "";

    final model = LoginModel(
      email: cachedEmail,
      password: cachedPassword,
    );

    if (_validatePin(cachedPin: cachedPin, pin: pin)) {
      final operation = await AuthenticationService.login(model);
      onDone(operation);
    } else {
      onDone(serveError(error: "Incorrect pin"));
    }
  }
}

bool _validatePin({required String pin, required String cachedPin}) {
  return cachedPin == pin;
}
