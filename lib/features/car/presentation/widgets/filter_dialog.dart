import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  final Function(String) onSearch;

  const FilterDialog({Key? key, required this.onSearch}) : super(key: key);

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  TextEditingController priceController = TextEditingController();
  TextEditingController speedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // Set a fixed height for the dialog
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title & Close Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Filter Options",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Filter by Price
          TextField(
            controller: priceController,
            decoration: const InputDecoration(
              labelText: "Price (≥)",
              hintText: "Enter minimum price",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  speedController.clear();
                });
              }
            },
          ),
          const SizedBox(height: 12),

          // Filter by Speed
          TextField(
            controller: speedController,
            decoration: const InputDecoration(
              labelText: "Speed (≥)",
              hintText: "Enter minimum speed",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  priceController.clear();
                });
              }
            },
          ),
          const SizedBox(height: 20),

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  widget.onSearch(""); // Clear search query
                  Navigator.pop(context, "");
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  side: BorderSide(
                      color: Colors.green.withOpacity(0.6), width: 1),
                ),
                child: const Text(
                  "Clear Filters",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  String priceText = priceController.text.trim();
                  String speedText = speedController.text.trim();

                  String searchQuery = "";
                  if (priceText.isNotEmpty) {
                    searchQuery = "price:$priceText";
                  } else if (speedText.isNotEmpty) {
                    searchQuery = "speed:$speedText";
                  }

                  widget.onSearch(searchQuery);
                  Navigator.pop(context, searchQuery);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Apply Filters",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
