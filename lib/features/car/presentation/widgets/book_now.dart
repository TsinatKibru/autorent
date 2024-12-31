import 'package:flutter/material.dart';

class BookNowWidget extends StatelessWidget {
  const BookNowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Car Details"),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Stack(
        children: [
          // Main Content
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 600, // Replace with actual content's height
                  color: Colors.grey[200],
                  child: const Center(
                    child: Text("Car Details Content"),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Book Now Section
          LayoutBuilder(
            builder: (context, constraints) {
              return DraggableScrollableSheet(
                initialChildSize: 0.12, // Visible area when collapsed
                minChildSize: 0.12, // Minimum height
                maxChildSize: 0.3, // Maximum height
                builder: (context, scrollController) {
                  return Container(
                    constraints: BoxConstraints(
                      maxHeight: constraints.maxHeight,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8.0,
                          offset: Offset(0, -2),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          // Pull-up Indicator
                          Center(
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "\$120",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        Text(
                                          "\$150",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4.0),
                                    const Text(
                                      "Save \$30 by booking now",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Handle booking action
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24.0, vertical: 12.0),
                                    child: Text(
                                      "Book Now",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 1, color: Colors.grey),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Cancellation Policy",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  "Free cancellation up to 5 days before the trip.",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
