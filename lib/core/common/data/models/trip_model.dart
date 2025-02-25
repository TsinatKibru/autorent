import 'package:car_rent/core/common/data/models/profile_model.dart';
import 'package:car_rent/core/common/entities/trip.dart';
import 'package:car_rent/features/car/data/models/vehicle_model.dart';

class TripModel extends Trip {
  TripModel({
    required super.id,
    required super.vehicle,
    required super.profile,
    required super.host,
    required super.startTime,
    required super.endTime,
    required super.pickupLocation,
    required super.totalCost,
    required super.status,
    super.responseTime,
    required super.createdAt,
    super.updatedAt,
  });

  factory TripModel.fromJson(Map<String, dynamic> map) {
    return TripModel(
      id: map['id'],
      vehicle: VehicleModel.fromJson(map['vehicle']),
      profile: ProfileModel.fromJson(map['profile']),
      host: ProfileModel.fromJson(map['host']),
      startTime: DateTime.parse(map['start_time']),
      endTime: DateTime.parse(map['end_time']),
      pickupLocation: map['pickup_location'],
      totalCost: (map['total_cost'] as num).toDouble(),
      status: map['status'],
      responseTime: map['response_time'] != null
          ? Duration(microseconds: map['response_time'])
          : null,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vehicle': (vehicle as VehicleModel).toJson(),
      'profile': (profile as ProfileModel).toJson(),
      'host': (host as ProfileModel).toJson(),
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'pickup_location': pickupLocation,
      'total_cost': totalCost,
      'status': status,
      'response_time': responseTime?.inMicroseconds,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Trip toEntity() {
    return Trip(
      id: id,
      vehicle: vehicle, // Already a Vehicle entity
      profile: profile, // Already a Profile entity
      host: host, // Already a Profile entity
      startTime: startTime,
      endTime: endTime,
      pickupLocation: pickupLocation,
      totalCost: totalCost,
      status: status,
      responseTime: responseTime,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
