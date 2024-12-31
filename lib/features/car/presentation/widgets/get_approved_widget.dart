import 'package:car_rent/features/car/presentation/widgets/car_rent_gradient_button.dart';
import 'package:car_rent/features/car/presentation/widgets/profile_photo_upload_widget.dart';
import 'package:flutter/material.dart';

class GetApprovedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          // Close Button
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Text
                Text(
                  "Get Approved to Drive",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                const SizedBox(height: 8),
                // Subtitle Text
                Text(
                  "Since this is your first time, you will need to provide us with some information before you can check out.",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          // Content with Green Background
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                color: const Color.fromARGB(255, 236, 252, 236),
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    _buildInfoSection(Icons.person, "Profile Photo",
                        "Upload a clear photo of yourself to complete the profile."),
                    const SizedBox(height: 16),
                    const Divider(
                      thickness: 0.5,
                      color: Colors.black12,
                    ),
                    _buildInfoSection(Icons.phone, "Phone Number",
                        "Provide a valid phone number for verification."),
                    const SizedBox(height: 16),
                    const Divider(
                      thickness: 0.5,
                      color: Colors.black12,
                    ),
                    _buildInfoSection(Icons.card_membership, "Driver License",
                        "Upload a picture of your valid driver's license."),
                    const SizedBox(height: 16),
                    const Divider(
                      thickness: 0.5,
                      color: Colors.black12,
                    ),
                    _buildInfoSection(Icons.payment, "Payment Method",
                        "Add your preferred payment method for payouts."),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CarRentGradientButton(
                buttonText: "Continue",
                onPressed: () {
                  // Proceed to payment logic
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePhotoUploadWidget(),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget _buildInfoSection(IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 40, color: Colors.green),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
