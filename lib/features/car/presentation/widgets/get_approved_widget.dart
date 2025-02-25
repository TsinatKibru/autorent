// // import 'package:car_rent/core/common/bloc/profile/profile_bloc.dart';
// // import 'package:car_rent/core/common/bloc/rental/rental_bloc.dart';
// // import 'package:car_rent/core/common/entities/profile.dart';
// // import 'package:car_rent/core/common/entities/rental.dart';
// // import 'package:car_rent/core/theme/app_pallete.dart';
// // import 'package:car_rent/core/utils/show_snackbar.dart';
// // import 'package:car_rent/features/car/presentation/widgets/car_rent_gradient_button.dart';
// // import 'package:car_rent/features/car/presentation/widgets/driver_license_upload.dart';
// // import 'package:car_rent/features/car/presentation/widgets/profile_photo_upload_widget.dart';
// // import 'package:car_rent/features/host/presentation/widgets/update_profile_form.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';

// // class GetApprovedWidget extends StatefulWidget {
// //   final Rental rental;

// //   const GetApprovedWidget({super.key, required this.rental});

// //   @override
// //   State<GetApprovedWidget> createState() => _GetApprovedWidgetState();
// // }

// // class _GetApprovedWidgetState extends State<GetApprovedWidget> {
// //   Profile? _currentUserProfile;
// //   bool continueclicked = false;

// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     final profileState = context.read<ProfileBloc>().state;
// //     if (profileState is ProfileLoadSuccess) {
// //       _currentUserProfile = profileState.profile;
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: BlocListener<RentalBloc, RentalState>(
// //         listener: (context, state) {
// //           if (state is RentalLoadSuccess) {
// //             if (continueclicked) {
// //               showSnackbar(context, "Rental Sucess");
// //             }
// //           }
// //         },
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const SizedBox(
// //               height: 40,
// //             ),
// //             // Close Button
// //             Align(
// //               alignment: Alignment.topLeft,
// //               child: IconButton(
// //                 icon: Icon(Icons.close, color: Colors.black),
// //                 onPressed: () {
// //                   Navigator.pop(context);
// //                 },
// //               ),
// //             ),
// //             const Padding(
// //               padding: EdgeInsets.all(16.0),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   // Title Text
// //                   Text(
// //                     "Get Approved to Drive",
// //                     style: TextStyle(
// //                         fontSize: 26,
// //                         fontWeight: FontWeight.w700,
// //                         color: Colors.black),
// //                   ),
// //                   SizedBox(height: 8),
// //                   // Subtitle Text
// //                   Text(
// //                     "Since this is your first time, you will need to provide us with some information before you can check out.",
// //                     style: TextStyle(fontSize: 16),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             // Content with Green Background
// //             Expanded(
// //               child: Padding(
// //                 padding: const EdgeInsets.all(16.0),
// //                 child: Container(
// //                   color: const Color.fromARGB(255, 236, 252, 236),
// //                   child: ListView(
// //                     padding: const EdgeInsets.all(16.0),
// //                     children: [
// //                       _buildInfoSection(Icons.person, "Profile Photo",
// //                           "Upload a clear photo of yourself to complete the profile."),
// //                       const SizedBox(height: 16),
// //                       const Divider(
// //                         thickness: 0.5,
// //                         color: Colors.black12,
// //                       ),
// //                       _buildInfoSection(Icons.phone, "Phone Number",
// //                           "Provide a valid phone number for verification."),
// //                       const SizedBox(height: 16),
// //                       const Divider(
// //                         thickness: 0.5,
// //                         color: Colors.black12,
// //                       ),
// //                       _buildInfoSection(Icons.card_membership, "Driver License",
// //                           "Upload a picture of your valid driver's license."),
// //                       const SizedBox(height: 16),
// //                       const Divider(
// //                         thickness: 0.5,
// //                         color: Colors.black12,
// //                       ),
// //                       _buildInfoSection(Icons.payment, "Payment Method",
// //                           "Add your preferred payment method for payouts."),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.all(16.0),
// //               child: CarRentGradientButton(
// //                   buttonText: "Continue",
// //                   onPressed: () {
// //                     // Proceed to payment logic

// //                     if (_currentUserProfile != null) {
// //                       WidgetsBinding.instance.addPostFrameCallback((_) {
// //                         setState(() {
// //                           continueclicked = true;
// //                         });
// //                       });
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => UpdateProfileForm(
// //                             profile: _currentUserProfile!,
// //                           ),
// //                         ),
// //                       ).then((success) {
// //                         if (success == true) {
// //                           context
// //                               .read<RentalBloc>()
// //                               .add(CreateRentalEvent(widget.rental));
// //                         }
// //                       });
// //                     }
// //                   }),
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildInfoSection(IconData icon, String title, String description) {
// //     return Row(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Icon(icon, size: 40, color: AppPalette.primaryColor),
// //         const SizedBox(width: 16),
// //         Expanded(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 title,
// //                 style: TextStyle(
// //                     fontSize: 18,
// //                     fontWeight: FontWeight.w600,
// //                     color: Colors.black54),
// //               ),
// //               const SizedBox(height: 4),
// //               Text(
// //                 description,
// //                 style: TextStyle(fontSize: 14, color: Colors.grey[700]),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
// import 'package:car_rent/core/common/bloc/profile/profile_bloc.dart';
// import 'package:car_rent/core/common/bloc/rental/rental_bloc.dart';
// import 'package:car_rent/core/common/entities/profile.dart';
// import 'package:car_rent/core/common/entities/rental.dart';
// import 'package:car_rent/core/theme/app_pallete.dart';
// import 'package:car_rent/core/utils/show_snackbar.dart';
// import 'package:car_rent/features/car/presentation/widgets/car_rent_gradient_button.dart';
// import 'package:car_rent/features/host/presentation/widgets/update_profile_form.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class GetApprovedWidget extends StatefulWidget {
//   final Rental rental;

//   const GetApprovedWidget({super.key, required this.rental});

//   @override
//   State<GetApprovedWidget> createState() => _GetApprovedWidgetState();
// }

// class _GetApprovedWidgetState extends State<GetApprovedWidget> {
//   Profile? _currentUserProfile;
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     final profileState = context.read<ProfileBloc>().state;

//     if (profileState is ProfileLoadSuccess) {
//       setState(() {
//         _currentUserProfile = profileState.profile;
//       });
//     }
//   }

//   void _onContinuePressed() {
//     if (_currentUserProfile == null) {
//       showSnackbar(context, "Profile data not loaded. Please try again.");
//       return;
//     }
//     setState(() => _isLoading = true);
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => UpdateProfileForm(profile: _currentUserProfile!),
//       ),
//     ).then((success) {
//       setState(() => _isLoading = false);
//       if (success == true) {
//         context.read<RentalBloc>().add(CreateRentalEvent(widget.rental));
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocListener<RentalBloc, RentalState>(
//         listener: (context, state) {
//           if (state is RentalLoadSuccess) {
//             showSnackbar(context, "Rental Success");
//           }
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 40),
//             Align(
//               alignment: Alignment.topLeft,
//               child: IconButton(
//                 icon: const Icon(Icons.close, color: Colors.black),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Get Approved to Drive",
//                     style: TextStyle(
//                         fontSize: 26,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.black),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     "Since this is your first time, you will need to provide us with some information before you can check out.",
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Container(
//                   padding: const EdgeInsets.all(16.0),
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 236, 252, 236),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: ListView(
//                     shrinkWrap: true,
//                     children: [
//                       _buildInfoSection(Icons.person, "Profile Photo",
//                           "Upload a clear photo of yourself to complete the profile."),
//                       _buildDivider(),
//                       _buildInfoSection(Icons.phone, "Phone Number",
//                           "Provide a valid phone number for verification."),
//                       _buildDivider(),
//                       _buildInfoSection(Icons.card_membership, "Driver License",
//                           "Upload a picture of your valid driver's license."),
//                       _buildDivider(),
//                       _buildInfoSection(Icons.payment, "Payment Method",
//                           "Add your preferred payment method for payouts."),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: CarRentGradientButton(
//                 buttonText: _isLoading ? "Processing..." : "Continue",
//                 onPressed: _isLoading ? () {} : _onContinuePressed,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoSection(IconData icon, String title, String description) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(icon, size: 40, color: AppPalette.primaryColor),
//         const SizedBox(width: 16),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black54),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 description,
//                 style: TextStyle(fontSize: 14, color: Colors.grey[700]),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDivider() {
//     return const Padding(
//       padding: EdgeInsets.symmetric(vertical: 16.0),
//       child: Divider(thickness: 0.5, color: Colors.black12),
//     );
//   }
// }
import 'package:car_rent/core/common/bloc/profile/profile_bloc.dart';
import 'package:car_rent/core/common/bloc/rental/rental_bloc.dart';
import 'package:car_rent/core/common/entities/profile.dart';
import 'package:car_rent/core/common/entities/rental.dart';
import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/core/utils/show_snackbar.dart';
import 'package:car_rent/features/car/presentation/widgets/car_rent_gradient_button.dart';
import 'package:car_rent/features/host/presentation/widgets/update_profile_form.dart';
import 'package:car_rent/features/navigation/presentation/widgets/bottom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetApprovedWidget extends StatefulWidget {
  final Rental rental;

  const GetApprovedWidget({super.key, required this.rental});

  @override
  State<GetApprovedWidget> createState() => _GetApprovedWidgetState();
}

class _GetApprovedWidgetState extends State<GetApprovedWidget> {
  Profile? _currentUserProfile;
  bool _isLoading = false;
  bool _isRentalSuccess = false;

  @override
  void initState() {
    super.initState();
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoadSuccess) {
      setState(() {
        _currentUserProfile = profileState.profile;
      });
    }
  }

  void _onContinuePressed() {
    if (_currentUserProfile == null) {
      showSnackbar(context, "Profile data not loaded. Please try again.");
      return;
    }
    setState(() => _isLoading = true);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProfileForm(profile: _currentUserProfile!),
      ),
    ).then((success) {
      setState(() => _isLoading = false);
      if (success == true) {
        context.read<RentalBloc>().add(CreateRentalEvent(widget.rental));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RentalBloc, RentalState>(
        listener: (context, state) {
          if (state is RentalLoadSuccess) {
            setState(() {
              _isRentalSuccess = true;
            });
            showSnackbar(context, "Rental Success!");
          }
        },
        child:
            _isRentalSuccess ? _buildSuccessContent() : _buildApprovalContent(),
      ),
    );
  }

  Widget _buildApprovalContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Get Approved to Drive",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              SizedBox(height: 8),
              Text(
                "Since this is your first time, you will need to provide us with some information before you can check out.",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 236, 252, 236),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  _buildInfoSection(Icons.person, "Profile Photo",
                      "Upload a clear photo of yourself to complete the profile."),
                  _buildDivider(),
                  _buildInfoSection(Icons.phone, "Phone Number",
                      "Provide a valid phone number for verification."),
                  _buildDivider(),
                  _buildInfoSection(Icons.card_membership, "Driver License",
                      "Upload a picture of your valid driver's license."),
                  _buildDivider(),
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
            buttonText: _isLoading ? "Processing..." : "Continue",
            onPressed: _isLoading ? () {} : _onContinuePressed,
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessContent() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle,
                size: 80, color: AppPalette.primaryColor),
            const SizedBox(height: 16),
            const Text(
              "You're Approved!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Congratulations! You are now approved and started renting cars.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            CarRentGradientButton(
              buttonText: "Proceed",
              onPressed: () {
                // Navigate to the next page (replace with actual navigation)
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) =>
                          BottomNavigationBarWidget(initialIndex: 1)),
                  (Route<dynamic> route) =>
                      false, // Removes all previous routes
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 40, color: AppPalette.primaryColor),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
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

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Divider(thickness: 0.5, color: Colors.black12),
    );
  }
}
