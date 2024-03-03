import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_pay/core/framework/theme/color/app_theme.dart';

final appThemeProvider =
    NotifierProvider<AppThemeNotifer, AppTheme>(AppThemeNotifer.new);

class AppThemeNotifer extends Notifier<AppTheme> {
  @override
  AppTheme build() {
    return AppTheme.light();
  }

  void setDarkMode() {}
}
