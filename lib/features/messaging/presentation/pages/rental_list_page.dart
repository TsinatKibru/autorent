import 'package:car_rent/core/common/bloc/profile/profile_bloc.dart';
import 'package:car_rent/core/common/entities/profile.dart';
import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/core/utils/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_rent/features/messaging/presentation/bloc/message_bloc.dart';
import 'package:car_rent/features/messaging/domain/entities/message.dart';
import 'package:car_rent/features/messaging/presentation/pages/message_page.dart';

class RentalListPage extends StatefulWidget {
  const RentalListPage({super.key});

  @override
  State<RentalListPage> createState() => _RentalListPageState();
}

class _RentalListPageState extends State<RentalListPage> {
  Profile? _currentUserProfile;
  @override
  void initState() {
    super.initState();
    context.read<MessageBloc>().add(FetchMessagesEvent(showloading: true));
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoadSuccess) {
      _currentUserProfile = profileState.profile;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rentals'),
        backgroundColor: Colors.grey[100],
        elevation: 0,
      ),
      body: BlocBuilder<MessageBloc, MessageState>(
        builder: (context, state) {
          if (state is MessageLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MessageFailure) {
            // return Center(child: Text("Error: ${state.message}"));
            showSnackbar(context, state.message);
          } else if (state is MessageLoadSuccess) {
            // Group messages by rental
            final Map<int, List<Message>> messagesByRental = {};
            for (final message in state.messages) {
              if (!messagesByRental.containsKey(message.rental.id)) {
                messagesByRental[message.rental.id] = [];
              }
              messagesByRental[message.rental.id]!.add(message);
            }

            // Display rentals with messages
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messagesByRental.length,
              itemBuilder: (context, index) {
                final rentalId = messagesByRental.keys.elementAt(index);
                final messages = messagesByRental[rentalId]!;
                final rental = messages.first.rental;
                final lastMessage = messages.first;
                String chatwith;
                if (_currentUserProfile != null &&
                    _currentUserProfile!.name == lastMessage.sender.name) {
                  chatwith = lastMessage.receiver.name;
                } else {
                  chatwith = lastMessage.sender.name;
                }

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: const CircleAvatar(
                      backgroundColor: AppPalette.primaryColor,
                      child: Icon(Icons.car_rental, color: Colors.white),
                    ),
                    title: Text(
                      "Rental #${rental.id}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          "Last message: ${lastMessage.content}",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "ChatWith: ${chatwith.toUpperCase()}",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Status: ${rental.status}",
                          style: TextStyle(
                            color: rental.status == "confirmed"
                                ? Colors.green
                                : Colors.orange,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Navigate to the MessagesPage for this rental
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessagesPage(rental: rental),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
          return const Center(child: Text("No messages found"));
        },
      ),
    );
  }
}
