import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_pay/app/modules/authentication/data/model/verify_email_model.dart';
import 'package:smart_pay/app/modules/authentication/domain/provider/get_email_token_provider.dart';
import 'package:smart_pay/app/modules/authentication/presentation/components/otp_timer_component.dart';
import 'package:smart_pay/app/modules/authentication/presentation/pages/register_page.dart';
import 'package:smart_pay/app/shared/shared.dart';
import 'package:smart_pay/core/core.dart';
import 'package:smart_pay/core/navigation/navigation.dart';

import '../../domain/provider/verify_email_token_provider.dart';

class EmailVerificationPage extends HookConsumerWidget {
  final String token;
  final String email;
  const EmailVerificationPage({
    super.key,
    required this.token,
    required this.email,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final code_ = useState("");

    return ThemeBuilder(
      appBar: const CustomAppBar(),
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
                  'Verify it’s you',
                  color: colors.always111827,
                  fontSize: TextSizes.size24,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                ),
                const SizedBox(height: Spacings.spacing10),
                BaseText(
                  "We send a code to (${email.maskHalfString()}) Enter it here to verify your identity",
                  fontSize: TextSizes.size16,
                  textHeight: 1.45,
                  letterSpacing: -.2,
                  fontWeight: FontWeight.w500,
                  color: colors.always6B7280,
                ),
                const SizedBox(height: Spacings.spacing30),
                CustomPinCodeField(
                  length: 5,
                  onChanged: (code) {
                    code_.value = code;
                  },
                ),
                const SizedBox(height: Spacings.spacing30),
                OtpTimerComponent(
                  email: email,
                  onNewCodeSent: () {
                    final p = ref.read(getEmailTokenProvider);
                    p.getToken(
                      email,
                      onDone: (state) {
                        if (state.error) return;
                        context.showSuccess("Code resent! ${state.data}");

                        code_.value = state.data ?? "";
                      },
                    );
                  },
                ),
                const SizedBox(height: Spacings.spacing50),
                CustomButtonComponent(
                  text: "Confirm",
                  validator: () {
                    return code_.value.isNotEmpty && code_.value.length == 5;
                  },
                  onPressed: () {
                    showLoader(context);
                    final p = ref.read(verifyEmailTokenProvider);
                    p.verifyToken(
                      VerifyEmailModel(email: email, token: code_.value),
                      onDone: (state) {
                        pop(context);
                        if (state.error) {
                          context.showError(state.message);
                          return;
                        }
                        context.showSuccess("Successfully verified!");
                        pushTo(context, const RegisterPage());
                      },
                    );
                  },
                ),
                const SizedBox(height: Spacings.spacing20),
                BaseText(
                  "Since coding assessment purpose ($token), Enter that token as code to validate.",
                  fontSize: TextSizes.size14,
                  textHeight: 1.45,
                  letterSpacing: -.2,
                  fontWeight: FontWeight.w500,
                  color: colors.always6B7280,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
