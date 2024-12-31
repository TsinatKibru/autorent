import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/features/car/presentation/widgets/car_rent_gradient_button.dart';
import 'package:car_rent/features/navigation/presentation/widgets/bottom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';

class CheckOutPage extends StatefulWidget {
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  String? _selectedPaymentMethod;

  final List<Map<String, String>> paymentMethods = [
    {'name': 'Cash', 'icon': 'assets/icon/cash.png'},
    {'name': 'Credit Card', 'icon': 'assets/icon/credit_card.png'},
    {'name': 'PayPal', 'icon': 'assets/icon/paypal.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 42.0),
          child: const Text(
            'Checkout',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Options',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: paymentMethods.length,
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black12,
                  thickness: 0.5,
                  height: 20,
                ),
                itemBuilder: (context, index) {
                  final method = paymentMethods[index];
                  final isSelected = _selectedPaymentMethod == method['name'];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = isSelected
                            ? null
                            : method['name']; // Toggle selection
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  method['icon']!,
                                  width: 30, // Smaller size for images
                                  height: 30,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  method['name']!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black87, // Darker text color
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Icon(
                                isSelected
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Colors.black54, // Subtle arrow color
                              ),
                            ],
                          ),
                          if (isSelected && method['name'] == 'Cash')
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'Cash Selected',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          if (isSelected && method['name'] == 'Credit Card')
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Column(
                                children: const [
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Card Number',
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Expiry Date',
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: 'CVV',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (isSelected && method['name'] == 'PayPal')
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: const TextField(
                                decoration: InputDecoration(
                                  labelText: 'PayPal Email',
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            CarRentGradientButton(
              buttonText: "Checkout",
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.check_circle,
                            color: Colors.white, size: 24), // Icon added
                        SizedBox(
                            width: 10), // Spacing between the icon and text
                        Expanded(
                          child: Text(
                            'Your rental is confirmed! Track your Rental in the trips list.',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    duration: Duration(seconds: 4),
                    backgroundColor: AppPalette.primaryColor,
                    behavior:
                        SnackBarBehavior.floating, // Makes the snackbar float
                    margin: EdgeInsets.only(
                      bottom:
                          80, // Adjust this value to push it above the navigation bar
                      left: 16,
                      right: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                  ),
                );

                // Proceed to payment logic
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavigationBarWidget(
                      initialIndex: 1,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
