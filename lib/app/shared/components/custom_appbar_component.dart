import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_pay/app/shared/shared.dart';

import 'package:smart_pay/core/core.dart';

import '../../../core/navigation/navigation.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.onLeadingTapped,
    this.hasLeading = false,
    this.backgroundColor,
  });

  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final VoidCallback? onLeadingTapped;
  final bool hasLeading;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      useScaffold: false,
      builder: (context, color, ref) {
        return AppBar(
          backgroundColor: backgroundColor ?? color.lightWhiteDarkBlack,
          centerTitle: true,
          elevation: 0,
          leading: hasLeading
              ? leading
              : (canPop(context) ? const CustomBackButton() : null),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: Spacings.spacing20,
              ),
              child: Row(
                children: [
                  ...?actions,
                ],
              ),
            ),
          ],
          title: title != null
              ? BaseText(
                  title ?? '',
                  fontWeight: FontWeight.w600,
                  fontSize: TextSizes.size14,
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(Spacings.spacing40);
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => pop(context),
      child: Padding(
        padding: const EdgeInsets.only(
          left: Spacings.spacing10,
        ),
        child: SvgPicture.asset(
          Svgs.backButton,
        ),
      ),
    );
  }
}
