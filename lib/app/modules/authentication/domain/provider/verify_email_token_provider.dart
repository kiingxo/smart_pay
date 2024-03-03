import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_pay/app/modules/authentication/data/model/verify_email_model.dart';

import '../../../../../core/framework/base_service/service_response.dart';
import '../service/authentication_service.dart';

final verifyEmailTokenProvider = Provider<VerifyEmailTokenProvider>((ref) {
  return VerifyEmailTokenProvider();
});

class VerifyEmailTokenProvider {
  void verifyToken(
    VerifyEmailModel model, {
    required ValueChanged<ServiceResponse<void>> onDone,
  }) async {
    final s = await AuthenticationService.verifyEmailToken(model);
    onDone(s);
  }
}
