import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_pay/app/modules/authentication/presentation/pages/input_email_page.dart';
import 'package:smart_pay/app/modules/onboard/presentation/components/onboarding_component.dart';

import 'package:smart_pay/app/shared/shared.dart';
import 'package:smart_pay/core/core.dart';

import 'package:smart_pay/core/navigation/navigation.dart';

import '../components/atoms/pageview_indicator_atom.dart';

class OnboardPage extends HookConsumerWidget {
  const OnboardPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();

    final index_ = useState(0);

    return ThemeBuilder(
      builder: (context, colors, ref) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacings.spacing20,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () => pushTo(context, const InputEmailPage()),
                    child: BaseText(
                      "Skip",
                      color: colors.always2FA2B9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                OnboardingComponent(
                  onPageChanged: (index) {
                    index_.value = index;
                  },
                  pageController: pageController,
                ),
                PageViewIndicatorsComponent(
                  index: index_.value,
                  count: 2,
                ),
                const SizedBox(height: Spacings.spacing30),
                CustomButtonComponent(
                  buttonWidth: 300,
                  text: "Get Started",
                  onPressed: () => pushTo(context, const InputEmailPage()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
