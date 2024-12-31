import 'package:car_rent/features/car/presentation/pages/check_out_page.dart';
import 'package:car_rent/features/car/presentation/widgets/car_rent_gradient_button.dart';
import 'package:car_rent/features/car/presentation/widgets/profile_photo_upload_widget.dart';
import 'package:car_rent/features/navigation/presentation/widgets/bottom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';

class DriverLicenseUpload extends StatelessWidget {
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
          Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Text(
                'Driver\'s License',
                style: TextStyle(fontSize: 24, color: Colors.black),
                textAlign: TextAlign.center,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Image.asset(
              'assets/images/thirdprogressbar.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Text
                Text(
                  "Enter License Details",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                const SizedBox(height: 8),
                // Subtitle Text
                Text(
                  "Please enter your information exactly as it appears in your license, so that we can verify your eligibility to drive.",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 242, 239, 239),
                borderRadius: BorderRadius.circular(16),
              ),
              child: _buildInfoSection(
                  Icons.scanner_rounded, "Scan license to autofill", ""),
            ),
          ),
          // Content with Gray Background
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 242, 239, 239),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    _buildTextField("Full Name", "Enter your full name"),
                    const SizedBox(height: 16),
                    _buildTextField("Country", "Enter your country"),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child:
                              _buildTextField("Expiration Date", "MM/DD/YYYY"),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField("Date of Birth", "MM/DD/YYYY"),
                        ),
                      ],
                    ),
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
                  // Proceed to the next step
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckOutPage(),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/scannervector.png',
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
          ),
        ),
      ],
    );
  }
}
