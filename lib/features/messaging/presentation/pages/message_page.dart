// import 'package:flutter/material.dart';

// class MessagePage extends StatelessWidget {
//   final String customerName = "John Doe";
//   final String hostName = "Host Name";
//   final String vehicleModel = "Tesla Model X";
//   final String rentalStatus = "Pending"; // Or Active, Completed, etc.
//   final String paymentMethod = "Credit Card"; // Or Cash

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Messages'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Rental Information
//             Card(
//               margin: EdgeInsets.only(bottom: 20.0),
//               child: Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Vehicle: $vehicleModel',
//                         style: TextStyle(fontWeight: FontWeight.bold)),
//                     Text('Status: $rentalStatus'),
//                     Text('Payment Method: $paymentMethod'),
//                   ],
//                 ),
//               ),
//             ),
//             // Message List
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 10, // Example count of messages
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     leading: CircleAvatar(
//                       child: Icon(Icons.person),
//                     ),
//                     title: Text(index % 2 == 0 ? customerName : hostName),
//                     subtitle: Text('Message content goes here...'),
//                     trailing: Text('12:30 PM'),
//                     tileColor: index % 2 == 0
//                         ? Colors.blue.shade50
//                         : Colors.green.shade50,
//                   );
//                 },
//               ),
//             ),
//             // Message Input Field
//             Padding(
//               padding: const EdgeInsets.only(top: 8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: 'Type a message...',
//                         border: OutlineInputBorder(),
//                         contentPadding: EdgeInsets.symmetric(
//                             vertical: 10.0, horizontal: 12.0),
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.send),
//                     onPressed: () {
//                       // Handle sending message
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: Container(
//         margin: EdgeInsets.only(bottom: 80.0),
//         child: FloatingActionButton(
//           onPressed: () {
//             // Send message or initiate a conversation
//           },
//           child: Icon(Icons.send),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'chat_room.dart'; // Import your chat room widget
import 'user_list.dart'; // Import your user list widget

class MessagePage extends StatelessWidget {
  final String? selectedUser;

  // Constructor to accept an optional selectedUser
  MessagePage({this.selectedUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(selectedUser != null ? 'Chat with $selectedUser' : 'Messages'),
      ),
      body: selectedUser == null
          ? UserList(onUserSelected: (user) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessagePage(selectedUser: user),
                ),
              );
            })
          : ChatRoom(selectedUser: selectedUser!),
    );
  }
}
