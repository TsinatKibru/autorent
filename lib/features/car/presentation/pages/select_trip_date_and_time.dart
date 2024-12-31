import 'package:car_rent/features/car/presentation/widgets/car_rent_gradient_button.dart';
import 'package:flutter/material.dart';

class SelectTripDateAndTime extends StatefulWidget {
  const SelectTripDateAndTime({Key? key}) : super(key: key);

  @override
  State<SelectTripDateAndTime> createState() => _SelectTripDateAndTimeState();
}

class _SelectTripDateAndTimeState extends State<SelectTripDateAndTime> {
  bool isSelectingInitialDate = true;
  DateTime selectedInitialDate = DateTime.now();
  DateTime selectedReturnDate = DateTime.now().add(const Duration(days: 1));
  double selectedInitialTimeInMinutes = 0; // Slider value for initial time
  double selectedReturnTimeInMinutes = 0; // Slider value for return time

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Trip Dates'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Horizontal green card
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 227, 249, 228),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDateTimeColumn(
                    "Initial Date",
                    "${selectedInitialDate.month}/${selectedInitialDate.day} ${_formatSliderTime(selectedInitialTimeInMinutes)}",
                  ),
                  const Icon(Icons.arrow_forward, color: Colors.green),
                  _buildDateTimeColumn(
                    "Return Date",
                    "${selectedReturnDate.month}/${selectedReturnDate.day} ${_formatSliderTime(selectedReturnTimeInMinutes)}",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Toggle between Initial Date and Return Date
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildToggleButton("Initial Date", isSelectingInitialDate),
                _buildToggleButton("Return Date", !isSelectingInitialDate),
              ],
            ),
            const SizedBox(height: 16),
            // Calendar display
            Expanded(
              child: _buildCalendar(
                isInitial: isSelectingInitialDate,
              ),
            ),
            const SizedBox(height: 16),
            // Time sliders for initial and return dates
            _buildTimeSlider(
              label: "Initial Time",
              currentValue: selectedInitialTimeInMinutes,
              isActive: true,
              onChanged: (value) {
                setState(() {
                  selectedInitialTimeInMinutes = value;
                });
              },
            ),

            _buildTimeSlider(
              label: "Return Time",
              currentValue: selectedReturnTimeInMinutes,
              isActive: true,
              onChanged: (value) {
                setState(() {
                  selectedReturnTimeInMinutes = value;
                });
              },
            ),
            const SizedBox(height: 16),
            CarRentGradientButton(buttonText: "Save", onPressed: _saveSelection)
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelectingInitialDate = label == "Initial Date";
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isActive ? Colors.green : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar({required bool isInitial}) {
    DateTime selectedDate =
        isInitial ? selectedInitialDate : selectedReturnDate;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Year and Month Selector
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  isInitial
                      ? selectedInitialDate = DateTime(
                          selectedInitialDate.year,
                          selectedInitialDate.month - 1,
                        )
                      : selectedReturnDate = DateTime(
                          selectedReturnDate.year,
                          selectedReturnDate.month - 1,
                        );
                });
              },
            ),
            Text(
              "${selectedDate.year} - ${_monthName(selectedDate.month)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                setState(() {
                  isInitial
                      ? selectedInitialDate = DateTime(
                          selectedInitialDate.year,
                          selectedInitialDate.month + 1,
                        )
                      : selectedReturnDate = DateTime(
                          selectedReturnDate.year,
                          selectedReturnDate.month + 1,
                        );
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Dates Grid
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount:
                DateTime(selectedDate.year, selectedDate.month + 1, 0).day,
            itemBuilder: (context, index) {
              int day = index + 1;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isInitial) {
                      selectedInitialDate = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        day,
                      );
                    } else {
                      selectedReturnDate = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        day,
                      );
                    }
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selectedDate.day == day
                        ? Colors.green
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "$day",
                    style: TextStyle(
                      color: selectedDate.day == day
                          ? Colors.white
                          : Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSlider({
    required String label,
    required double currentValue,
    required bool isActive,
    required ValueChanged<double> onChanged,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: isActive ? Colors.black : Colors.black38,
            ),
          ),
        ),
        Expanded(
          child: Slider(
            value: currentValue,
            inactiveColor: Colors.black12,
            min: 0,
            max: 24 * 60, // Minutes in a day
            divisions: 24 * 4, // 15-minute intervals
            label: _formatSliderTime(currentValue),
            onChanged: isActive ? onChanged : null,
          ),
        ),
      ],
    );
  }

  String _monthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month - 1];
  }

  String _formatSliderTime(double minutes) {
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    return "${hours.toString().padLeft(2, '0')}:${remainingMinutes.toInt().toString().padLeft(2, '0')}";
  }

  void _saveSelection() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Initial Date: ${selectedInitialDate.month}/${selectedInitialDate.day} ${_formatSliderTime(selectedInitialTimeInMinutes)}\n"
          "Return Date: ${selectedReturnDate.month}/${selectedReturnDate.day} ${_formatSliderTime(selectedReturnTimeInMinutes)}",
        ),
      ),
    );
  }

  Widget _buildDateTimeColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
