import 'package:car_rent/core/common/entities/location.dart' as ts;
import 'package:geocoding/geocoding.dart';

class LocationUtils {
  /// Extracts latitude and longitude from a string in the format "lat, long".
  /// Returns a `Location` object.
  static ts.Location parseLocation(String locationString) {
    try {
      // Split the string by comma
      List<String> parts = locationString.split(',');

      // Extract and trim latitude and longitude
      double latitude = double.parse(parts[0].trim());
      double longitude = double.parse(parts[1].trim());

      // Return a Location object
      return ts.Location(latitude: latitude, longitude: longitude);
    } catch (e) {
      throw FormatException("Invalid location string: $locationString");
    }
  }

  static Future<String> getLocationName(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        // Build a more detailed address
        String address = [
          // place.name, // Place name (if available)
          // place.street, // Street name
          place.subLocality, // District
          place.locality, // City
          // place.administrativeArea, // State/Region
          // place.country // Country
        ].where((element) => element != null && element.isNotEmpty).join(', ');

        return address.isNotEmpty ? address : 'Unknown Location';
      }
    } catch (e) {
      print('Error fetching location name: $e');
    }
    return 'Unknown Location';
  }
}
