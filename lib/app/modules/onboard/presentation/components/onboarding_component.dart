import 'package:flutter/material.dart';
import 'package:smart_pay/app/modules/onboard/presentation/components/atoms/onboarding_atom.dart';
import 'package:smart_pay/app/shared/constants/images.dart';

class OnboardingComponent extends StatelessWidget {
  final PageController pageController;
  final ValueChanged<int> onPageChanged;
  const OnboardingComponent({
    super.key,
    required this.onPageChanged,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final onboardItems = <({
      String imagePath,
      String title,
      String subTitle,
      String illustration,
    })>[
      (
        title: "Finance app the safest and most trusted",
        subTitle:
            "Your finance work starts here. Our here to help you track and deal with speeding up your transactions.",
        imagePath: Images.onboard1,
        illustration: Images.illustration1,
      ),
      (
        title: "The fastest transaction process only here",
        subTitle:
            "Get easy to pay all your bills with just a few steps. Paying your bills become fast and efficient.",
        imagePath: Images.onboard2,
        illustration: Images.illustration2
      ),
    ];

    return Expanded(
      child: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          for (final item in onboardItems)
            OnboardingAtom(
              imagePath: item.imagePath,
              subtitle: item.subTitle,
              title: item.title,
              imageIllustration: item.illustration,
            )
        ],
      ),
    );
  }
}
