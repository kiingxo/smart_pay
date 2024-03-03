import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_pay/app/modules/authentication/domain/provider/logout_provider.dart';
import 'package:smart_pay/app/modules/authentication/domain/service/authentication_service.dart';

import 'package:smart_pay/app/modules/authentication/presentation/pages/login_with_pin_page.dart';
import 'package:smart_pay/app/modules/dashboard/domain/provider/get_secret_message_provider.dart';
import 'package:smart_pay/app/shared/shared.dart';
import 'package:smart_pay/core/core.dart';
import 'package:smart_pay/core/navigation/navigation.dart';

import '../components/error_ui_component.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getSecretMessage = ref.watch(getSecretMessageProvider);

    final user = ref.watch(userProvider);

    return ThemeBuilder(
      builder: (context, color, ref) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacings.spacing20,
            ),
            child: Column(
              children: [
                const SizedBox(height: Spacings.spacing10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BaseText(
                      "Hello ${user?.fullName}",
                      letterSpacing: -.2,
                      fontSize: TextSizes.size16,
                      color: color.always727272,
                    ),
                    TextButton(
                      onPressed: () {
                        showLoader(context);
                        final k = ref.read(logoutProvider);
                        k.logout(
                          onDone: (state) {
                            pop(context);
                            if (state.error) {
                              context.showError(state.message);
                              return;
                            }
                            ref.invalidate(getSecretMessageProvider);
                            pushToAndClearStack(
                                context, const LoginWithPinPage());
                          },
                        );
                      },
                      child: const BaseText(
                        "Logout",
                        color: Color(0xFFCC2929),
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: Spacings.spacing30),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Here\'s today\'s',
                        style: TextStyle(
                          color: color.always111827,
                          fontSize: TextSizes.size24,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -1,
                        ),
                      ),
                      TextSpan(
                        text: ' Secret message',
                        style: TextStyle(
                          color: color.always0A6375,
                          fontSize: TextSizes.size24,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -1,
                        ),
                      ),
                      TextSpan(
                        text: ' just for you',
                        style: TextStyle(
                          height: 1.5,
                          color: color.always111827,
                          fontSize: TextSizes.size24,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -1,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: Spacings.spacing50),
                getSecretMessage.when(
                  data: (response) {
                    if (response.error) {
                      return ErrorUIComponent(error: response.message);
                    }
                    final secret_ = response.data;
                    return BaseText(
                      "\"$secret_\"",
                      fontStyle: FontStyle.italic,
                      fontSize: TextSizes.size16,
                      textHeight: 1.5,
                      color: color.always111827,
                    );
                  },
                  error: (error, stack) {
                    return ErrorUIComponent(error: "$error");
                  },
                  loading: loading,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
