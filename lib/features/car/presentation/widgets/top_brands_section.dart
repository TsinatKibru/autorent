import 'package:flutter/material.dart';

class TopBrandsSection extends StatefulWidget {
  final Function(String) onBrandSelected;

  const TopBrandsSection({super.key, required this.onBrandSelected});

  @override
  _TopBrandsSectionState createState() => _TopBrandsSectionState();
}

class _TopBrandsSectionState extends State<TopBrandsSection> {
  String selectedBrand = 'All'; // Track the selected brand
  bool showAll = false;

  final List<Map<String, String>> carBrandAssets = [
    {'asset': 'assets/icon/four-circle.png', 'name': 'All'},
    {'asset': 'assets/icon/icons8-tesla-48.png', 'name': 'Tesla'},
    {'asset': 'assets/icon/icons8-bmw-48.png', 'name': 'BMW'},
    {'asset': 'assets/icon/icons8-ferrari-48.png', 'name': 'Ferrari'},
    {'asset': 'assets/icon/icons8-audi-48.png', 'name': 'Audi'},
    {'asset': 'assets/icon/icons8-mercedes-benz-48.png', 'name': 'Mercedes'},
    {'asset': 'assets/icon/icons8-porsche-48.png', 'name': 'Porsche'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row with "Top Brands" and "View All"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Top Brands",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showAll = !showAll;
                  });
                },
                child: Text(
                  showAll ? "View Less" : "View More",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),

          // Scrollable list of car brand logos
          SizedBox(
            height: 120, // Adjusted height for the logo container
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: carBrandAssets.length,
              itemBuilder: (context, index) {
                String brandName = carBrandAssets[index]['name']!;
                bool isSelected = brandName == selectedBrand;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedBrand = brandName;
                    });
                    widget.onBrandSelected(brandName);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Outer Circle with Border and Inner Circle for Image
                        Container(
                          width: showAll ? 60 : 80, // Outer circle width
                          height: showAll ? 60 : 80, // Outer circle height
                          decoration: BoxDecoration(
                            shape:
                                BoxShape.circle, // Makes the container circular
                            border: Border.all(
                              color: isSelected
                                  ? const Color.fromARGB(255, 177, 228, 179)
                                  : Colors.black12,
                              width: 2, // Thicker border for selected brand
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: Colors.green[50]!,
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    )
                                  ]
                                : [],
                          ),
                          child: ClipOval(
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  12.0), // Gap between the image and border
                              child: ClipOval(
                                child: Image.asset(
                                  carBrandAssets[index]['asset']!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        // Name under the image
                        Text(
                          carBrandAssets[index]['name']!,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
