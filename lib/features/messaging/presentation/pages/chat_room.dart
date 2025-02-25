// import 'package:flutter/material.dart';

// class ChatRoom extends StatelessWidget {
//   final String selectedUser;

//   ChatRoom({required this.selectedUser});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Color(0xFFF9F9F9), // Very light gray
//             Color(0xFFE9F7EF), // Light mint
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: Column(
//         children: [
//           // Chat Messages Section
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(16.0),
//               itemCount: 10, // Example message count
//               itemBuilder: (context, index) {
//                 bool isSender = index % 2 == 0;
//                 return Align(
//                   alignment:
//                       isSender ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(vertical: 4.0),
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 12.0, vertical: 8.0),
//                     decoration: BoxDecoration(
//                       color: isSender
//                           ? Colors.blue.shade100
//                           : Colors.grey.shade200,
//                       borderRadius: BorderRadius.only(
//                         topLeft: const Radius.circular(12),
//                         topRight: const Radius.circular(12),
//                         bottomLeft:
//                             isSender ? const Radius.circular(12) : Radius.zero,
//                         bottomRight:
//                             isSender ? Radius.zero : const Radius.circular(12),
//                       ),
//                     ),
//                     child: Text(
//                       isSender
//                           ? "Message from $selectedUser"
//                           : "Your message here",
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           // Message Input Field
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 const Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Type a message...',
//                       border: OutlineInputBorder(),
//                       contentPadding: EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 12.0),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: () {
//                     // Handle sending message
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
