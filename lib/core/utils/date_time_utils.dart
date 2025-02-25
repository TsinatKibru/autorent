class DateTimeUtils {
  static const List<String> _monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  /// Returns the month name for the given month integer.
  /// [month] should be in the range 1 to 12.
  static String getMonthName(int month) {
    if (month < 1 || month > 12) {
      throw ArgumentError('Month must be between 1 and 12.');
    }
    return _monthNames[month - 1];
  }

  /// Returns 'AM' or 'PM' for the given DateTime object.
  static String getPeriod(DateTime dateTime) {
    return dateTime.hour >= 12 ? 'PM' : 'AM';
  }

  /// Returns the time in 'hh:mm AM/PM' format for the given DateTime object.
  static String getFormattedTime(DateTime dateTime) {
    final int hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final String minute = dateTime.minute.toString().padLeft(2, '0');
    final String period = getPeriod(dateTime);
    return '$hour:$minute $period';
  }

  static const List<String> _weekDays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  static String getWeekName(DateTime dateTime) {
    return _weekDays[dateTime.weekday -
        1]; // Subtract 1 to adjust for 0-based index in the list
  }

  /// Returns the date formatted as "Month Day" (e.g., "Jan 5").
  static String getMonthNameWithDay(DateTime dateTime) {
    return '${getMonthName(dateTime.month)} ${dateTime.day}';
  }

  /// Returns the date formatted as "Month Day, Year" (e.g., "Jan 5, 2024").
  static String getMonthNameWithDayAndYear(DateTime dateTime) {
    return '${getMonthName(dateTime.month)} ${dateTime.day}, ${dateTime.year}';
  }

  static String getfullformmatedtime(DateTime dateTime) {
    return '${getMonthName(dateTime.month)} ${dateTime.day}, ${dateTime.year} ${getFormattedTime(dateTime)}';
  }
}
