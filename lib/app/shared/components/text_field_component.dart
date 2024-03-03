import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_pay/core/core.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool? readOnly;
  final TextEditingController? textEditingController;
  final bool? obscureText;
  final Widget? prefix;
  final Widget? suffix;
  final FocusNode? node;
  final VoidCallback? onTap;
  final String? Function(String value)? validator;
  final EdgeInsets? padding;
  final int? maxLines;
  final int? maxLength;
  final Color? textFieldColor;
  final bool? hasBorder;
  final String? headerText;
  final TextInputAction textInputAction;

  const CustomTextField({
    super.key,
    required this.hint,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
    this.readOnly,
    this.obscureText,
    this.textEditingController,
    this.prefix,
    this.suffix,
    this.node,
    this.validator,
    this.onTap,
    this.padding,
    this.maxLines = 1,
    this.maxLength,
    this.headerText,
    this.textFieldColor,
    this.textInputAction = TextInputAction.next,
    this.hasBorder = true,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final FocusNode node;
  @override
  void initState() {
    node = widget.node ?? FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
        useScaffold: false,
        builder: (context, color, ref) {
          return GestureDetector(
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap!();
              }
              node.requestFocus();
            },
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.headerText != null) ...[
                    Text(widget.headerText!),
                    const SizedBox(height: 10),
                  ],
                  Container(
                    padding: widget.padding ??
                        const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 20,
                          top: 20,
                        ),
                    decoration: BoxDecoration(
                      color: widget.textFieldColor ?? color.alwaysF9FAFB,
                      borderRadius: BorderRadius.circular(
                        Spacings.spacing16,
                      ),
                    ),
                    child: Row(
                      children: [
                        widget.prefix ?? const SizedBox(),
                        Expanded(
                          child: TextField(
                            maxLines: widget.maxLines,
                            maxLength: widget.maxLength,
                            focusNode: node,
                            minLines: 1,
                            cursorColor: color.always111827,
                            keyboardType: widget.keyboardType,
                            onChanged: (v) {
                              v = v.trim();
                              widget.onChanged?.call(v);
                              setState(() {
                                value = v;
                              });
                            },
                            obscureText: widget.obscureText ?? false,
                            controller: widget.textEditingController,
                            readOnly: widget.readOnly ?? false,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: color.always111827,
                            ),
                            inputFormatters: widget.inputFormatters,
                            decoration: InputDecoration.collapsed(
                              hintText: widget.hint,
                              hintStyle: TextStyle(
                                color: color.always9CA3AF,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            textInputAction: widget.textInputAction,
                          ),
                        ),
                        widget.suffix ?? const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  String value = "";

  bool get isValid {
    if (widget.validator == null || value.isEmpty) {
      return true;
    }
    return widget.validator!(value) == null;
  }
}
