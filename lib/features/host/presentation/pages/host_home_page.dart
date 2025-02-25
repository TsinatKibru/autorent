import 'package:car_rent/features/car/presentation/bloc/vehicle_bloc.dart';
import 'package:car_rent/features/host/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_rent/core/common/bloc/profile/profile_bloc.dart';
import 'package:car_rent/core/common/entities/profile.dart';
import 'package:car_rent/features/host/presentation/widgets/host_motivation.dart';
import 'package:car_rent/features/host/presentation/widgets/my_cars.dart';
import 'package:car_rent/features/host/presentation/widgets/my_orders.dart';
import 'package:car_rent/features/host/presentation/widgets/update_profile_form.dart';

class HostHomePage extends StatefulWidget {
  const HostHomePage({Key? key}) : super(key: key);

  @override
  _HostHomePageState createState() => _HostHomePageState();
}

class _HostHomePageState extends State<HostHomePage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Filter Options"),
          content: const Text("Add filter options here."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const CustomAppBar(),
          body: Stack(
            children: [
              _buildBody(state),
              if (state is ProfileLoadSuccess &&
                  (state.profile.role == "" || state.profile.role == 'renter'))
                _buildHostRegisterOverlay(state.profile),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(ProfileState state) {
    if (state is ProfileLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ProfileLoadSuccess) {
      context
          .read<VehicleBloc>()
          .add(FetchCurrentUserVehiclesEvent(hostId: state.profile.id));
      return _hostHomeWidget(state.profile);
    } else if (state is ProfileFailure) {
      return Center(child: Text(state.message));
    }
    return Container(); // Default or initial state
  }

  Widget _hostHomeWidget(Profile profile) {
    return ListView(padding: const EdgeInsets.all(8), children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HostMotivation(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: MyCars(
              activeowner: profile.role == "host",
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 4.0, right: 4, bottom: 30),
            child: MyOrders(),
          ),
        ],
      ),
    ]);
  }

  Widget _buildHostRegisterOverlay(Profile profile) {
    return Container(
      color: Colors.black.withOpacity(0.6),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Register as Host",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateProfileForm(
                    profile: profile,
                    userRole: "host",
                  ),
                ),
              );
            },
            child: const Text("Update Profile"),
          ),
        ],
      ),
    );
  }
}
