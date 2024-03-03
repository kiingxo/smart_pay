import 'package:flutter/material.dart';
import 'package:smart_pay/app/shared/components/base_text.dart';
import 'package:smart_pay/core/core.dart';

import 'onboarding_images_atom.dart';

class OnboardingAtom extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String imageIllustration;

  const OnboardingAtom({
    super.key,
    required this.imagePath,
    required this.subtitle,
    required this.title,
    required this.imageIllustration,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (context, colors, ref) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: Spacings.spacing30),
            OnboardingImagesAtom(
              deviceImage: imagePath,
              illustration: imageIllustration,
            ),
            const SizedBox(height: Spacings.spacing10),
            BaseText(
              title,
              fontSize: TextSizes.size24,
              fontWeight: FontWeight.w600,
              color: colors.always111827,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Spacings.spacing16),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacings.spacing24,
              ),
              child: BaseText(
                subtitle,
                fontSize: TextSizes.size14,
                fontWeight: FontWeight.w400,
                color: colors.always6B7280,
                textHeight: 1.65,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: Spacings.spacing30),
          ],
        );
      },
    );
  }
}
