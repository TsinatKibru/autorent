import 'dart:io';
import 'package:car_rent/core/common/bloc/image/image_bloc.dart';
import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/core/utils/show_snackbar.dart';
import 'package:car_rent/features/auth/presentation/bloc/auth_bloc.dart' as ab;
import 'package:car_rent/features/car/domain/entities/vehicle.dart';
import 'package:car_rent/features/car/presentation/bloc/vehicle_bloc.dart';
import 'package:car_rent/features/car/presentation/widgets/car_rent_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CreateVehiclePage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const CreateVehiclePage(),
      );
  const CreateVehiclePage({Key? key}) : super(key: key);

  @override
  _CreateVehiclePageState createState() => _CreateVehiclePageState();
}

class _CreateVehiclePageState extends State<CreateVehiclePage> {
  final plateNumberController = TextEditingController();
  final modelController = TextEditingController();
  final brandController = TextEditingController();
  final pricePerHourController = TextEditingController();
  final numberOfDoorsController = TextEditingController();
  final seatingCapacityController = TextEditingController();
  final descriptionNoteController = TextEditingController();
  final guidelinesController = TextEditingController();
  final batteryCapacityController = TextEditingController();
  final topSpeedController = TextEditingController();
  final engineOutputController = TextEditingController();
  final insuranceImageUrlController = TextEditingController();
  final galleryImages = <File>[];
  final galleryImageUrls = <String>[];
  final formKey = GlobalKey<FormState>();

  bool isCreateButtonClicked = false;

  String? transmissionType;
  String? category;
  String? currentUserId;
  File? insuranceImage;

  bool _isRegisterButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  void _fetchCurrentUser() {
    context.read<ab.AuthBloc>().add(ab.AuthIsUserLoggedIn());
  }

  void _validateImageUpload() {
    setState(() {
      _isRegisterButtonEnabled = insuranceImage != null &&
          insuranceImageUrlController.text.isNotEmpty &&
          galleryImages.length == galleryImageUrls.length &&
          galleryImages.isNotEmpty;
    });
  }

  @override
  void dispose() {
    plateNumberController.dispose();
    modelController.dispose();
    brandController.dispose();
    pricePerHourController.dispose();
    numberOfDoorsController.dispose();
    seatingCapacityController.dispose();
    descriptionNoteController.dispose();
    guidelinesController.dispose();
    batteryCapacityController.dispose();
    topSpeedController.dispose();
    engineOutputController.dispose();
    insuranceImageUrlController.dispose();
    super.dispose();
  }

