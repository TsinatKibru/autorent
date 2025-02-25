import 'package:car_rent/core/common/entities/profile.dart';
import 'package:car_rent/features/car/domain/entities/vehicle.dart';

class Trip {
  final int id;
  final Vehicle vehicle;
  final Profile profile;
  final Profile host;
  final DateTime startTime;
  final DateTime endTime;
  final String pickupLocation;
  final double totalCost;
  final String status;
  final Duration? responseTime;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Trip({
    required this.id,
    required this.vehicle,
    required this.profile,
    required this.host,
    required this.startTime,
    required this.endTime,
    required this.pickupLocation,
    required this.totalCost,
    required this.status,
    this.responseTime,
    required this.createdAt,
    this.updatedAt,
  });
  Trip copyWith({
    int? id,
    Vehicle? vehicle,
    Profile? profile,
    Profile? host,
    DateTime? startTime,
    DateTime? endTime,
    String? pickupLocation,
    double? totalCost,
    String? status,
    Duration? responseTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Trip(
      id: id ?? this.id,
      vehicle: vehicle ?? this.vehicle,
      profile: profile ?? this.profile,
      host: host ?? this.host,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      totalCost: totalCost ?? this.totalCost,
      status: status ?? this.status,
      responseTime: responseTime ?? this.responseTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Trip(id: $id, vehicle: ${vehicle.toString()}, profile: ${profile.toString()}, host: ${host.toString()}, '
        'startTime: $startTime, endTime: $endTime, pickupLocation: $pickupLocation, totalCost: $totalCost, '
        'status: $status, responseTime: ${responseTime?.inSeconds}s, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
