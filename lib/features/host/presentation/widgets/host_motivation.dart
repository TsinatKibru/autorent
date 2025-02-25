import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/features/host/presentation/pages/learn_more_dialog.dart';
import 'package:flutter/material.dart';

class HostMotivation extends StatelessWidget {
  const HostMotivation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color.fromARGB(255, 234, 251, 234),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const Text(
                  "Earn up to \$20,000 extra!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                // Subtitle
                const Text(
                  "Add more cars to your portfolio and before Dec 31, 2023, to earn extra.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                // Learn More Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, LearnMoreDialog.route());
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: AppPalette.primaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Learn More",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Tesla Image
            Positioned(
              bottom: 5,
              right: 5,
              child: Image.asset(
                'assets/images/vectorcar.png',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
