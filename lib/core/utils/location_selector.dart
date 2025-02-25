// import 'package:car_rent/core/common/constants.dart';
// import 'package:car_rent/core/common/entities/location.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart'; // Ensure this package is added in pubspec.yaml

// class LocationPicker extends StatefulWidget {
//   final Function(Location) onLocationSelected;

//   const LocationPicker({Key? key, required this.onLocationSelected})
//       : super(key: key);

//   @override
//   _LocationPickerState createState() => _LocationPickerState();
// }

// class _LocationPickerState extends State<LocationPicker> {
//   // Location selectedLocation = Location(
//   //     latitude: 40.7128, longitude: -74.0060); // Default location (New York)
//   // Location selectedLocation = Location(latitude: 9.0300, longitude: 38.7400);
//   Location selectedLocation = Location(
//     latitude: Constants.stationLocation['lat']!,
//     longitude: Constants.stationLocation['lon']!,
//   );

//   @override
//   Widget build(BuildContext context) {
//     print("selectedLocation:${selectedLocation}");
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text('Location Picker'),
//       // ),
//       body: FlutterMap(
//         options: MapOptions(
//           initialCenter: LatLng(
//               selectedLocation.latitude,
//               selectedLocation
//                   .longitude), // Use initialCenter instead of center
//           initialZoom: 13.0, // Use initialZoom instead of zoom
//           onTap: (tapPosition, point) {
//             setState(() {
//               selectedLocation = Location(
//                   latitude: point.latitude, longitude: point.longitude);
//               ;
//             });
//             widget.onLocationSelected(selectedLocation);
//             ;
//           },
//         ),
//         children: [
//           TileLayer(
//             urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//             subdomains: ['a', 'b', 'c'],
//           ),
//           MarkerLayer(
//             markers: [
//               Marker(
//                 point: LatLng(
//                     selectedLocation.latitude, selectedLocation.longitude),
//                 width: 80.0,
//                 height: 80.0,
//                 child: const Icon(
//                   Icons.location_on,
//                   color: Colors.red,
//                   size: 40,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:car_rent/core/common/constants.dart';
import 'package:car_rent/core/common/entities/location.dart';
import 'package:car_rent/core/utils/location_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // Ensure this package is added in pubspec.yaml

class LocationPicker extends StatefulWidget {
  final Function(Location) onLocationSelected;
  final Location? initialLocation; // Optional parameter for initial location

  const LocationPicker({
    Key? key,
    required this.onLocationSelected,
    this.initialLocation, // Pass the initial location here
  }) : super(key: key);

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  late Location selectedLocation;

  @override
  void initState() {
    super.initState();
    // Set the initial location based on the provided parameter or default to Constants
    selectedLocation = widget.initialLocation ??
        Location(
          latitude: Constants.stationLocation['lat']!,
          longitude: Constants.stationLocation['lon']!,
        );
  }

  @override
  Widget build(BuildContext context) {
    print("selectedLocation: ${selectedLocation}");
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(
              selectedLocation.latitude,
              selectedLocation
                  .longitude), // Use initialCenter instead of center
          initialZoom: 13.0, // Use initialZoom instead of zoom
          onTap: (tapPosition, point) async {
            final locationName = await LocationUtils.getLocationName(
                point.latitude, point.longitude);
            print("locationName:${locationName}");
            setState(() {
              selectedLocation = Location(
                  latitude: point.latitude, longitude: point.longitude);
            });
            widget.onLocationSelected(selectedLocation);
          },
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(
                    selectedLocation.latitude, selectedLocation.longitude),
                width: 80.0,
                height: 80.0,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
