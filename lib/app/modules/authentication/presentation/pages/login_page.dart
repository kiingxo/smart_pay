import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_pay/app/modules/authentication/data/model/login_model.dart';
import 'package:smart_pay/app/modules/authentication/data/model/user_model.dart';
import 'package:smart_pay/app/modules/authentication/domain/provider/login_provider.dart';
import 'package:smart_pay/app/modules/dashboard/presentation/pages/homepage.dart';

import 'package:smart_pay/app/shared/shared.dart';

import 'package:smart_pay/core/core.dart';
import 'package:smart_pay/core/navigation/navigation.dart';

import '../../domain/service/authentication_service.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useState("");
    final password = useState("");

    final passwordVisible = useState(false);

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
                  'Hi There! 👋',
                  color: colors.always111827,
                  fontSize: TextSizes.size24,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                ),
                const SizedBox(height: Spacings.spacing10),
                BaseText(
                  "Welcome back, Sign in to your account",
                  fontSize: TextSizes.size16,
                  textHeight: 1.45,
                  letterSpacing: -.2,
                  fontWeight: FontWeight.w500,
                  color: colors.always6B7280,
                ),
                const SizedBox(height: Spacings.spacing30),
                CustomTextField(
                  hint: "Email",
                  onChanged: (v) {
                    email.value = v.trim();
                  },
                ),
                const SizedBox(height: Spacings.spacing14),
                CustomTextField(
                  hint: "Password",
                  obscureText: passwordVisible.value,
                  onChanged: (v) {
                    password.value = v.trim();
                  },
                  suffix: GestureDetector(
                    onTap: () => passwordVisible.value = !passwordVisible.value,
                    child: Icon(
                      passwordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                const SizedBox(height: Spacings.spacing30),
                CustomButtonComponent(
                  text: "Continue",
                  validator: () {
                    return email.value.isValidEmail() &&
                        password.value.isNotEmpty;
                  },
                  onPressed: () {
                    showLoader(context);
                    final p = ref.read(loginProvider);
                    p.login(
                      model: LoginModel(
                        email: email.value,
                        password: password.value,
                      ),
                      onDone: (state) {
                        pop(context);
                        if (state.error) {
                          context.showError(state.message);
                          return;
                        }
                        _updateUser(state.data!, ref);

                        pushToAndClearStack(context, const HomePage());
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void _updateUser(User user, WidgetRef ref) {
  ref.read(userProvider.notifier).state = user;
}