  Future<void> _pickGalleryImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null) {
      for (var pickedFile in pickedFiles) {
        final imageFile = File(pickedFile.path);
        galleryImages.add(imageFile);

        context.read<ImageBloc>().add(UploadImageEvent(
              path: pickedFile.path,
              bucketName: 'vehicle_gallery_images',
              userId: currentUserId!,
            ));
      }
    }
    _validateImageUpload();
  }

  Future<void> _pickInsuranceImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      insuranceImage = File(pickedFile.path);

      context.read<ImageBloc>().add(UploadImageEvent(
            path: pickedFile.path,
            bucketName: 'vehicle_insurance_images',
            userId: currentUserId!,
          ));
    }
    _validateImageUpload();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ab.AuthBloc, ab.AuthState>(
          listener: (context, state) {
            if (state is ab.AuthSuccess) {
              setState(() {
                currentUserId = state.user.id;
              });
            }
          },
        ),
        BlocListener<VehicleBloc, VehicleState>(
          listener: (context, state) {
            if (state is VehicleFailure) {
              showSnackbar(context, state.message);
            }
            if (state is CurrentUserVehiclesLoadSuccess) {
              if (isCreateButtonClicked) {
                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.success(
                    message: "Vehicle Created successfully!",
                  ),
                );
                Navigator.pop(context);
              }
            }
          },
        ),
        BlocListener<ImageBloc, ImageState>(
          listener: (context, state) {
            if (state is ImageUploadSuccess) {
              final url = state.url;

              String bucketName = '';
              if (url.contains('/vehicle_insurance_images/')) {
                bucketName = 'vehicle_insurance_images';
              } else if (url.contains('/vehicle_gallery_images/')) {
                bucketName = 'vehicle_gallery_images';
              }

              if (bucketName == 'vehicle_insurance_images') {
                insuranceImageUrlController.text = url;
              } else if (bucketName == 'vehicle_gallery_images') {
                galleryImageUrls.add(url);
              }
              _validateImageUpload();
            } else if (state is ImageUploadFailure) {
              print("Image upload failed with message: ${state.message}");
              showSnackbar(context, state.message);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Register Vehicle',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 5,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Vehicle Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Divider(color: Colors.grey, thickness: 1),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          'Plate Number',
                          plateNumberController,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildTextField(
                          'Model',
                          modelController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          'Brand',
                          brandController,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildDropdown(
                          'Transmission Type',
                          ['Automatic', 'Manual'],
                          (value) => transmissionType = value,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildDropdown(
                    'Category',
                    ['SUV', 'Hatchback', 'Truck', 'Van', 'Luxury'],
                    (value) => category = value?.toLowerCase(),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Pricing and Features',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Divider(color: Colors.grey, thickness: 1),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          'Price Per Hour',
                          pricePerHourController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildTextField(
                          'Number of Doors',
                          numberOfDoorsController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          'Seating Capacity',
                          seatingCapacityController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildTextField(
                          'Battery Capacity (kWh)',
                          batteryCapacityController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          'Top Speed (km/h)',
                          topSpeedController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildTextField(
                          'Engine Output (HP)',
                          engineOutputController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildTextField(
                      'Description Note', descriptionNoteController),
                  const SizedBox(height: 15),
                  _buildTextField('Guidelines', guidelinesController),
                  const SizedBox(height: 20),
                  _buildImageUploadSection(),
                  const SizedBox(height: 20),
                  Center(
                    child: CarRentGradientButton(
                      isActive: _isRegisterButtonEnabled,
                      width: double.infinity,
                      onPressed:
                          _isRegisterButtonEnabled ? _registerVehicle : () {},
                      buttonText: 'Register Vehicle',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _registerVehicle() {
    if (formKey.currentState!.validate()) {
      try {
        Vehicle vehicle = Vehicle(
          id: 3,
          plateNumber: plateNumberController.text.trim(),
          host: currentUserId!,
          model: modelController.text.trim(),
          brand: brandController.text.trim(),
          transmissionType: transmissionType!.toLowerCase(),
          category: category!.toLowerCase(),
          pricePerHour:
              double.tryParse(pricePerHourController.text.trim()) ?? 0.0,
          numberOfDoors: int.tryParse(numberOfDoorsController.text.trim()) ?? 0,
          seatingCapacity:
              int.tryParse(seatingCapacityController.text.trim()) ?? 0,
          batteryCapacity:
              double.tryParse(batteryCapacityController.text.trim()) ?? 0.0,
          topSpeed: double.tryParse(topSpeedController.text.trim()) ?? 0.0,
          engineOutput:
              double.tryParse(engineOutputController.text.trim()) ?? 0.0,
          insuranceImageUrl: insuranceImageUrlController.text.trim(),
          gallery: galleryImageUrls,
          available: true,
          activeStatus: true,
          createdAt: DateTime.now(),
          descriptionNote: descriptionNoteController.text.trim(),
          guidelines: guidelinesController.text.trim(),
        );
        context.read<VehicleBloc>().add(CreateVehicleEvent(vehicle));
        Future.delayed(const Duration(milliseconds: 10), () {
          setState(() {
            isCreateButtonClicked = true;
          });
        });
      } catch (e) {
        showSnackbar(context, 'Error creating vehicle: $e');
      }
    }
  }

  Widget _buildImageUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blueAccent,
            side: const BorderSide(color: Colors.blueAccent, width: 1.5),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: _pickInsuranceImage,
          icon: const Icon(Icons.image, size: 24),
          label: const Text('Select Insurance Image',
              style: TextStyle(fontSize: 16)),
        ),
        if (insuranceImage != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    insuranceImage!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                if (insuranceImageUrlController.text.isEmpty)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        const SizedBox(height: 15),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade200,
            foregroundColor: Colors.black,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: _pickGalleryImages,
          icon: const Icon(Icons.photo_library, size: 24),
          label: const Text('Upload Gallery Images',
              style: TextStyle(fontSize: 16)),
        ),
        if (galleryImages.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: galleryImages.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        galleryImages[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                    if (galleryImages.length != galleryImageUrls.length)
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            galleryImages.removeAt(index);
                            galleryImageUrls.removeAt(index);
                          });
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: (value) =>
            value == null || value.isEmpty ? 'Please enter $label' : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                const BorderSide(color: AppPalette.primaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
      String label, List<String> items, ValueChanged? onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField(
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? 'Please select a $label' : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
