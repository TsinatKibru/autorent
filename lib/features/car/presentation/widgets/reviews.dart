import 'package:car_rent/core/common/bloc/rating/rating_bloc.dart';
import 'package:car_rent/core/common/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/core/common/entities/rating.dart';

class ReviewsSection extends StatefulWidget {
  final int vehicleId;
  const ReviewsSection({Key? key, required this.vehicleId}) : super(key: key);

  @override
  State<ReviewsSection> createState() => _ReviewsSectionState();
}

class _ReviewsSectionState extends State<ReviewsSection> {
  @override
  void initState() {
    super.initState();
    context
        .read<RatingBloc>()
        .add(FetchRatingsByVehicleIdEvent(widget.vehicleId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatingBloc, RatingState>(
      builder: (context, state) {
        if (state is RatingLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RatingLoadSuccess) {
          final ratings = state.ratings;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAverageReviewDetails(ratings),
                const SizedBox(height: 16),
                _buildReviewList(ratings),
              ],
            ),
          );
        } else if (state is RatingFailure) {
          return const Center(
            child: Text(
              "Failed to load ratings ...",
              style: TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(
            child: Text(
              "No ratings available.",
              style: TextStyle(color: Colors.grey),
            ),
          );
        }
      },
    );
  }

  Widget _buildReviewList(List<Rating> ratings) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: ratings.map((rating) => _buildReviewCard(rating)).toList(),
        ),
      ),
    );
  }

  Widget _buildReviewCard(Rating rating) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 234, 251, 234),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomImage(
                imageUrl: rating.profile.avatar ?? "",
                height: 40,
                width: 40,
                borderRadius: BorderRadius.circular(20),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rating.profile.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    "${rating.date.day}/${rating.date.month}/${rating.date.year}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                Icons.star,
                color: index < rating.overallRating.floor()
                    ? AppPalette.primaryColor
                    : Colors.grey[300],
                size: 16,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            rating.comment ?? "No comment provided.",
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildAverageReviewDetails(List<Rating> ratings) {
    if (ratings.isEmpty) {
      return Center(
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Colors.green[50], // Light green background
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star_border_purple500_rounded,
                  size: 56,
                  color: Colors
                      .green[400], // Vibrant green for an eye-catching effect
                ),
                const SizedBox(height: 12),
                Text(
                  "No ratings yet",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700], // Darker green for contrast
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Be the first to leave a review and help others!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.green[600]),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement review submission functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text(
                    "Rent a car to Write a Review",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final double averageRating =
        ratings.map((rating) => rating.overallRating).reduce((a, b) => a + b) /
            ratings.length;

    final double averageCleanliness =
        ratings.map((rating) => rating.cleanliness).reduce((a, b) => a + b) /
            ratings.length;

    final double averageMaintenance =
        ratings.map((rating) => rating.maintenance).reduce((a, b) => a + b) /
            ratings.length;

    final double averageCommunication =
        ratings.map((rating) => rating.communication).reduce((a, b) => a + b) /
            ratings.length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Rating and Reviews",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: AppPalette.primaryColor, size: 20),
              const SizedBox(width: 4),
              Text(
                averageRating.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "• ${ratings.length} ${ratings.length == 1 ? "review" : "reviews"}",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _RatingDetailRow(
            label: "Cleanliness",
            value: averageCleanliness.toStringAsFixed(1),
          ),
          const SizedBox(height: 8),
          _RatingDetailRow(
            label: "Maintenance",
            value: averageMaintenance.toStringAsFixed(1),
          ),
          const SizedBox(height: 8),
          _RatingDetailRow(
            label: "Communication",
            value: averageCommunication.toStringAsFixed(1),
          ),
        ],
      ),
    );
  }
}

class _RatingDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _RatingDetailRow({
    required this.label,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: LinearProgressIndicator(
            value: double.parse(value) / 5,
            backgroundColor: Colors.grey[200],
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppPalette.primaryColor),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
