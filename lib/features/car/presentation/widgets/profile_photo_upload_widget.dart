import 'dart:io';
import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/features/car/presentation/widgets/mobile_number_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:car_rent/features/car/presentation/widgets/car_rent_gradient_button.dart';

class ProfilePhotoUploadWidget extends StatefulWidget {
  @override
  _ProfilePhotoUploadWidgetState createState() =>
      _ProfilePhotoUploadWidgetState();
}

class _ProfilePhotoUploadWidgetState extends State<ProfilePhotoUploadWidget> {
  final ImagePicker _picker = ImagePicker();
  String? _profilePhotoPath;

  // Function to pick an image
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profilePhotoPath = image.path;
      });
    }
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
          child: Text("Profile Photo"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Indicator
            Image.asset(
              'assets/images/firstprogressbar.png',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            // Instructions
            Text(
              "Choose your profile photo",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Please provide a clear photo. Your face should be easily recognizable.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 24),
            // Profile Photo Upload Section
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    // Profile Photo
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.transparent, width: 2),
                      ),
                      child: _profilePhotoPath != null
                          ? ClipOval(
                              child: Image.file(
                                File(_profilePhotoPath!),
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.asset(
                              'assets/images/uploaddummy.png',
                              fit: BoxFit.cover,
                            ),
                    ),
                    // Add Icon
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppPalette.primaryColor,
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 24),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(), // Pushes the button to the bottom
            // Save Button
            CarRentGradientButton(
                buttonText: "Save and Continue",
                onPressed: () {
                  // Proceed to payment logic
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MobileNumberInputWidget(),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
