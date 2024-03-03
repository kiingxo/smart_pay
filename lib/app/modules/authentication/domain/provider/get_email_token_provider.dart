import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_pay/app/modules/authentication/domain/service/authentication_service.dart';
import 'package:smart_pay/core/framework/base_service/service_response.dart';

final getEmailTokenProvider = Provider<GetEmailTokenProvider>((ref) {
  return GetEmailTokenProvider();
});

class GetEmailTokenProvider {
  void getToken(
    String email, {
    required ValueChanged<ServiceResponse<String>> onDone,
  }) async {
    final s = await AuthenticationService.getEmailToken(email);
    onDone(s);
  }
}
