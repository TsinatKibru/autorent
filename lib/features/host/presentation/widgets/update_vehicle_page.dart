import 'dart:io';
import 'package:car_rent/core/common/bloc/image/image_bloc.dart';
import 'package:car_rent/core/common/widgets/custom_image.dart';
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

class UpdateVehiclePage extends StatefulWidget {
  static route(Vehicle vehicle) => MaterialPageRoute(
        builder: (context) => UpdateVehiclePage(vehicle: vehicle),
      );

  final Vehicle vehicle;

  const UpdateVehiclePage({Key? key, required this.vehicle}) : super(key: key);

  @override
  _UpdateVehiclePageState createState() => _UpdateVehiclePageState();
}

class _UpdateVehiclePageState extends State<UpdateVehiclePage> {
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

  String? transmissionType;
  String? category;
  String? currentUserId;
  File? insuranceImage;

  bool _isUpdateButtonEnabled = true;
  bool isupdateButtonClicked = false;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
    _populateFormFields();
  }

  void _fetchCurrentUser() {
    context.read<ab.AuthBloc>().add(ab.AuthIsUserLoggedIn());
  }

  void _populateFormFields() {
    final vehicle = widget.vehicle;
    plateNumberController.text = vehicle.plateNumber;
    modelController.text = vehicle.model;
    brandController.text = vehicle.brand;
    transmissionType = vehicle.transmissionType;
    category = vehicle.category;
    pricePerHourController.text = vehicle.pricePerHour.toString();
    numberOfDoorsController.text = vehicle.numberOfDoors.toString();
    seatingCapacityController.text = vehicle.seatingCapacity.toString();
    descriptionNoteController.text = vehicle.descriptionNote ?? "";
    guidelinesController.text = vehicle.guidelines ?? "";
    batteryCapacityController.text = vehicle.batteryCapacity.toString();
    topSpeedController.text = vehicle.topSpeed.toString();
    engineOutputController.text = vehicle.engineOutput.toString();
    insuranceImageUrlController.text = vehicle.insuranceImageUrl ?? "";
    galleryImageUrls.addAll(vehicle.gallery ?? []);
  }

  void _validateImageUpload() {
    setState(() {
      _isUpdateButtonEnabled = insuranceImageUrlController.text.isNotEmpty &&
          galleryImageUrls.isNotEmpty;
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
    print("lab_validateImageUploadel: ");
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
              if (isupdateButtonClicked) {
                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.success(
                    message: "Vehicle updated successfully!",
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
                galleryImageUrls.insert(0, url);
              }
              _validateImageUpload();
            } else if (state is ImageUploadFailure) {
              showSnackbar(context, state.message);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Update Vehicle',
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
                          transmissionType == "automatic"
                              ? "Automatic"
                              : "Manual", // Pass the current value
                          (value) => setState(() => transmissionType = value),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildDropdown(
                    'Category',
                    ['suv', 'hatchback', 'truck', 'van', 'luxury'],
                    category, // Pass the current value
                    (value) => setState(() => category = value?.toLowerCase()),
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
                      isActive: _isUpdateButtonEnabled,
                      width: double.infinity,
                      onPressed:
                          _isUpdateButtonEnabled ? _updateVehicle : () {},
                      buttonText: 'Update Vehicle',
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

  void _updateVehicle() {
    if (formKey.currentState!.validate()) {
      try {
        print("clicked");
        final updatedVehicle = widget.vehicle.copyWith(
          plateNumber: plateNumberController.text.trim(),
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
          descriptionNote: descriptionNoteController.text.trim(),
          guidelines: guidelinesController.text.trim(),
        );

        context
            .read<VehicleBloc>()
            .add(UpdateVehicleEvent(widget.vehicle.id, updatedVehicle));
        Future.delayed(const Duration(milliseconds: 10), () {
          setState(() {
            isupdateButtonClicked = true;
          });
        });
      } catch (e) {
        print("error:${e}");

        showSnackbar(context, 'Error updating vehicle: $e');
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
        if (insuranceImageUrlController.text.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CustomImage(
                  imageUrl: insuranceImageUrlController.text,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )),
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
        if (galleryImageUrls.isNotEmpty)
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
              itemCount: galleryImageUrls.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CustomImage(
                          imageUrl: galleryImageUrls[index],
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () {
                          if (galleryImageUrls.length != 1) {
                            setState(() {
                              galleryImageUrls.removeAt(index);
                            });
                          }
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

  // Widget _buildTextField(String label, TextEditingController controller,
  //     {TextInputType keyboardType = TextInputType.text}) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: TextFormField(
  //       controller: controller,
  //       keyboardType: keyboardType,
  //       validator: (value) =>
  //           value == null || value.isEmpty ? 'Please enter $label' : null,
  //       decoration: InputDecoration(
  //         labelText: label,
  //         border: OutlineInputBorder(),
  //       ),
  //     ),
  //   );
  // }
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

  // Widget _buildDropdown(
  //     String label, List<String> items, ValueChanged? onChanged) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: DropdownButtonFormField(
  //       value: items.contains(label) ? label : null,
  //       items: items
  //           .map((item) => DropdownMenuItem(
  //                 value: item,
  //                 child: Text(item),
  //               ))
  //           .toList(),
  //       onChanged: onChanged,
  //       validator: (value) => value == null ? 'Please select a $label' : null,
  //       decoration: InputDecoration(
  //         labelText: label,
  //         border: OutlineInputBorder(),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildDropdown(String label, List<String> items, String? value,
      ValueChanged? onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField(
        value: value, // Set the current value
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
