import 'package:flutter/material.dart';
import 'package:smart_pay/app/shared/shared.dart';
import 'package:smart_pay/core/core.dart';

class CustomButtonComponent extends StatelessWidget {
  final double? buttonHeight;
  final double? buttonWidth;
  final String text;
  final double? fontSize;
  final bool Function()? validator;
  final VoidCallback onPressed;

  const CustomButtonComponent({
    super.key,
    this.buttonHeight,
    this.buttonWidth,
    required this.text,
    this.validator,
    this.fontSize,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      useScaffold: false,
      builder: (context, color, ref) {
        return Container(
          height: buttonHeight ?? Spacings.spacing54,
          width: buttonWidth ?? double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Spacings.spacing16,
            ),
            color: (validator == null ? true : validator!())
                ? color.always111827
                : color.always111827.withOpacity(.5),
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              alignment: Alignment.center,
              padding: MaterialStateProperty.all(
                const EdgeInsets.only(
                  top: Spacings.spacing10,
                  bottom: Spacings.spacing10,
                ),
              ),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Spacings.spacing16),
                ),
              ),
            ),
            onPressed:
                (validator == null ? true : validator!()) ? onPressed : null,
            child: BaseText(
              text,
              fontSize: fontSize ?? TextSizes.size16,
              fontWeight: FontWeight.w600,
              color: color.alwaysLight,
            ),
          ),
        );
      },
    );
  }
}
