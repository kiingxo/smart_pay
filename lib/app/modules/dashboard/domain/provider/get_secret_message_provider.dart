import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_pay/app/modules/dashboard/domain/service/dashboard_service.dart';
import 'package:smart_pay/core/framework/base_service/service_response.dart';

final getSecretMessageProvider =
    FutureProvider<ServiceResponse<String>>((ref) async {
  return ref.read(dasboardServiceProvider).getSecretMessage();
});
