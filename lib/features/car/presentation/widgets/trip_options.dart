import 'package:car_rent/core/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/features/car/presentation/pages/select_trip_date_and_time.dart';
import 'package:car_rent/features/car/presentation/pages/select_pickup_and_return.dart';

class TripOptions extends StatefulWidget {
  final Function(Map<String, dynamic>) onTripDatesSelected;
  final Function(String, String, double) onPickupAndReturnSelected;
  final String hostId;

  const TripOptions({
    Key? key,
    required this.onTripDatesSelected,
    required this.onPickupAndReturnSelected,
    required this.hostId,
  }) : super(key: key);

  @override
  _TripOptionsState createState() => _TripOptionsState();
}

class _TripOptionsState extends State<TripOptions> {
  DateTime? selectedInitialDate;
  DateTime? selectedReturnDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Trip Dates",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SelectTripDateAndTime(),
                ),
              );

              if (result != null && result is Map<String, dynamic>) {
                setState(() {
                  selectedInitialDate = result['initialDate'];

                  selectedReturnDate = result['returnDate'];
                });
                //  selectedInitialDate = result['initialDate'] != null
                //       ? result['initialDate']
                //       : null;

                //   selectedReturnDate = result['returnDate'] != null
                //       ? result['returnDate']
                //       : null;

                print("Here are the results: $result");

                widget.onTripDatesSelected(result);
              }
            },
            child: _buildOptionRow(
              Icons.calendar_today,
              selectedReturnDate != null
                  ? "${DateTimeUtils.getMonthNameWithDay(selectedInitialDate!)} - ${DateTimeUtils.getMonthNameWithDay(selectedReturnDate!)} "
                  : "AnyTime",
              "Add dates >",
            ),
          ),
        ),
        const SizedBox(height: 32.0),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Pickup & Return",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectPickupAndReturn(
                    onConfirm: widget.onPickupAndReturnSelected,
                    hostId: widget.hostId,
                  ),
                ),
              );
            },
            child: _buildOptionRow(
              Icons.location_on,
              "Pickup and Return",
              "Change >",
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionRow(IconData icon, String title, String action) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: AppPalette.primaryColor),
              const SizedBox(width: 8.0),
              Text(title, style: const TextStyle(fontSize: 16)),
            ],
          ),
          Text(
            action,
            style: const TextStyle(
                fontSize: 14,
                color: AppPalette.primaryColor,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
