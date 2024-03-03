import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smart_pay/core/core.dart';

StreamController<ErrorAnimationType> errorController =
    StreamController<ErrorAnimationType>.broadcast();

class CustomPinCodeField extends StatefulWidget {
  const CustomPinCodeField({
    super.key,
    this.length = 4,
    this.readOnly = false,
    this.onChanged,
    this.pinController,
    this.mainAxisAlignment,
  });

  final int length;
  final TextEditingController? pinController;
  final MainAxisAlignment? mainAxisAlignment;

  final Function(String)? onChanged;

  final bool readOnly;

  @override
  State<CustomPinCodeField> createState() => _CustomPinCodeFieldState();
}

class _CustomPinCodeFieldState extends State<CustomPinCodeField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      useScaffold: false,
      builder: (context, color, ref) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            PinCodeTextField(
              length: widget.length,
              appContext: context,
              readOnly: widget.readOnly,
              keyboardType: TextInputType.number,
              animationType: AnimationType.fade,
              enableActiveFill: true,
              autoUnfocus: false,
              autoFocus: false,
              cursorColor: color.always111827,
              autoDisposeControllers: false,
              cursorHeight: 25,
              controller: widget.pinController,
              errorAnimationController: errorController,
              animationDuration: const Duration(milliseconds: 300),
              onChanged: (value) {
                errorController.add(ErrorAnimationType.clear);
                HapticFeedback.mediumImpact();
                widget.onChanged?.call(value);
              },
              textStyle: TextStyle(
                fontSize: TextSizes.size24,
                fontWeight: FontWeight.w900,
                fontFamily: "SFPro",
                color: color.always111827,
              ),
              mainAxisAlignment:
                  widget.mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
              pinTheme: PinTheme(
                selectedFillColor: color.alwaysF9FAFB,
                shape: PinCodeFieldShape.box,
                activeColor: Colors.transparent,
                selectedColor: Colors.transparent,
                disabledColor: Colors.transparent,
                inactiveColor: Colors.transparent,
                inactiveFillColor: color.alwaysF9FAFB,
                activeFillColor: color.alwaysF9FAFB,
                borderWidth: 0,
                activeBorderWidth: 0,
                inactiveBorderWidth: 0,
                selectedBorderWidth: 0,
                errorBorderWidth: 0,
                fieldWidth: 55,
                fieldHeight: 55,
                borderRadius: BorderRadius.circular(
                  Spacings.spacing12,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
