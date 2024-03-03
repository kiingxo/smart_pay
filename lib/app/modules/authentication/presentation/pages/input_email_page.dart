import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_pay/app/modules/authentication/presentation/components/already_have_an_account_component.dart';

import 'package:smart_pay/app/shared/shared.dart';

import 'package:smart_pay/core/core.dart';
import 'package:smart_pay/core/navigation/navigation.dart';

import '../../domain/provider/get_email_token_provider.dart';
import 'email_verification_page.dart';

class SomethingPage extends StatefulWidget {
  const SomethingPage({super.key});

  @override
  State<SomethingPage> createState() => _SomethingPageState();
}

class _SomethingPageState extends State<SomethingPage> {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> some_ = ValueNotifier<int>(0);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          some_.value++;
        },
      ),
      body: Center(
        child: ValueListenableBuilder<int>(
          valueListenable: some_,
          builder: (context, value, child) {
            return Text(
              "$value",
              style: const TextStyle(
                fontSize: 50,
              ),
            );
          },
        ),
      ),
    );
  }
}

class InputEmailPage extends HookConsumerWidget {
  const InputEmailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useState("");

    return ThemeBuilder(
      appBar: const CustomAppBar(),
      builder: (context, colors, ref) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacings.spacing20,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: Spacings.spacing30),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Create a',
                          style: TextStyle(
                            color: colors.always111827,
                            fontSize: TextSizes.size24,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -1,
                          ),
                        ),
                        TextSpan(
                          text: ' Smartpay\n',
                          style: TextStyle(
                            color: colors.always0A6375,
                            fontSize: TextSizes.size24,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -1,
                          ),
                        ),
                        TextSpan(
                          text: 'account',
                          style: TextStyle(
                            height: 1.5,
                            color: colors.always111827,
                            fontSize: TextSizes.size24,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -1,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: Spacings.spacing30),
                  CustomTextField(
                    hint: "Email",
                    onChanged: (v) {
                      email.value = v;
                    },
                  ),
                  const SizedBox(height: Spacings.spacing30),
                  CustomButtonComponent(
                    text: "Sign Up",
                    validator: () {
                      return email.value.isValidEmail();
                    },
                    onPressed: () {
                      showLoader(context);
                      final p = ref.read(getEmailTokenProvider);
                      p.getToken(
                        email.value,
                        onDone: (state) {
                          pop(context);
                          if (state.error) {
                            context.showError(state.message);
                            return;
                          }
                          pushTo(
                            context,
                            EmailVerificationPage(
                              token: state.data ?? "",
                              email: email.value,
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: Spacings.spacing100),
                  const AlreadyHaveAnAccountComponent(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
