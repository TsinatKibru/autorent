import 'package:car_rent/core/common/bloc/trip/trip_bloc.dart';
import 'package:car_rent/core/common/entities/rental.dart';
import 'package:car_rent/core/common/entities/trip.dart';
import 'package:car_rent/core/common/widgets/custom_image.dart';
import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/core/utils/date_time_utils.dart';
import 'package:car_rent/core/utils/show_snackbar.dart';
import 'package:car_rent/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:car_rent/features/car/presentation/widgets/car_rent_gradient_button.dart';
import 'package:car_rent/features/messaging/presentation/pages/message_page.dart';
import 'package:car_rent/features/trips/presentation/pages/trip_details_page.dart';
import 'package:car_rent/features/trips/presentation/pages/write_review_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TripsPage extends StatefulWidget {
  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  String? _currentUserId;
  String? _selectedStatus;
  DateTime? _startDate;
  DateTime? _endDate;
  int _currentPage = 1;
  final int _itemsPerPage = 10; // Number of items per page

  @override
  void initState() {
    super.initState();

    final userState = context.read<AuthBloc>().state;

    if (userState is AuthSuccess) {
      _currentUserId = userState.user.id;
      if (_currentUserId != null) {
        context.read<TripBloc>().add(
              FetchTripsByProfileIdEvent(
                profileId: _currentUserId!,
                host: false,
                status: _selectedStatus,
                startDate: _startDate,
                endDate: _endDate,
                limit: _itemsPerPage,
                offset: (_currentPage - 1) * _itemsPerPage,
              ),
            );
      }
      _fetchTrips();
    }
  }

  void _fetchTrips() {
    if (_currentUserId != null) {
      context.read<TripBloc>().add(
            SubscribeToTripsChangesEvent(
              profileId: _currentUserId!,
              host: false,
              status: _selectedStatus,
              startDate: _startDate,
              endDate: _endDate,
              limit: _itemsPerPage,
              offset: (_currentPage - 1) * _itemsPerPage,
            ),
          );
    }
  }

  void _applyFilters() {
    setState(() {
      // Reset to the first page when applying filters
      _fetchTrips();
      _currentPage = 1;
    });
  }

  void _nextPage() {
    setState(() {
      _currentPage++;
      _fetchTrips();
    });
  }

  void _previousPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
        _fetchTrips();
      });
    }
  }

  Future<DateTime?> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    } else {
      setState(() {
        if (isStartDate) {
          _startDate = null;
        } else {
          _endDate = null;
        }
      });
    }

    return picked;
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // Allows the modal to take up more space if needed
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, // Prevents the modal from taking up unnecessary space
                children: [
                  _buildStatusFilter(setModalState),
                  const SizedBox(height: 16.0),
                  _buildDateRangeFilter(setModalState),
                  const SizedBox(height: 16.0),
                  _buildApplyButton(context),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'Your Trips',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterModal,
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: _previousPage,
                  tooltip: 'Previous Page',
                ),
                Text('Page $_currentPage'),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: _nextPage,
                  tooltip: 'Next Page',
                ),
              ],
            ),
          ),
          // Trip List
          Expanded(
            child: BlocBuilder<TripBloc, TripState>(
              builder: (context, state) {
                if (state is TripLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TripLoadSuccess) {
                  final trips = state.trips;
                  if (trips.isEmpty) {
                    return const Center(
                      child: Text(
                        'No trips found.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: trips.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                    itemBuilder: (context, index) {
                      final trip = trips[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.black12,
                              width: 0.5,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildCarImage(trip.vehicle.gallery![0]),
                              const SizedBox(width: 16.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildCarDetails(
                                      model: trip.vehicle.model,
                                      status: trip.status,
                                      arrivalTime:
                                          DateTimeUtils.getfullformmatedtime(
                                              trip.createdAt),
                                    ),
                                    const SizedBox(height: 8.0),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  _tripActionButton(context, trip),
                                  _buildDetailsButton(context, trip),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is TripFailure) {
                  showSnackbar(context, state.message);
                }

                return const Center(
                  child: Text(
                    'Please wait...',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          // Pagination Controls

          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget _buildCarImage(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        height: 125,
        width: 110,
        child: CustomImage(imageUrl: imagePath, height: 115, width: 125),
      ),
    );
  }

  Widget _buildCarDetails({
    required String model,
    required String status,
    required String arrivalTime,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            status,
            style: TextStyle(
              fontSize: 16,
              color: status == 'completed' ? Colors.green : Colors.orange,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (arrivalTime.isNotEmpty) ...[
            const SizedBox(height: 8.0),
            Row(
              children: [
                Flexible(
                  child: Text(
                    arrivalTime,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _tripActionButton(BuildContext context, Trip trip) {
    return trip.status == "completed"
        ? IconButton(
            icon: const Icon(Icons.rate_review, color: Colors.orange, size: 24),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WriteReviewPage(
                    vehicle: trip.vehicle,
                  ),
                ),
              );
            },
            tooltip: "Write a Review",
          )
        : IconButton(
            icon: const Icon(Icons.message, color: AppPalette.primaryColor),
            onPressed: () {
              Rental messagetopic = Rental(
                id: trip.id,
                vehicleId: trip.vehicle.id,
                profileId: trip.profile.id,
                hostId: trip.host.id,
                startTime: trip.startTime,
                endTime: trip.endTime,
                pickupLocation: trip.pickupLocation,
                totalCost: trip.totalCost,
                status: trip.status,
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessagesPage(rental: messagetopic),
                ),
              );
            },
            tooltip: "Message Support",
          );
  }

  Widget _buildDetailsButton(BuildContext context, Trip trip) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppPalette.primaryColor, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TripDetailsPage(
              trip: trip,
            ),
          ),
        );
      },
      child: const Text(
        "Details",
        style: TextStyle(
          fontSize: 14,
          color: AppPalette.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildStatusFilter(Function setModalState) {
    return DropdownButtonFormField<String>(
      value: _selectedStatus,
      decoration: const InputDecoration(
        labelText: 'Filter by Status',
        border: OutlineInputBorder(),
      ),
      items: <String>['All', 'pending', 'completed', 'cancelled']
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value == "All" ? null : value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setModalState(() {
          _selectedStatus = newValue;
        });
      },
    );
  }

  Widget _buildDateRangeFilter(Function setModalState) {
    return Row(
      children: [
        Expanded(
          child: TextButton.icon(
            onPressed: () async {
              DateTime? picked = await _selectDate(context, true);

              setModalState(() {
                _startDate = picked;
              });
            },
            icon: const Icon(Icons.calendar_today),
            label: Text(
              _startDate == null
                  ? 'Select Start Date'
                  : 'Start: ${DateTimeUtils.getfullformmatedtime(_startDate!)}',
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: TextButton.icon(
            onPressed: () async {
              DateTime? picked = await _selectDate(context, false);

              setModalState(() {
                _endDate = picked;
              });
            },
            icon: const Icon(Icons.calendar_today),
            label: Text(
              _endDate == null
                  ? 'Select End Date'
                  : 'End: ${DateTimeUtils.getfullformmatedtime(_endDate!)}',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildApplyButton(BuildContext context) {
    return CarRentGradientButton(
        buttonText: "Apply Filters",
        onPressed: () {
          if (_startDate != null &&
              _endDate != null &&
              _startDate!.isAfter(_endDate!)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Start date must be before end date')),
            );
            return;
          }
          setState(() {
            _applyFilters();
          });
          Navigator.pop(context); // Close modal after applying
        });
  }
}
