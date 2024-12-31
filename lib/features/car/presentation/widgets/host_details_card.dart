import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class HostDetails extends StatelessWidget {
  const HostDetails({Key? key}) : super(key: key);

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
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/images/host.jpeg'),
                ),
                const SizedBox(width: 12.0),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "John Doe",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      Text(
                        "Los Angeles, CA",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.phone,
                          color: AppPalette.primaryColor),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.message_rounded,
                          color: AppPalette.primaryColor),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.star, color: AppPalette.primaryColor, size: 20),
                SizedBox(width: 4.0),
                Text(
                  "5.00",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    "Typically responds in 15 minutes",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
