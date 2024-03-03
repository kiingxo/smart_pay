import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_pay/app/modules/authentication/domain/provider/login_provider.dart';
import 'package:smart_pay/app/modules/authentication/presentation/pages/login_page.dart';
import 'package:smart_pay/app/modules/dashboard/presentation/pages/homepage.dart';
import 'package:smart_pay/app/shared/components/keypad_component.dart';
import 'package:smart_pay/app/shared/shared.dart';
import 'package:smart_pay/core/core.dart';
import 'package:smart_pay/core/navigation/navigation.dart';

import '../../data/model/user_model.dart';
import '../../domain/service/authentication_service.dart';

class LoginWithPinPage extends StatefulWidget {
  const LoginWithPinPage({super.key});

  @override
  State<LoginWithPinPage> createState() => _LoginWithPinPageState();
}

class _LoginWithPinPageState extends State<LoginWithPinPage> {
  late TextEditingController pinController;

  int pin_ = 0;

  @override
  void initState() {
    pinController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (context, colors, ref) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacings.spacing20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: Spacings.spacing30),
                BaseText(
                  'Welcome back',
                  color: colors.always111827,
                  fontSize: TextSizes.size24,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                ),
                const SizedBox(height: Spacings.spacing10),
                BaseText(
                  "Enter your pin code to jump right back in.",
                  fontSize: TextSizes.size16,
                  textHeight: 1.45,
                  letterSpacing: -.2,
                  fontWeight: FontWeight.w500,
                  color: colors.always6B7280,
                ),
                const SizedBox(height: Spacings.spacing30),
                GestureDetector(
                  onTap: () => pushTo(context, const LoginPage()),
                  child: BaseText(
                    "Use email and password to login?",
                    letterSpacing: -.2,
                    fontSize: TextSizes.size14,
                    color: colors.always0A6375,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: Spacings.spacing30),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacings.spacing10,
                  ),
                  child: CustomPinCodeField(
                    length: 4,
                    readOnly: true,
                    pinController: pinController,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    onChanged: (code) {
                      if (code.length == 4) {
                        showLoader(context);
                        final p = ref.read(loginProvider);
                        p.loginWithPin(
                          "$pin_",
                          onDone: (state) {
                            pop(context);
                            if (state.error) {
                              context.showError(state.message);
                              return;
                            }
                            _updateUser(state.data!, ref);
                            context.showSuccess("Success login");
                            pushToAndClearStack(context, const HomePage());
                          },
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: Spacings.spacing20),
                Expanded(
                  child: KeypadComponent(
                    onPressed: (v) {
                      _handleButtonTap(v);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleButtonTap(dynamic value) {
    if (value != '' && value != 'X') {
      String newPin = pin_.toString() + value.toString();

      if (newPin.length <= 4) {
        pin_ = int.parse(newPin);
      }
    } else if (value == 'X') {
      if (pin_ > 0) {
        pin_ = pin_ ~/ 10;
      }
    }

    if (pin_ == 0) {
      pinController.text = "";
      setState(() {});
      return;
    }
    pinController.text = pin_.toString();
    setState(() {});
  }
}

void _updateUser(User user, WidgetRef ref) {
  ref.read(userProvider.notifier).state = user;
}
