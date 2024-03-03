import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_pay/app/modules/onboard/presentation/pages/splash_page.dart';
import 'package:smart_pay/core/framework/setups/setups.dart';

void main() {
  Setups.init();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Pay',
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return _Unfocus(
          child: child!,
        );
      },
      scrollBehavior: const CupertinoScrollBehavior(),
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: "SFPro",
      ),
      home: const SplashPage(),
    );
  }
}

// REMOVES FOCUS ALL THROUGH APP
class _Unfocus extends StatelessWidget {
  const _Unfocus({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );
  }
}

// 