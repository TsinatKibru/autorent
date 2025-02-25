import 'package:car_rent/core/common/entities/rental.dart';

class RentalModel extends Rental {
  RentalModel({
    required int id,
    required int vehicleId,
    required String profileId,
    required String hostId,
    required DateTime startTime,
    required DateTime endTime,
    required String pickupLocation,
    required double totalCost,
    required String status,
    Duration? responseTime,
  }) : super(
          id: id,
          vehicleId: vehicleId,
          profileId: profileId,
          hostId: hostId,
          startTime: startTime,
          endTime: endTime,
          pickupLocation: pickupLocation,
          totalCost: totalCost,
          status: status,
          responseTime: responseTime,
        );

  factory RentalModel.fromJson(Map<String, dynamic> json) {
    return RentalModel(
      id: json['id'],
      vehicleId: json['vehicle'],
      profileId: json['profile'],
      hostId: json['host'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      pickupLocation: json['pickup_location'],
      totalCost: json['total_cost'],
      status: json['status'],
      responseTime: json['response_time'] != null
          ? Duration(microseconds: json['response_time'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
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
      'response_time': responseTime?.inMicroseconds,
    };
  }
}
