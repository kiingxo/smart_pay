import 'package:flutter/material.dart';

extension SnackbarExtension on BuildContext {
  void _showSnackBar(
    String message, {
    Color? color,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        backgroundColor: color,
      ),
    );
  }

  void showError(String message) {
    _showSnackBar(
      message,
      color: const Color(0xFFCC2929),
    );
  }

  void showSuccess(String message) {
    _showSnackBar(
      message,
      color: const Color(0xFF276E59),
    );
  }
}
