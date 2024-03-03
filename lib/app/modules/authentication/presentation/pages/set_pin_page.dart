import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_pay/app/modules/authentication/presentation/pages/onboard_success_page.dart';
import 'package:smart_pay/app/shared/shared.dart';
import 'package:smart_pay/core/core.dart';
import 'package:smart_pay/core/navigation/navigation.dart';

class SetPinPage extends HookConsumerWidget {
  const SetPinPage({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pin = useState("");

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
                  'Set your PIN code',
                  color: colors.always111827,
                  fontSize: TextSizes.size24,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                ),
                const SizedBox(height: Spacings.spacing10),
                BaseText(
                  "We use state-of-the-art security measures to protect your information at all times",
                  fontSize: TextSizes.size16,
                  textHeight: 1.45,
                  letterSpacing: -.2,
                  fontWeight: FontWeight.w500,
                  color: colors.always6B7280,
                ),
                const SizedBox(height: Spacings.spacing30),
                CustomPinCodeField(
                  length: 4,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  onChanged: (code) {
                    pin.value = code;
                  },
                ),
                const SizedBox(height: Spacings.spacing50),
                CustomButtonComponent(
                  text: "Create Pin",
                  validator: () {
                    return pin.value.isNotEmpty && pin.value.length == 4;
                  },
                  onPressed: () async {
                    await SecureStorage.write(
                        key: SecureStorageKeys.pin, value: pin.value);
                    if (!context.mounted) return;
                    pushToAndClearStack(context, const OnboardSuccessPage());
                  },
                ),
                const SizedBox(height: Spacings.spacing20),
              ],
            ),
          ),
        );
      },
    );
  }
}
