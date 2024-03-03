import 'package:flutter/material.dart';
import 'package:smart_pay/core/core.dart';

class PageViewIndicatorsComponent extends StatelessWidget {
  final int _index;
  final int count;
  final MainAxisAlignment? mainAxisAlignment;

  const PageViewIndicatorsComponent({
    super.key,
    required int index,
    required this.count,
    this.mainAxisAlignment,
  }) : _index = index;

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      useScaffold: false,
      builder: (context, colors, ref) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            count,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              width: index == _index ? Spacings.spacing30 : Spacings.spacing8,
              height: Spacings.spacing8,
              margin: const EdgeInsets.symmetric(horizontal: 1.5),
              decoration: BoxDecoration(
                color:
                    index == _index ? colors.always111827 : colors.alwaysE5E7EB,
                borderRadius: BorderRadius.circular(
                  Spacings.spacing30,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
