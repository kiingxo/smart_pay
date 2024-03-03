import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_pay/app/modules/authentication/data/model/register_model.dart';
import 'package:smart_pay/app/modules/authentication/data/model/user_model.dart';
import 'package:smart_pay/app/modules/authentication/domain/service/authentication_service.dart';
import 'package:smart_pay/core/framework/base_service/service_response.dart';

final registerProvider = Provider<RegisterProvider>((ref) {
  return RegisterProvider();
});

class RegisterProvider {
  void register(
    RegisterModel model, {
    required ValueChanged<ServiceResponse<User>> onDone,
  }) async {
    final s = await AuthenticationService.register(model);
    onDone(s);
  }
}
