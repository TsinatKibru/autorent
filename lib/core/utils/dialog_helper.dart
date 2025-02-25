import 'package:flutter/material.dart';

class DialogHelper {
  static void showErrorDialog({
    required BuildContext context,
    required String message,
    String title = 'Error',
    String okButtonText = 'OK',
    VoidCallback? onOkPressed,
    IconData icon = Icons.error_outline,
    Color iconColor = Colors.red,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 8),
            Text(title, style: TextStyle(color: iconColor)),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: onOkPressed ?? () => Navigator.pop(context),
            child: Text(okButtonText),
          ),
        ],
      ),
    );
  }

  static void showCustomSnackbar({
    required BuildContext context,
    required String message,
    IconData icon = Icons.info, // Default icon
    Duration duration = const Duration(seconds: 4),
    Color backgroundColor = Colors.blue, // Default background color
    double bottomMargin = 80.0, // Default bottom margin
    Color textColor = Colors.white, // Default text color
    double fontSize = 16.0, // Default font size
    double iconSize = 28.0, // Slightly larger icon size
    double borderRadius = 12.0, // Rounded corners
    double elevation = 6.0, // Shadow effect
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: iconSize),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(fontSize: fontSize, color: textColor),
              ),
            ),
          ],
        ),
        duration: duration,
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: bottomMargin,
          left: 16,
          right: 16,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: elevation, // Adding shadow
      ),
    );
  }
}
