import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_pay/app/modules/onboard/presentation/pages/onboard_page.dart';
import 'package:smart_pay/app/shared/shared.dart';

import 'package:smart_pay/core/core.dart';

import 'package:smart_pay/core/navigation/navigation.dart';

import '../../../authentication/presentation/pages/login_with_pin_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(
      const Duration(milliseconds: 1500),
      () async {
        final pin = await SecureStorage.retrive(key: SecureStorageKeys.pin);

        if (pin == null) {
          if (!context.mounted) return;

          pushToAndClearStack(context, const OnboardPage());

          //
        } else {
          if (!context.mounted) return;
          pushToAndClearStack(context, const LoginWithPinPage());
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (context, colors, ref) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(Svgs.logo),
              const SizedBox(height: Spacings.spacing10),
              SvgPicture.asset(Svgs.smartPayText),
            ],
          ),
        );
      },
    );
  }
}
