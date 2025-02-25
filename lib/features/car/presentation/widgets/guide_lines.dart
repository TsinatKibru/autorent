import 'package:flutter/material.dart';

class GuideLines extends StatefulWidget {
  final String guidelinesnote;
  const GuideLines({Key? key, required this.guidelinesnote}) : super(key: key);

  @override
  _GuideLinesState createState() => _GuideLinesState();
}

class _GuideLinesState extends State<GuideLines> {
  @override
  Widget build(BuildContext context) {
    final guidelinesnote = widget.guidelinesnote;
    final List<String> guidelines = [
      "No pets allowed, No smoking, Strictly enforced",
      "Return clean, or be prepared to pay for clean up",
      guidelinesnote
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Guidelines",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: guidelines.map((guideline) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 5.0, // Adjust the size of the bullet
                      height: 5.0, // Adjust the size of the bullet
                      margin: const EdgeInsets.only(top: 6.0, right: 8.0),
                      decoration: const BoxDecoration(
                        color: Colors.black45,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        guideline,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
