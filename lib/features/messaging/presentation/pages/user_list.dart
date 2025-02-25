// import 'package:car_rent/core/theme/app_pallete.dart';
// import 'package:flutter/material.dart';

// class UserList extends StatelessWidget {
//   final Function(String) onUserSelected;

//   UserList({required this.onUserSelected});

//   @override
//   Widget build(BuildContext context) {
//     final List<String> users = ['John Doe', 'Host Name', 'Jane Smith'];
//     final String vehicleModel = "Tesla Model X";
//     final String rentalStatus = "Pending";
//     final String paymentMethod = "Credit Card";

//     return Scaffold(
//       body: Container(
//         child: Column(
//           children: [
//             Card(
//               margin: const EdgeInsets.all(16.0),
//               elevation: 8.0,
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20.0), // Top-left corner rounded
//                   topRight: Radius.circular(20.0), // Top-right corner rounded
//                   bottomRight:
//                       Radius.circular(20.0), // Bottom-right corner rounded
//                   bottomLeft:
//                       Radius.zero, // No rounding on the bottom-left corner
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Vehicle: $vehicleModel',
//                       style: const TextStyle(fontSize: 16.0),
//                     ),
//                     Text(
//                       'Status: $rentalStatus',
//                       style: const TextStyle(
//                         fontSize: 16.0,
//                         decorationStyle: TextDecorationStyle.wavy,
//                       ),
//                     ),
//                     Text(
//                       'Payment Method: $paymentMethod',
//                       style: const TextStyle(fontSize: 16.0),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // // User List
//             Expanded(
//               child: ListView.builder(
//                 itemCount: users.length,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     margin: const EdgeInsets.symmetric(
//                         vertical: 8.0, horizontal: 16.0),
//                     decoration: BoxDecoration(
//                       color: index % 2 == 0
//                           ? Colors.blue.shade50
//                           : Colors.green.shade50,
//                       borderRadius: BorderRadius.circular(12.0),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: ListTile(
//                       leading: const CircleAvatar(
//                         backgroundColor: AppPalette.primaryColor,
//                         child: Icon(Icons.person, color: Colors.white),
//                       ),
//                       title: Text(
//                         users[index],
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: const Text('Last message here...'),
//                       trailing: const Text(
//                         '12:30 PM',
//                         style: TextStyle(
//                           fontSize: 12.0,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       onTap: () {
//                         onUserSelected(users[index]);
//                       },
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
