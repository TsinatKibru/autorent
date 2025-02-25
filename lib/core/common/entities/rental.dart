class Rental {
  final int id;
  final int vehicleId;
  final String profileId;
  final String hostId;
  final DateTime startTime;
  final DateTime endTime;
  final String pickupLocation;
  final double totalCost;
  final String status;
  final Duration? responseTime;

  Rental({
    required this.id,
    required this.vehicleId,
    required this.profileId,
    required this.hostId,
    required this.startTime,
    required this.endTime,
    required this.pickupLocation,
    required this.totalCost,
    required this.status,
    this.responseTime,
  });
  factory Rental.fromJson(Map<String, dynamic> json) {
    print("Received Rental JSON: $json"); // Debugging output

    // Log each field's value for clarity
    print("Parsing rental fields:");
    print("id: ${json['id']}");
    print("vehicleId: ${json['vehicle']}");
    print("profileId: ${json['profile']}");
    print("hostId: ${json['host']}");
    print("startTime: ${json['start_time']}");
    print("endTime: ${json['end_time']}");
    print("pickupLocation: ${json['pickup_location']}");
    print("totalCost: ${json['total_cost']}");
    print("status: ${json['status']}");
    print("responseTime: ${json['response_time']}");
    return Rental(
      id: json['id'],
      vehicleId: json['vehicle'], // ✅ Fixed key
      profileId: json['profile'], // ✅ Fixed key
      hostId: json['host'], // ✅ Fixed key
      startTime: DateTime.parse(json['start_time']), // ✅ Fixed key
      endTime: DateTime.parse(json['end_time']), // ✅ Fixed key
      pickupLocation: json['pickup_location'], // ✅ Fixed key
      totalCost: (json['total_cost'] as num).toDouble(), // ✅ Fixed key
      status: json['status'],
      responseTime: json['response_time'] != null
          ? Duration(milliseconds: json['response_time'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    print("AKCBASJCVASHGcV");
    return {
      'id': id,
      'vehicle': vehicleId,
      'profile': profileId,
      'host': hostId,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'pickup_location': pickupLocation,
      'total_cost': totalCost,
      'status': status,
      'response_time': responseTime?.inMilliseconds,
    };
  }
}
