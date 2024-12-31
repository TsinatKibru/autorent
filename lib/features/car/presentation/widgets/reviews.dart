import 'package:flutter/material.dart';
import 'package:car_rent/core/theme/app_pallete.dart';

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(5, (index) => _buildReviewCard()),
        ),
      ),
    );
  }

  Widget _buildReviewCard() {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 234, 251, 234),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage('assets/images/host.jpeg'),
              ),
              const SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Jane Smith",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    "Dec 12, 2023",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Row(
            children: List.generate(
              5,
              (index) => const Icon(
                Icons.star,
                color: AppPalette.primaryColor,
                size: 16,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          const Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque in risus a elit aliquet.",
            style: TextStyle(
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
}
