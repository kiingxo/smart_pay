import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_pay/core/core.dart';

void showLoader(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => const CircularProgressIndicator.adaptive(),
  );
}

Center loading() {
  return Center(
    child: SizedBox(
      height: Spacings.spacing20,
      width: Spacings.spacing20,
      child: (Platform.isIOS)
          ? const CircularProgressIndicator.adaptive()
          : const CircularProgressIndicator(
              strokeWidth: 2.0,
              color: Color(0xFF4168F6),
            ),
    ),
  );
}
