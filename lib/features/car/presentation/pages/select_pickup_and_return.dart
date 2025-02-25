import 'package:car_rent/core/common/bloc/profile/profile_bloc.dart';
import 'package:car_rent/core/common/bloc/profile/vehicle_owner/bloc/vehicle_owner_profile_bloc.dart';
import 'package:car_rent/core/common/constants.dart';
import 'package:car_rent/core/common/entities/location.dart';
import 'package:car_rent/core/common/widgets/price_display.dart';
import 'package:car_rent/core/utils/distance_utils.dart';
import 'package:car_rent/core/utils/location_selector.dart';
import 'package:car_rent/core/utils/location_utils.dart';
import 'package:car_rent/features/car/presentation/widgets/car_rent_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectPickupAndReturn extends StatefulWidget {
  final Function(String, String, double) onConfirm;
  final String hostId;

  const SelectPickupAndReturn(
      {Key? key, required this.onConfirm, required this.hostId})
      : super(key: key);

  @override
  State<SelectPickupAndReturn> createState() => _SelectPickupAndReturnState();
}

class _SelectPickupAndReturnState extends State<SelectPickupAndReturn> {
  int selectedOptionIndex = -1;
  double? _containerHeight;
  bool bigmap = false;

  Location? userSelectedLocation;
  // Map<String, double>? hostlocation;
  Location? hostlocation;
  Location? userlocation;

  final stationLocation = Constants.stationLocation;
  List<Map<String, dynamic>> options = Constants.options;

  @override
  void initState() {
    super.initState();
    _containerHeight = 0;
    _fetchHostLocation();
    _fetchUserLocation();
  }

  void _fetchHostLocation() {
    final vehicleOwnerProfileState =
        context.read<VehicleOwnerProfileBloc>().state;
    if (vehicleOwnerProfileState is VehicleOwnerProfileLoadSuccess) {
      if (vehicleOwnerProfileState.vehicleOwnerProfile.location != null) {
        Location formattedhostlocation = LocationUtils.parseLocation(
            vehicleOwnerProfileState.vehicleOwnerProfile.location!);
        setState(() {
          hostlocation = formattedhostlocation;
        });
      }
    }
  }

  void _fetchUserLocation() {
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoadSuccess) {
      if (profileState.profile.location != null) {
        Location formatteduserlocation =
            LocationUtils.parseLocation(profileState.profile.location!);
        options.removeWhere((option) => option['title'] == 'Your Location');
        setState(() {
          userlocation = formatteduserlocation;
          options.add({
            'title': 'Your Location',
            'description': 'Your current location',
            'lat': formatteduserlocation.latitude,
            'lon': formatteduserlocation.longitude,
            'price': null, // Dynamic price based on distance
          });
        });
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _containerHeight = MediaQuery.of(context).size.height * 0.3;
  }

  void _increaseHeight() {
    setState(() {
      bigmap = true;
      _containerHeight = MediaQuery.of(context).size.height * 0.685;
    });
  }

  void _decreaseHeight() {
    setState(() {
      bigmap = false;
      _containerHeight = MediaQuery.of(context).size.height * 0.3;
    });
  }

  void _handleLocationSelected(Location location) {
    _increaseHeight();
    setState(() {
      userSelectedLocation = location;
    });
  }

  void _confirmSelection() {
    if (userSelectedLocation != null) {
      final distance = DistanceUtils.calculateDistance(
        stationLocation['lat']!,
        stationLocation['lon']!,
        userSelectedLocation!.latitude,
        userSelectedLocation!.longitude,
      );
      final price =
          distance * Constants.perkmprice; // Dynamic location price multiplier
      widget.onConfirm(
        '${userSelectedLocation!.latitude}, ${userSelectedLocation!.longitude}',
        '${userSelectedLocation!.latitude}, ${userSelectedLocation!.longitude}',
        price,
      );
      Navigator.pop(context);
    } else if (selectedOptionIndex != -1) {
      final selectedLocation = options[selectedOptionIndex];
      final distance = DistanceUtils.calculateDistance(
        stationLocation['lat']!,
        stationLocation['lon']!,
        selectedLocation['lat']!,
        selectedLocation['lon']!,
      );
      final price =
          selectedLocation['price'] ?? (distance * Constants.perkmprice);
      widget.onConfirm(
        '${selectedLocation['lat']}, ${selectedLocation['lon']}',
        '${selectedLocation['lat']}, ${selectedLocation['lon']}',
        price,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasHostLocation =
        hostlocation?.latitude != null && hostlocation?.longitude != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _containerHeight,
                child:
                    LocationPicker(onLocationSelected: _handleLocationSelected),
              ),
              Positioned(
                top: 10.0,
                right: 10.0,
                child: GestureDetector(
                  onTap: bigmap ? _decreaseHeight : _increaseHeight,
                  child: Icon(
                    bigmap ? Icons.zoom_out_outlined : Icons.zoom_in_outlined,
                    color: Colors.black,
                    size: 40.0,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pickup and Return Locations",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (!hasHostLocation)
                    const Text(
                      "Note: Distance is calculated from the station location.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final option = options[index];

                        final double distance = option['price'] == null
                            ? DistanceUtils.calculateDistance(
                                hasHostLocation
                                    ? hostlocation!.latitude
                                    : stationLocation['lat']!,
                                hasHostLocation
                                    ? hostlocation!.longitude
                                    : stationLocation['lon']!,
                                option['lat']!,
                                option['lon']!,
                              )
                            : 0.0;

                        final price = option['price'] ??
                            (distance * Constants.perkmprice);
                        return _buildOption(
                          index: index,
                          title: option['title']!,
                          description: option['description']!,
                          price: price.toStringAsFixed(2),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  CarRentGradientButton(
                    buttonText: "Confirm",
                    color: (selectedOptionIndex == -1 &&
                            userSelectedLocation == null)
                        ? Colors.black26
                        : const Color(0xFF32D34B),
                    onPressed: (selectedOptionIndex != -1 ||
                            userSelectedLocation != null)
                        ? _confirmSelection
                        : () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption({
    required int index,
    required String title,
    required String description,
    required String price,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOptionIndex = index;
          userSelectedLocation = null;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: selectedOptionIndex == index ? Colors.green[50] : Colors.white,
          border: Border.all(
            color:
                selectedOptionIndex == index ? Colors.green : Colors.grey[300]!,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Icon(
              selectedOptionIndex == index
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: selectedOptionIndex == index ? Colors.green : Colors.grey,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            PriceDisplay(
              price: price, // Your price value
            )
          ],
        ),
      ),
    );
  }
}
