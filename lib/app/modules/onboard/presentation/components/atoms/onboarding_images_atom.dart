import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_pay/core/core.dart';

class OnboardingImagesAtom extends StatelessWidget {
  final String deviceImage;
  final String illustration;
  const OnboardingImagesAtom({
    super.key,
    required this.deviceImage,
    required this.illustration,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Positioned(
              top: Spacings.spacing10,
              left: Spacings.spacing40,
              right: Spacings.spacing40,
              child: SizedBox(
                child: Center(
                  child: Image.asset(
                    deviceImage,
                  ),
                ),
              ),
            ),
            Positioned(
              top: Spacings.spacing40,
              child: SizedBox(
                child: SvgPicture.asset(
                  illustration,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
