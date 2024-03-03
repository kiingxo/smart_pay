import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_pay/core/framework/theme/color/app_colors.dart';
import 'package:smart_pay/core/framework/theme/color/app_theme.dart';
import 'package:smart_pay/core/framework/theme/provider/app_theme_provider.dart';

class ThemeBuilder extends HookConsumerWidget {
  final Widget Function(
    BuildContext context,
    AppColors colors,
    WidgetRef ref,
  ) builder;

  final bool useScaffold;
  final Widget? child;
  final PreferredSizeWidget? appBar;
  const ThemeBuilder({
    super.key,
    this.useScaffold = true,
    required this.builder,
    this.child,
    this.appBar,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppTheme appTheme = ref.watch<AppTheme>(appThemeProvider);

    AppColors appColors = appTheme.colors;

    Widget child = builder(context, appColors, ref);

    return useScaffold
        ? Scaffold(
            backgroundColor: appColors.lightWhiteDarkBlack,
            body: child,
            appBar: appBar,
          )
        : child;
  }
}
