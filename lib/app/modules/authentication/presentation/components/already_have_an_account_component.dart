import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_pay/app/modules/authentication/presentation/pages/login_page.dart';
import 'package:smart_pay/core/core.dart';

import '../../../../../core/navigation/navigation.dart';

class AlreadyHaveAnAccountComponent extends StatelessWidget {
  const AlreadyHaveAnAccountComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      useScaffold: false,
      builder: (context, color, ref) {
        return Center(
          child: Text.rich(
            TextSpan(
              text: 'Already have an account?',
              style: TextStyle(
                fontSize: TextSizes.size16,
                height: 1.45,
                letterSpacing: -.2,
                fontWeight: FontWeight.w500,
                color: color.always6B7280,
              ),
              children: [
                TextSpan(
                  text: ' Sign in',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => pushTo(context, const LoginPage()),
                  style: TextStyle(
                    fontSize: TextSizes.size16,
                    height: 1.45,
                    letterSpacing: -.2,
                    fontWeight: FontWeight.w700,
                    color: color.always0A6375,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
