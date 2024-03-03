import 'package:flutter/material.dart';
import 'package:smart_pay/app/shared/shared.dart';

import '../../../../../core/framework/base_service/service_response.dart';

class ErrorUIComponent extends StatelessWidget {
  final String error;
  const ErrorUIComponent({
    super.key,
    this.error = defaultError,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.error,
          color: Color(0xFFCC2929),
        ),
        BaseText(
          error,
          color: const Color(0xFFCC2929),
          fontWeight: FontWeight.w600,
        )
      ],
    );
  }
}
