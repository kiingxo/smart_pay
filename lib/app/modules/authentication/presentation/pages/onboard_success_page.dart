import 'package:flutter/material.dart';
import 'package:smart_pay/app/modules/dashboard/presentation/pages/homepage.dart';

import 'package:smart_pay/app/shared/components/base_text.dart';
import 'package:smart_pay/app/shared/components/custom_button_component.dart';
import 'package:smart_pay/app/shared/constants/images.dart';
import 'package:smart_pay/core/framework/theme/presentation/app_theme_builder.dart';
import 'package:smart_pay/core/framework/theme/sizes/spacings.dart';
import 'package:smart_pay/core/framework/theme/sizes/text_sizes.dart';
import 'package:smart_pay/core/navigation/navigation.dart';

class OnboardSuccessPage extends StatelessWidget {
  const OnboardSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (context, colors, ref) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacings.spacing20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  Images.thumbsUp,
                  width: Spacings.spacing200,
                  height: Spacings.spacing200,
                ),
              ),
              const BaseText(
                "Congratulations",
                fontSize: TextSizes.size28,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: Spacings.spacing20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacings.spacing30,
                ),
                child: BaseText(
                  "You’ve completed the onboarding, you can start using",
                  fontSize: TextSizes.size16,
                  textAlign: TextAlign.center,
                  textHeight: 1.45,
                  letterSpacing: -.2,
                  fontWeight: FontWeight.w500,
                  color: colors.always6B7280,
                ),
              ),
              const SizedBox(height: Spacings.spacing30),
              CustomButtonComponent(
                text: "Get Started",
                onPressed: () => pushToAndClearStack(context, const HomePage()),
              ),
            ],
          ),
        );
      },
    );
  }
}
