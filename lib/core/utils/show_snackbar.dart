// import 'package:flutter/material.dart';

// void showSnackbar(BuildContext context, String content) {
//   ScaffoldMessenger.of(context)
//     ..hideCurrentSnackBar()
//     ..showSnackBar(SnackBar(content: Text(content)));
// }

// import 'package:flutter/material.dart';

// void showSnackbar(BuildContext context, String content) {
//   // Schedule showing the Snackbar after the current frame
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     ScaffoldMessenger.of(context)
//       ..hideCurrentSnackBar()
//       ..showSnackBar(SnackBar(content: Text(content)));
//   });
// }
import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String content) {
  // Determine the icon based on the content or network error condition
  Widget icon = content.toLowerCase().contains("network error") ||
          content.toLowerCase().contains("socketexception")
      ? const Icon(Icons.signal_wifi_off,
          color: Colors.red) // Network error icon
      : const Icon(Icons.info, color: Colors.blue); // Default info icon

  bool networkerror = content.toLowerCase().contains("network error") ||
          content.toLowerCase().contains("socketexception")
      ? true // Network error icon
      : false;

  // Schedule showing the Snackbar after the current frame
  WidgetsBinding.instance.addPostFrameCallback(
    (_) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Row(
              children: [
                icon, // Always non-null icon
                const SizedBox(
                    width: 8), // Add space between the icon and the text
                Expanded(
                    child: networkerror
                        ? const Text(
                            "Network error: Unable to resolve hostname.")
                        : Text(content)),
              ],
            ),
          ),
        );
    },
  );
}
