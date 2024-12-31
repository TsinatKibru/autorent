// import 'package:flutter/material.dart';

// class ChatRoomPage extends StatelessWidget {
//   final String userName;
//   final String userStatus;

//   ChatRoomPage({required this.userName, this.userStatus = "Online"});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(userName,
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             Text(userStatus,
//                 style: TextStyle(fontSize: 14, color: Colors.white70)),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           // Chat Messages
//           Expanded(
//             child: ListView.builder(
//               padding: EdgeInsets.all(16.0),
//               itemCount: 10, // Example message count
//               itemBuilder: (context, index) {
//                 bool isSender = index % 2 == 0;
//                 return Align(
//                   alignment:
//                       isSender ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     margin: EdgeInsets.symmetric(vertical: 4.0),
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
//                     decoration: BoxDecoration(
//                       color: isSender
//                           ? Colors.blue.shade100
//                           : Colors.grey.shade200,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(12),
//                         topRight: Radius.circular(12),
//                         bottomLeft:
//                             isSender ? Radius.circular(12) : Radius.zero,
//                         bottomRight:
//                             isSender ? Radius.zero : Radius.circular(12),
//                       ),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Message ${index + 1}",
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           "12:${30 + index} PM",
//                           style: TextStyle(fontSize: 12, color: Colors.black54),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           // Input Field
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Type a message...',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                       contentPadding: EdgeInsets.symmetric(
//                         vertical: 10.0,
//                         horizontal: 16.0,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 IconButton(
//                   icon: Icon(Icons.send, color: Colors.blue),
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
import 'package:flutter/material.dart';

class ChatRoom extends StatelessWidget {
  final String selectedUser;

  ChatRoom({required this.selectedUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFF9F9F9), // Very light gray
            Color(0xFFE9F7EF), // Light mint
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          // Chat Messages Section
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: 10, // Example message count
              itemBuilder: (context, index) {
                bool isSender = index % 2 == 0;
                return Align(
                  alignment:
                      isSender ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: isSender
                          ? Colors.blue.shade100
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft:
                            isSender ? Radius.circular(12) : Radius.zero,
                        bottomRight:
                            isSender ? Radius.zero : Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      isSender
                          ? "Message from $selectedUser"
                          : "Your message here",
                    ),
                  ),
                );
              },
            ),
          ),
          // Message Input Field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12.0),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Handle sending message
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
