import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_pay/app/modules/authentication/domain/service/authentication_service.dart';
import 'package:smart_pay/core/framework/base_service/service_response.dart';

final logoutProvider = Provider<LogoutProvider>((ref) {
  return LogoutProvider();
});

class LogoutProvider {
  void logout({
    required ValueChanged<ServiceResponse<void>> onDone,
  }) async {
    final s = await AuthenticationService.logout();
    onDone(s);
  }
}
