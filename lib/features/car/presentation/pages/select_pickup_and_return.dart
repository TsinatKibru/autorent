import 'package:car_rent/features/car/presentation/widgets/car_rent_gradient_button.dart';
import 'package:flutter/material.dart';

class SelectPickupAndReturn extends StatefulWidget {
  const SelectPickupAndReturn({Key? key}) : super(key: key);

  @override
  State<SelectPickupAndReturn> createState() => _SelectPickupAndReturnState();
}

class _SelectPickupAndReturnState extends State<SelectPickupAndReturn> {
  int selectedOptionIndex = -1; // No option selected initially

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Pickup and Return'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Column(
        children: [
          // Map image at the top
          Container(
            height: MediaQuery.of(context).size.height * 0.3, // 2/5 of space
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/map.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Options area
          Expanded(
            child: Container(
              color: Colors.grey[100], // Subtle gray background
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pickup Locations",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Options list
                  Expanded(
                    child: ListView.builder(
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final option = options[index];
                        return _buildOption(
                          index: index,
                          title: option['title']!,
                          description: option['description']!,
                          price: option['price']!,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  CarRentGradientButton(
                    buttonText: "Confirm",
                    color: selectedOptionIndex == -1
                        ? Colors.black26
                        : const Color(0xFF32D34B),
                    onPressed:
                        selectedOptionIndex != -1 ? _confirmSelection : () {},
                  ),
                  // Confirm button
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
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: selectedOptionIndex == index
              ? Colors.green[50]
              : Colors.white, // Highlight selected option
          border: Border.all(
            color:
                selectedOptionIndex == index ? Colors.green : Colors.grey[300]!,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            // Selection box
            Icon(
              selectedOptionIndex == index
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: selectedOptionIndex == index ? Colors.green : Colors.grey,
            ),
            const SizedBox(width: 16),
            // Option details
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
            // Price
            Text(
              price,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmSelection() {
    final selectedOption = options[selectedOptionIndex];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "You selected: ${selectedOption['title']} - ${selectedOption['price']}",
        ),
      ),
    );
  }

  // Options data
  final List<Map<String, String>> options = [
    {
      "title": "Standard Pickup",
      "description": "Pickup from your location within 10 km.",
      "price": "\$10",
    },
    {
      "title": "Premium Pickup",
      "description": "Faster pickup with extra comfort.",
      "price": "\$20",
    },
    {
      "title": "Return at Station",
      "description": "Return the vehicle at the nearest station.",
      "price": "Free",
    },
    {
      "title": "Home Return",
      "description": "Vehicle pickup from your home.",
      "price": "\$15",
    },
  ];
}
