import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  void showSnackBar({required String message, bool error = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: error ? Colors.red : Colors.green,
      ),
    );
  }
}
