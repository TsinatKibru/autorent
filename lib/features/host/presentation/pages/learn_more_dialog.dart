import 'package:flutter/material.dart';

class LearnMoreDialog extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LearnMoreDialog(),
      );
  const LearnMoreDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.green.shade700, Colors.green.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Image/Icon
            const Icon(Icons.car_rental, size: 60, color: Colors.white),

            const SizedBox(height: 10),

            // Title
            const Text(
              "Turn Your Car into Earnings!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 10),

            // Description
            const Text(
              "Join thousands of car owners earning passive income by hosting their cars. Rent it out when you're not using it and enjoy flexible earnings with full control!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 20),

            // Benefits List
            const Column(
              children: [
                BenefitItem(
                    icon: Icons.attach_money,
                    text: "Earn up to ETB 2500/month"),
                BenefitItem(
                    icon: Icons.security, text: "Fully insured and secure"),
                BenefitItem(
                    icon: Icons.schedule,
                    text: "Total control over availability"),
              ],
            ),

            const SizedBox(height: 20),

            // CTA Button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Navigate to host sign-up page or more details page
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.green.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text(
                "Start Hosting Now",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BenefitItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const BenefitItem({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Function to Show the Dialog
void showLearnMoreDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const LearnMoreDialog(),
  );
}
