import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_pay/app/shared/shared.dart';
import 'package:smart_pay/core/core.dart';

class KeypadComponent extends StatelessWidget {
  final Function(String) onPressed;

  const KeypadComponent({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      useScaffold: false,
      builder: (context, colors, ref) {
        return Column(
          children: [
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              padding: const EdgeInsets.all(8.0),
              shrinkWrap: true,
              children: List.generate(
                9,
                (index) {
                  final number = (index + 1).toString();
                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      onPressed(number);
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Center(
                        child: BaseText(
                          number,
                          fontSize: TextSizes.size28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -.2,
                          color: colors.always111827,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            GridView.count(
              crossAxisCount: 3,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: 8,
              ),
              shrinkWrap: true,
              children: [
                const SizedBox.shrink(),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onPressed("0");
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Center(
                      child: BaseText(
                        "0",
                        fontSize: TextSizes.size28,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -.2,
                        color: colors.always111827,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onPressed("X");
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Icon(
                      Icons.backspace_outlined,
                      size: 28,
                      color: colors.always111827,
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
