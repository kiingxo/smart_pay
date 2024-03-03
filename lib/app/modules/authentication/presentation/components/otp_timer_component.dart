import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_pay/app/shared/shared.dart';
import 'package:smart_pay/core/core.dart';

class YesPage extends ConsumerStatefulWidget {
  const YesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _YesPageState();
}

class _YesPageState extends ConsumerState<YesPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class OtpTimerComponent extends StatefulWidget {
  final String email;
  final VoidCallback? onNewCodeSent;

  const OtpTimerComponent({
    super.key,
    required this.email,
    this.onNewCodeSent,
  });
  @override
  State<OtpTimerComponent> createState() => _OtpTimerComponentState();
}

class _OtpTimerComponentState extends State<OtpTimerComponent> {
  int secondsRemaining = 30;
  int coolDownRemaining = 35;
  int timesClicked = 0;
  Timer? _timer;
  Timer? _coolDownTimer;
  bool enableResend = true;

  @override
  void dispose() {
    _timer?.cancel();
    _coolDownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      useScaffold: false,
      builder: (context, color, ref) {
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: enableResend ? _resendCode : null,
                child: BaseText(
                  "Resend your code",
                  letterSpacing: -.2,
                  fontSize: TextSizes.size16,
                  color: color.always727272,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (!enableResend)
                BaseText(
                  ' in $secondsRemaining'
                  ' secs',
                  letterSpacing: -.2,
                  fontSize: TextSizes.size16,
                  color: color.always727272,
                  fontWeight: FontWeight.w600,
                ),
            ],
          ),
        );
      },
    );
  }

  void _resendCode() {
    setState(() {
      timesClicked++;
      enableResend = false;
      if (_coolDownTimer != null && timesClicked > 1) {
        secondsRemaining = 30 + (5 * (timesClicked - 1));
        coolDownRemaining = 35 + (5 * timesClicked - 1);
      } else {
        secondsRemaining = 30;
      }

      widget.onNewCodeSent!();
    });

    _timer ??= Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        secondsRemaining--;
        if (secondsRemaining <= 0) {
          _timer?.cancel();
          _timer = null;
          enableResend = true;
        }
      });
    });

    _coolDownTimer ??=
        Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        coolDownRemaining--;
        if (coolDownRemaining == 0) {
          _coolDownTimer?.cancel();
          _coolDownTimer = null;
          timesClicked = 0;
        }
      });
    });
  }
}
