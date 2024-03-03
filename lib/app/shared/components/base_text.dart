import 'package:flutter/material.dart';
import 'package:smart_pay/core/core.dart';

class BaseText extends StatelessWidget {
  final String text;
  final double? fontSize;
  // FONT WEIGHT, TEXT SIZE,
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final double textHeight;
  final double? letterSpacing;
  final FontStyle? fontStyle;
  const BaseText(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.textHeight = 0,
    this.letterSpacing,
    this.fontStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      useScaffold: false,
      builder: (context, colors, ref) {
        return Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: fontSize ?? TextSizes.size14,
            fontFamily: "SFPro",
            height: textHeight,
            fontStyle: fontStyle,
            fontWeight: fontWeight ?? FontWeight.w400,
            letterSpacing: letterSpacing,
            color: color ?? colors.lightBlackDarkWhite,
          ),
        );
      },
    );
  }
}
