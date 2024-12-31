import 'package:car_rent/features/car/presentation/widgets/driver_license_upload.dart';
import 'package:flutter/material.dart';
import 'package:car_rent/features/car/presentation/widgets/car_rent_gradient_button.dart';

class MobileNumberInputWidget extends StatefulWidget {
  @override
  _MobileNumberInputWidgetState createState() =>
      _MobileNumberInputWidgetState();
}

class _MobileNumberInputWidgetState extends State<MobileNumberInputWidget> {
  bool receiveUpdates = true;

  void _showOtpBottomSheet() {
    List<_OtpFieldController> otpFields = List.generate(
      6,
      (_) => _OtpFieldController(TextEditingController(), FocusNode()),
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 24.0,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter 6 digit code",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                const SizedBox(height: 8),
                Text(
                  "Please enter the 6-digit code sent to you on +2519-999-6789",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    6,
                    (index) => SizedBox(
                      width: 40,
                      child: TextField(
                        controller: otpFields[index].controller,
                        focusNode: otpFields[index].focusNode,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            if (index < 5) {
                              otpFields[index + 1].focusNode.requestFocus();
                            } else {
                              otpFields[index].focusNode.unfocus();
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      "Didn’t receive the text? ",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Resend code logic
                      },
                      child: Text(
                        "Resend code",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CarRentGradientButton(
                  buttonText: "Verify and Continue",
                  onPressed: () {
                    String otpCode =
                        otpFields.map((e) => e.controller.text).join();
                    if (otpCode.length == 6) {
                      // Proceed to verify OTP
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DriverLicenseUpload(),
                        ),
                      );
                    } else {
                      // Show error
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please enter all 6 digits")),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20.0),
          child: IconButton(
            icon: Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 32.0, top: 30),
          child: Text("Mobile Number"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Indicator
            Image.asset(
              'assets/images/secondprogressbar.png',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            // Title
            Text(
              "Enter your mobile number",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            // Instructions
            Text(
              "Please provide your phone number. We’ll send you an OTP to verify it.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                // Country Code Dropdown with Border
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300, // Border color
                      width: 1.0, // Border width
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        topLeft: Radius.circular(8)), // Border radius
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8), // Inner padding
                  child: DropdownButton<String>(
                    value: '+251',
                    items: <String>['+251', '+44', '+91', '+81', '+1']
                        .map((String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                        .toList(),
                    onChanged: (value) {
                      // Handle country code selection
                    },
                    underline: SizedBox(), // Removes default underline
                    icon: Icon(Icons.arrow_drop_down), // Dropdown icon
                  ),
                ),

                // Phone Number Input
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Enter mobile number",
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(32),
                            topRight: Radius.circular(32)),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Checkbox for receiving updates
            Row(
              children: [
                Checkbox(
                  value: receiveUpdates,
                  onChanged: (value) {
                    setState(() {
                      receiveUpdates = value ?? true;
                    });
                  },
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Get trip updates via text",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
              ],
            ),
            const Spacer(), // Pushes the button to the bottom
            // Get OTP Button
            CarRentGradientButton(
              buttonText: "Get OTP",
              onPressed: _showOtpBottomSheet,
            ),
          ],
        ),
      ),
    );
  }
}

class _OtpFieldController {
  final TextEditingController controller;
  final FocusNode focusNode;

  _OtpFieldController(this.controller, this.focusNode);
}
