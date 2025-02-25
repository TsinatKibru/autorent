import 'dart:io';
import 'package:car_rent/core/common/bloc/wallet/wallet_bloc.dart';
import 'package:car_rent/core/common/bloc/wallet/wallet_event.dart';
import 'package:car_rent/core/common/constants.dart';
import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/features/host/presentation/widgets/transaction_details_page.dart';
import 'package:car_rent/features/navigation/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:car_rent/core/common/widgets/custom_image.dart';
import 'package:car_rent/core/utils/show_snackbar.dart';
import 'package:car_rent/features/car/presentation/widgets/car_rent_gradient_button.dart';
import 'package:car_rent/core/common/bloc/image/image_bloc.dart';
import 'package:car_rent/core/common/bloc/profile/profile_bloc.dart';
import 'package:car_rent/core/common/entities/profile.dart';
import 'package:car_rent/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class UpdateProfileForm extends StatefulWidget {
  final Profile profile;
  final String? userRole;

  const UpdateProfileForm({
    Key? key,
    required this.profile,
    this.userRole,
  }) : super(key: key);

  @override
  State<UpdateProfileForm> createState() => _UpdateProfileFormState();
}

class _UpdateProfileFormState extends State<UpdateProfileForm> {
  final _formKey = GlobalKey<FormState>();

  late String _name;
  late String? _lastName;
  late String? _phoneNumber;
  late String? _avatarUrl;
  late String? _licenseUrl;
  late String? _userrole;

  File? _avatarImage;
  File? _licenseImage;
  String? _currentUserId;
  bool _updateclicked = false;

  @override
  void initState() {
    super.initState();
    _initializeProfileData();
    _fetchCurrentUser();
  }

  void _initializeProfileData() {
    _name = widget.profile.name;
    _lastName = widget.profile.lastName;
    _phoneNumber = widget.profile.phoneNumber;
    _avatarUrl = widget.profile.avatar ?? "";
    _licenseUrl = widget.profile.driverLicenseImageUrl ?? "";
    _userrole = widget.userRole;
  }

