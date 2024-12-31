import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  final Function(String) onUserSelected;

  UserList({required this.onUserSelected});

  @override
  Widget build(BuildContext context) {
    final List<String> users = ['John Doe', 'Host Name', 'Jane Smith'];
    final String vehicleModel = "Tesla Model X";
    final String rentalStatus = "Pending";
    final String paymentMethod = "Credit Card";

    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       Color(0xFFF9F9F9), // Very light gray
        //       Color(0xFFE9F7EF), // Light mint
        //     ],
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //   ),
        // ),
        child: Column(
          children: [
            // Card on Top: Pending Vehicle Information
            // Card(
            //   margin: EdgeInsets.all(16.0),
            //   elevation: 8.0, // Added more elevation for a more prominent card
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(12.0),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         // Text(
            //         //   'Pending Vehicle Request',
            //         //   style: TextStyle(
            //         //     fontWeight: FontWeight.bold,
            //         //     fontSize: 18.0,
            //         //     color: Colors.teal, // Highlighting the title color
            //         //   ),
            //         // ),
            //         // SizedBox(height: 8.0),
            //         Text(
            //           'Vehicle: $vehicleModel',
            //           style: TextStyle(fontSize: 16.0),
            //         ),
            //         Text(
            //           'Status: $rentalStatus',
            //           style: TextStyle(
            //               fontSize: 16.0,
            //               decorationStyle: TextDecorationStyle.wavy),
            //         ),
            //         Text(
            //           'Payment Method: $paymentMethod',
            //           style: TextStyle(fontSize: 16.0),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Card(
              margin: const EdgeInsets.all(16.0),
              elevation: 8.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0), // Top-left corner rounded
                  topRight: Radius.circular(20.0), // Top-right corner rounded
                  bottomRight:
                      Radius.circular(20.0), // Bottom-right corner rounded
                  bottomLeft:
                      Radius.zero, // No rounding on the bottom-left corner
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vehicle: $vehicleModel',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      'Status: $rentalStatus',
                      style: const TextStyle(
                        fontSize: 16.0,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    ),
                    Text(
                      'Payment Method: $paymentMethod',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),

            // // User List
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? Colors.blue.shade50
                          : Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: AppPalette.primaryColor,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(
                        users[index],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text('Last message here...'),
                      trailing: const Text(
                        '12:30 PM',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                      onTap: () {
                        onUserSelected(users[index]);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
