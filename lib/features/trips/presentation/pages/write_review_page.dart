import 'package:car_rent/core/common/bloc/profile/profile_bloc.dart';
import 'package:car_rent/core/common/bloc/rating/rating_bloc.dart';
import 'package:car_rent/core/common/entities/profile.dart';
import 'package:car_rent/core/common/entities/rating.dart';
import 'package:car_rent/features/car/domain/entities/vehicle.dart';
import 'package:car_rent/features/car/presentation/bloc/vehicle_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class WriteReviewPage extends StatefulWidget {
  final Vehicle vehicle;

  const WriteReviewPage({super.key, required this.vehicle});

  @override
  _WriteReviewPageState createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  int cleanliness = 3;
  int maintenance = 3;
  int communication = 3;
  double overallRating = 3.0;
  TextEditingController commentController = TextEditingController();
  Profile? _currentUserProfile;

  @override
  void initState() {
    super.initState();

    // Retrieve the current user's profile
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoadSuccess) {
      _currentUserProfile = profileState.profile;
    }
  }

  void submitReview() {
    // Handle review submission logic here

    if (widget.vehicle.host == _currentUserProfile!.id) {
      _showSnackbar(context, "You cannot rate yourself", "error");
      return;
    }

    overallRating = (cleanliness + maintenance + communication) / 3;

    AverageRating rating = AverageRating(
      id: 3,
      profileId: _currentUserProfile!.id,
      vehicleId: widget.vehicle.id,
      cleanliness: cleanliness,
      maintenance: maintenance,
      communication: communication,
      overallRating: overallRating,
      comment: commentController.text,
      date: DateTime.now(),
    );

    context.read<RatingBloc>().add(CreateRatingEvent(rating));
  }

  void _showSnackbar(BuildContext context, String message, String type) {
    if (type == "success") {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: message,
          backgroundColor: const Color.fromARGB(255, 4, 190, 100),
        ),
      );
    } else {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: message,
        ),
      );
    }
  }

  Widget buildRatingRow(String title, int rating, Function(int) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(child: Text(title, style: const TextStyle(fontSize: 15))),
        Row(
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
              onPressed: () => onChanged(index + 1),
            );
          }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Write a Review"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocListener<RatingBloc, RatingState>(
                listener: (context, state) {
                  if (state is RatingLoadSuccess) {
                    double sum = 0; // Using double for accuracy

                    for (var i = 0; i < state.ratings.length; i++) {
                      sum +=
                          state.ratings[i].overallRating; // Correct list access
                    }

                    double averageRating = sum / state.ratings.length;
                    context.read<VehicleBloc>().add(UpdateVehicleEvent(
                        widget.vehicle.id,
                        widget.vehicle.copyWith(
                            rating: averageRating,
                            numberOfTrips:
                                (widget.vehicle.numberOfTrips ?? 0) + 1)));
                    _showSnackbar(context, "Rating Submitted!", "success");
                    Navigator.pop(context); // Navigate back after success
                  } else if (state is RatingFailure) {
                    _showSnackbar(
                        context, "Rating Submission Failed!", "error");
                  }
                },
                child: Container(), // Add an empty Container as the child
              ),
              buildRatingRow("Cleanliness", cleanliness, (val) {
                setState(() => cleanliness = val);
              }),
              buildRatingRow("Maintenance", maintenance, (val) {
                setState(() => maintenance = val);
              }),
              buildRatingRow("Communication", communication, (val) {
                setState(() => communication = val);
              }),
              const SizedBox(height: 40),
              TextField(
                controller: commentController,
                decoration: const InputDecoration(
                  labelText: "Write your comment...",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: submitReview,
                  child: const Text(
                    "Submit Review",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
