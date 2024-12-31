import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/features/car/presentation/pages/favorites_page.dart';
import 'package:car_rent/features/car/presentation/pages/home_page.dart';
import 'package:car_rent/features/host/presentation/pages/host_home_page.dart';
import 'package:car_rent/features/messaging/presentation/pages/message_page.dart';
import 'package:car_rent/features/trips/presentation/pages/trips_page.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final int initialIndex;
  final dynamic selectedUser; // Optional parameter to pass selectedUser

  // Constructor with optional parameters
  BottomNavigationBarWidget({this.initialIndex = 2, this.selectedUser});

  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  late int _currentIndex;
  DateTime? currentBackPressTime;

  // Initialize the current index from the widget's initialIndex
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  late final List<Widget> _pages = [
    MessagePage(selectedUser: widget.selectedUser), // Pass selectedUser here
    TripsPage(),
    HomePage(),
    FavoritesPage(),
    HostHomePage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;

      // Show SnackBar for confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Press back again to exit"),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      );

      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        extendBody: true,
        body: _pages[_currentIndex],
        bottomNavigationBar: CurvedNavigationBar(
          index: _currentIndex,
          onTap: _onTabTapped,
          height: 60.0,
          color: AppPalette.primaryColor,
          backgroundColor: Colors.transparent,
          animationDuration: Duration(milliseconds: 300),
          items: <Widget>[
            Icon(Icons.message,
                size: 30,
                color: _currentIndex == 0 ? Colors.white : Colors.white),
            Icon(Icons.directions_car,
                size: 30,
                color: _currentIndex == 1 ? Colors.white : Colors.white),
            Icon(Icons.home,
                size: 30,
                color: _currentIndex == 2 ? Colors.white : Colors.white),
            Icon(Icons.favorite,
                size: 30,
                color: _currentIndex == 3 ? Colors.white : Colors.white),
            Icon(Icons.person,
                size: 30,
                color: _currentIndex == 4 ? Colors.white : Colors.white),
          ],
        ),
      ),
    );
  }
}
