// import 'package:car_rent/features/host/presentation/widgets/shimmer_loading_list.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:car_rent/core/common/bloc/profile/profile_bloc.dart';
// import 'package:car_rent/core/common/widgets/custom_image.dart';
// import 'package:car_rent/core/theme/app_pallete.dart';
// import 'package:car_rent/features/host/presentation/widgets/update_profile_form.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String titleText;

//   const CustomAppBar({Key? key, this.titleText = "Location"}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               const Icon(Icons.location_on_outlined,
//                   color: Colors.black87, size: 24),
//               const SizedBox(width: 8),
//               Text(
//                 titleText,
//                 style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87),
//               ),
//               const SizedBox(width: 4),
//               const Icon(Icons.arrow_drop_down, color: AppPalette.primaryColor),
//             ],
//           ),
//           BlocListener<ProfileBloc, ProfileState>(
//             listener: (context, state) {
//               if (state is ProfileLoadSuccess) {
//                 // Here, we can trigger actions like navigation or showing notifications
//                 // But we're not rebuilding the UI, only responding to state changes
//               } else if (state is ProfileFailure) {
//                 // Handle failure state (e.g., show a toast or snackbar)
//               }
//             },
//             child: BlocBuilder<ProfileBloc, ProfileState>(
//               builder: (context, state) {
//                 print("state : ${state}");
//                 if (state is ProfileInitial) {
//                   return const CircularProgressIndicator(); // Or a default placeholder
//                 }
//                 if (state is ProfileLoading) {
//                   return const ShimmerLoadingList(
//                     itemCount: 1,
//                     cardHeight: 40,
//                     cardWidth: 40,
//                     borderRadius: 24,
//                     margin: EdgeInsets.zero,
//                   ); // Or a default placeholder
//                 }

//                 if (state is ProfileLoadSuccess) {
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => UpdateProfileForm(
//                             profile: state.profile,
//                           ),
//                         ),
//                       );
//                     },
//                     child: state.profile.avatar != null
//                         ? CustomImage(
//                             imageUrl: state.profile.avatar!,
//                             height: 40,
//                             width: 40,
//                             fit: BoxFit.cover,
//                             borderRadius: BorderRadius.circular(24),
//                           )
//                         : const Icon(Icons.account_circle, size: 40),
//                   );
//                 } else {
//                   return const Icon(Icons.account_circle,
//                       size: 40); // Fallback icon
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
import 'package:car_rent/core/utils/location_utils.dart';
import 'package:car_rent/features/host/presentation/widgets/shimmer_loading_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_rent/core/common/bloc/profile/profile_bloc.dart';
import 'package:car_rent/core/common/widgets/custom_image.dart';
import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/features/host/presentation/widgets/update_profile_form.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String titleText;

  const CustomAppBar({Key? key, this.titleText = "Location"}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String _locationText = "Location";
  bool _isLocationUpdating = false; // Flag to track location update

  Future<void> _getUserLocation() async {
    var status = await Permission.location.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.location.request();
    }

    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      String locationName = await LocationUtils.getLocationName(
          position.latitude, position.longitude);

      if (mounted) {
        setState(() {
          _locationText = locationName;
        });

        // Avoid loop: Only update if not already in process
        if (!_isLocationUpdating) {
          _isLocationUpdating = true;

          final profileState = context.read<ProfileBloc>().state;
          if (profileState is ProfileLoadSuccess) {
            final updatedProfile = profileState.profile.copyWith(
                location: '${position.latitude}, ${position.longitude}');
            context.read<ProfileBloc>().add(UpdateProfileEvent(updatedProfile));
            print(updatedProfile);
          }

          // Reset flag after a delay to prevent continuous calls
          Future.delayed(const Duration(milliseconds: 500), () {
            _isLocationUpdating = false;
          });
        }
      }
    } else if (status.isPermanentlyDenied) {
      openAppSettings(); // Opens settings for manual permission grant
    } else {
      if (mounted) {
        setState(() {
          _locationText = "Location permission denied";
        });
      }
    }
  }

  // bool _isLocationUpdating = false;

  // Future<void> _getUserLocation() async {
  //   var status = await Permission.location.status;
  //   if (status.isDenied || status.isPermanentlyDenied) {
  //     status = await Permission.location.request();
  //   }

  //   if (status.isGranted) {
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);

  //     // Fetch location name asynchronously
  //     String locationName = await LocationUtils.getLocationName(
  //         position.latitude, position.longitude);
  //     //djbfv

  //     setState(() {
  //       _locationText = locationName;
  //     });
  //   } else if (status.isPermanentlyDenied) {
  //     openAppSettings(); // Opens settings for manual permission grant
  //   } else {
  //     setState(() {
  //       _locationText = "Location permission denied";
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on_outlined,
                  color: Colors.black87, size: 24),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _getUserLocation,
                child: Text(
                  _locationText,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: _getUserLocation,
                child: const Icon(Icons.arrow_drop_down,
                    color: AppPalette.primaryColor),
              ),
            ],
          ),
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileLoadSuccess) {
                // Here, we can trigger actions like navigation or showing notifications
                // But we're not rebuilding the UI, only responding to state changes
              } else if (state is ProfileFailure) {
                // Handle failure state (e.g., show a toast or snackbar)
              }
            },
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                print("state : ${state}");
                if (state is ProfileInitial) {
                  return const ShimmerLoadingList(
                    itemCount: 1,
                    cardHeight: 40,
                    cardWidth: 40,
                    borderRadius: 24,
                    margin: EdgeInsets.zero,
                  );
                }
                if (state is ProfileLoading) {
                  return const ShimmerLoadingList(
                    itemCount: 1,
                    cardHeight: 40,
                    cardWidth: 40,
                    borderRadius: 24,
                    margin: EdgeInsets.zero,
                  ); // Or a default placeholder
                }

                if (state is ProfileLoadSuccess) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateProfileForm(
                            profile: state.profile,
                          ),
                        ),
                      );
                    },
                    child: state.profile.avatar != null
                        ? CustomImage(
                            imageUrl: state.profile.avatar!,
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                            borderRadius: BorderRadius.circular(24),
                          )
                        : const Icon(Icons.account_circle, size: 40),
                  );
                } else {
                  return const Icon(Icons.account_circle,
                      size: 40); // Fallback icon
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