  void _fetchCurrentUser() {
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final updatedProfile = widget.profile.copyWith(
        name: _name,
        lastName: _lastName,
        phoneNumber: _phoneNumber,
        avatar: _avatarUrl,
        driverLicenseImageUrl: _licenseUrl,
        role: _userrole,
        updatedAt: DateTime.now(),
      );
      setState(() {
        _updateclicked = true;
      });

      context.read<ProfileBloc>().add(UpdateProfileEvent(updatedProfile));
    }
  }

  Future<void> _pickImage({required bool isAvatar}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final bucketName = isAvatar ? 'avatar' : 'driver_license_images';

      if (isAvatar) {
        setState(() {
          _avatarImage = file;
        });
      } else {
        setState(() {
          _licenseImage = file;
        });
      }

      context.read<ImageBloc>().add(
            UploadImageEvent(
              path: pickedFile.path,
              bucketName: bucketName,
              userId: _currentUserId!,
            ),
          );
    }
  }

  void _handleSuccess() {
    setState(() {
      _updateclicked = false;
    });

    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.info(
        message: "Profile Updated Sucessfully",
      ),
    );
    Navigator.pop(context, true); // `true` indicates success
  }

  // void _handleLogout() {
  //   final state = context.read<ProfileBloc>().state;
  //   if (state is ProfileLoadSuccess) {
  //     context.read<AuthBloc>().add(AuthLogout());
  //     showSnackbar(context, 'You have successfully logged out.');
  //   } else {
  //     showSnackbar(context, 'network error');
  //   }
  // }

  void _handleLogout() async {
    final state = context.read<ProfileBloc>().state;
    if (state is ProfileLoadSuccess) {
      // Clear authentication state
      context.read<AuthBloc>().add(AuthLogout());

      // Clear navigation stack and redirect to login page
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SplashPage()),
        (Route<dynamic> route) => false, // Removes all previous routes
      );

      showSnackbar(context, 'You have successfully logged out.');
    } else {
      showSnackbar(context, 'Network error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: _handleLogout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileLoadSuccess) {
                if (_updateclicked) {
                  _handleSuccess();
                }
                if (state.profile.role == "host" &&
                    state.profile.walletId == null) {
                  context.read<WalletBloc>().add(
                        CreateWalletEvent(
                            state.profile.id, Constants.initwalletbalance),
                      );
                }
              } else if (state is ProfileFailure) {
                showSnackbar(
                    context, 'Failed to update profile: ${state.message}');
              }
            },
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                setState(() {
                  _currentUserId = state.user.id;
                });
              }
              if (state is AuthInitial) {
                Navigator.pop(context);
              }
            },
          ),
          BlocListener<ImageBloc, ImageState>(
            listener: (context, state) {
              if (state is ImageUploadSuccess) {
                final url = state.url;
                if (url.contains('/driver_license_images/')) {
                  setState(() {
                    _licenseUrl = url;
                  });
                } else if (url.contains('/avatar/')) {
                  setState(() {
                    _avatarUrl = url;
                  });
                }
              } else if (state is ImageUploadFailure) {
                showSnackbar(context, state.message);
              }
            },
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildImagePicker(
                  label: 'Avatar Image',
                  imageFile: _avatarImage,
                  existingUrl: _avatarUrl,
                  isCircular: true,
                  onPick: () => _pickImage(isAvatar: true),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  label: 'Name',
                  initialValue: _name,
                  onSaved: (value) => _name = value!,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  label: 'Last Name',
                  initialValue: _lastName,
                  onSaved: (value) => _lastName = value,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  label: 'Phone Number',
                  initialValue: _phoneNumber,
                  onSaved: (value) => _phoneNumber = value,
                ),
                const SizedBox(height: 20),
                _buildImagePicker(
                  label: 'Driver License Image',
                  imageFile: _licenseImage,
                  existingUrl: _licenseUrl,
                  isCircular: false,
                  onPick: () => _pickImage(isAvatar: false),
                ),
                const SizedBox(height: 20),
                if (widget.profile.role == 'host' &&
                    widget.profile.walletId != null)
                  Container(
                    decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceVariant,
                        border: Border.all(color: Colors.grey[200]!),
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.1), // Shadow color
                            blurRadius: 100, // Blur radius
                            spreadRadius: 0, // Spread radius
                            offset: const Offset(0, 0), // Shadow position
                          ),
                        ]),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(16), // Less curved border
                        ),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TransactionDetailsPage(
                            walletId: widget.profile.walletId!,
                          ),
                        ),
                      ),
                      icon: const Icon(Icons.arrow_forward), // Arrow icon
                      label: const Text('View Transactions'),
                    ),
                  ),
                const SizedBox(height: 20),
                CarRentGradientButton(
                  buttonText: 'Update Profile',
                  onPressed: _isFormValid ? _submitForm : () {},
                  isActive: _isFormValid,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildTextField({
  //   required String label,
  //   required String? initialValue,
  //   required FormFieldSetter<String> onSaved,
  // }) {
  //   return TextFormField(
  //     initialValue: initialValue,
  //     decoration: InputDecoration(labelText: label),
  //     onSaved: onSaved,
  //     validator: (value) =>
  //         value == null || value.isEmpty ? 'Please enter $label' : null,
  //   );
  // }
  Widget _buildTextField({
    required String label,
    required String? initialValue,
    required FormFieldSetter<String> onSaved,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          // Ensures a border is always there
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          // Default border
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          // When focused
          borderRadius: BorderRadius.circular(8),
          borderSide:
              const BorderSide(color: AppPalette.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          // When validation fails
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          // When error & focused
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
      onSaved: onSaved,
      validator: (value) =>
          value == null || value.isEmpty ? 'Please enter $label' : null,
    );
  }

  Widget _buildImagePicker({
    required String label,
    required File? imageFile,
    required String? existingUrl,
    required bool isCircular,
    required VoidCallback onPick,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(isCircular ? 50 : 8),
              child: imageFile != null
                  ? Image.file(
                      imageFile,
                      height: isCircular ? 100 : 150,
                      width: isCircular ? 100 : double.infinity,
                      fit: BoxFit.cover,
                    )
                  : existingUrl != null && existingUrl.isNotEmpty
                      ? CustomImage(
                          imageUrl: existingUrl,
                          height: isCircular ? 100 : 150,
                          width: isCircular ? 100 : double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: isCircular ? 100 : 150,
                          width: isCircular ? 100 : double.infinity,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image,
                              size: 50, color: Colors.grey),
                        ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                child: IconButton(
                  onPressed: onPick,
                  icon: const Icon(Icons.camera_alt, color: Colors.white),
                  iconSize: 20,
                ),
              ),
            ),
          ],
        ),
        if (!isCircular)
          const Center(
            child: Text(
              "upload driver's license image",
              style: TextStyle(fontSize: 10),
            ),
          )
      ],
    );
  }

  // bool get _isFormValid =>
  //     (_avatarImage == null || _avatarUrl!.isNotEmpty) &&
  //     (_licenseImage == null || _licenseUrl!.isNotEmpty);
  bool get _isFormValid =>
      (_avatarUrl?.isNotEmpty ?? false) && (_licenseUrl?.isNotEmpty ?? false);
}
