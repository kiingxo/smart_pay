import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_pay/app/shared/classes/HTTP/http.dart';
import 'package:smart_pay/app/shared/extensions/http_extension.dart';
import 'package:smart_pay/core/framework/base_service/service_response.dart';

final dasboardServiceProvider = Provider<DashboardService>((ref) {
  return DashboardService();
});

class DashboardService {
  Future<ServiceResponse<String>> getSecretMessage() {
    return serveFuture<String>(
      function: (fail) async {
        final r = await HTTP.get("dashboard", body: {});
        if (r.is200or201) {
          final body = jsonDecode(r.body);
          return body['data']['secret'];
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
