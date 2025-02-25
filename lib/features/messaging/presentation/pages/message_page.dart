import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_rent/features/messaging/presentation/bloc/message_bloc.dart';
import 'package:car_rent/features/messaging/domain/entities/message.dart';
import 'package:car_rent/core/common/entities/rental.dart';
import 'package:car_rent/core/common/bloc/profile/profile_bloc.dart';
import 'package:car_rent/core/common/entities/profile.dart';

class MessagesPage extends StatefulWidget {
  final Rental rental;

  const MessagesPage({super.key, required this.rental});

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Profile? _currentUserProfile;
  Message? _lastMessageTemp;

  @override
  void initState() {
    super.initState();
    // Fetch messages for the selected rental
    context.read<MessageBloc>().add(FetchMessagesEvent(showloading: true));
    // Get the current user profile
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoadSuccess) {
      _currentUserProfile = profileState.profile;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Messages for Rental ${widget.rental.id}')),
      body: Column(
        children: [
          // MESSAGES LIST
          Expanded(
            child: BlocConsumer<MessageBloc, MessageState>(
              listener: (context, state) {
                setState(() {
                  _lastMessageTemp =
                      null; // Remove temporary message after successful load
                });

                // Scroll to the bottom when a new message is added
                if (state is MessageLoadSuccess) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  });
                }
              },
              builder: (context, state) {
                if (state is MessageLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MessageFailure) {
                  return Center(child: Text("Error: ${state.message}"));
                } else if (state is MessageLoadSuccess) {
                  // Filter messages for the selected rental
                  final rentalMessages = state.messages
                      .where((message) => message.rental.id == widget.rental.id)
                      .toList();

                  // Add the temporary message if it exists
                  if (_lastMessageTemp != null) {
                    rentalMessages.insert(0, _lastMessageTemp!);
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    reverse: true, // Newest messages at the bottom
                    itemCount: rentalMessages.length,
                    itemBuilder: (context, index) {
                      final message = rentalMessages[index];
                      return _buildMessageTile(message);
                    },
                  );
                }
                return const Center(child: Text("No messages found"));
              },
            ),
          ),

          // MESSAGE INPUT FIELD
          _buildMessageInput(),
        ],
      ),
    );
  }

  // 📨 Message bubble UI
  Widget _buildMessageTile(Message message) {
    final bool isMe = message.sender.id == _currentUserProfile?.id;
    final bool isTempMessage = _lastMessageTemp != null &&
        message.id == _lastMessageTemp!.id; // Check by ID or content

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isTempMessage
              ? (isMe
                  ? AppPalette.primaryColor.withOpacity(0.6)
                  : Colors.grey[300]!.withOpacity(0.6)) // Indicate temp message
              : (isMe ? AppPalette.primaryColor : Colors.grey[300]),
          borderRadius: BorderRadius.circular(10),
          border:
              isTempMessage ? Border.all(color: Colors.orange, width: 1) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.sender.name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(message.content),
            if (isTempMessage) // Add "Sending..." indicator
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Sending...",
                      style:
                          TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
                  SizedBox(width: 5),
                  SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(strokeWidth: 1.5),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // 📝 Message input & send button
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Type a message...",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          BlocBuilder<MessageBloc, MessageState>(
            builder: (context, state) {
              return IconButton(
                icon: state is MessageLoading
                    ? const CircularProgressIndicator()
                    : const Icon(Icons.send, color: AppPalette.primaryColor),
                onPressed: state is MessageLoading ? null : _sendMessage,
              );
            },
          ),
        ],
      ),
    );
  }

  // 🚀 Send message
  void _sendMessage() {
    if (_messageController.text.trim().isEmpty || _currentUserProfile == null) {
      return;
    }

    // Determine the receiver profile
    final receiverId = _currentUserProfile!.id == widget.rental.hostId
        ? widget.rental.profileId
        : widget.rental.hostId;

    final newMessage = Message(
      id: -1, // Temporary ID for the temp message
      content: _messageController.text,
      sender: _currentUserProfile!,
      receiver: _currentUserProfile!.copyWith(id: receiverId),
      rental: widget.rental,
      timestamp: DateTime.now(),
      isRead: false,
    );

    // Add the temporary message
    setState(() {
      _lastMessageTemp = newMessage;
    });

    // Send the message
    context.read<MessageBloc>().add(CreateMessageEvent(newMessage));
    _messageController.clear();
  }
}
