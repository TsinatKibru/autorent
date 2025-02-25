import 'package:car_rent/core/common/bloc/profile/vehicle_owner/bloc/vehicle_owner_profile_bloc.dart';
import 'package:car_rent/core/common/widgets/custom_image.dart';
import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/core/utils/show_snackbar.dart';
import 'package:car_rent/features/host/presentation/widgets/shimmer_loading_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class HostDetails extends StatefulWidget {
  const HostDetails({Key? key}) : super(key: key);

  @override
  State<HostDetails> createState() => _HostDetailsState();
}

// void _makePhoneCall(String phoneNumber) async {
//   final Uri phoneUri = Uri.parse("tel:${Uri.encodeComponent(phoneNumber)}");
//   if (await canLaunchUrl(phoneUri)) {
//     await launchUrl(phoneUri);
//   } else {
//     throw "Could not launch phone app";
//   }
// }

Future<void> _makePhoneCall(String phoneNumber) async {
  var status = await Permission.phone.request();
  if (status.isGranted) {
    final Uri phoneUri = Uri.parse("tel:${Uri.encodeComponent(phoneNumber)}");
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw "Could not launch phone app";
    }
  } else {
    throw "Phone permission not granted";
  }
}

void _sendSMS(String phoneNumber) async {
  final Uri smsUri = Uri.parse("sms:$phoneNumber");
  if (await canLaunchUrl(smsUri)) {
    await launchUrl(smsUri);
  } else {
    throw "Could not launch messaging app";
  }
}

class _HostDetailsState extends State<HostDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: BlocBuilder<VehicleOwnerProfileBloc, VehicleOwnerProfileState>(
        builder: (context, state) {
          if (state is VehicleOwnerProfileLoading) {
            return const ShimmerLoadingList(
              itemCount: 1,
              cardHeight: 120,
              cardWidth: 350,
            );
          } else if (state is VehicleOwnerProfileFailure) {
            showSnackbar(context, state.message);
            return const Center(
              child: Text(
                'Failed to load profile. Please try again later.',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (state is VehicleOwnerProfileLoadSuccess) {
            final hostProfile = state.vehicleOwnerProfile;
            return Container(
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
                      CustomImage(
                        imageUrl: hostProfile.avatar!,
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${hostProfile.name} ${hostProfile.lastName}",
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            const Text(
                              "Los Angeles, CA",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (hostProfile.phoneNumber != null) {
                                _makePhoneCall(hostProfile.phoneNumber!);
                              }
                            },
                            icon: const Icon(Icons.phone,
                                color: AppPalette.primaryColor),
                          ),
                          IconButton(
                            onPressed: () {
                              if (hostProfile.phoneNumber != null) {
                                _sendSMS(hostProfile.phoneNumber!);
                              }
                            },
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
                      Icon(Icons.star,
                          color: AppPalette.primaryColor, size: 20),
                      SizedBox(width: 4.0),
                      Text(
                        "5.00",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 12.0),
                      Expanded(
                        child: Text(
                          "Typically responds in 15 minutes",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink(); // Return nothing for unrelated states
        },
      ),
    );
  }
}
