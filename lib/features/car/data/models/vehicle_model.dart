import 'package:car_rent/features/car/domain/entities/vehicle.dart';

class VehicleModel extends Vehicle {
  VehicleModel(
      {required super.id,
      required super.plateNumber,
      required super.model,
      required super.brand,
      required super.pricePerHour,
      super.previousPricePerHour,
      super.descriptionNote,
      super.batteryCapacity,
      super.topSpeed,
      required super.transmissionType,
      super.engineOutput,
      required super.numberOfDoors,
      super.insuranceImageUrl,
      super.guidelines,
      required super.category,
      required super.host,
      required super.seatingCapacity,
      super.rating,
      required super.available,
      required super.activeStatus,
      super.gallery,
      required super.createdAt,
      super.updatedAt,
      super.numberOfTrips});

  factory VehicleModel.fromJson(Map<String, dynamic> map) {
    return VehicleModel(
      id: map['id'],
      plateNumber: map['plate_number'],
      model: map['model'],
      brand: map['brand'],
      pricePerHour: (map['price_per_hour'] as num).toDouble(),
      previousPricePerHour:
          (map['previous_price_per_hour'] as num?)?.toDouble(),
      descriptionNote: map['description_note'],
      batteryCapacity: (map['battery_capacity'] as num?)?.toDouble(),
      topSpeed: (map['top_speed'] as num?)?.toDouble(),
      transmissionType: map['transmission_type'] ?? 'unknown',
      engineOutput: (map['engine_output'] as num?)?.toDouble(),
      numberOfDoors: map['number_of_doors'] ?? 4,
      numberOfTrips: map['number_of_trips'] ?? 0,
      insuranceImageUrl: map['insurance_image_url'],
      guidelines: map['guidelines'],
      category: map['category'] ?? 'general',
      host: map['host'] ?? '',
      seatingCapacity: map['seating_capacity'] ?? 5,
      rating: (map['rating'] as num?)?.toDouble(),
      available: map['available'] ?? true,
      activeStatus: map['active_status'] ?? true,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      gallery: List<String>.from(map['gallery'] ?? []),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson();
  }

  Vehicle toEntity() {
    return Vehicle(
      id: id,
      plateNumber: plateNumber,
      model: model,
      brand: brand,
      pricePerHour: pricePerHour,
      previousPricePerHour: previousPricePerHour,
      descriptionNote: descriptionNote,
      batteryCapacity: batteryCapacity,
      topSpeed: topSpeed,
      transmissionType: transmissionType,
      engineOutput: engineOutput,
      numberOfDoors: numberOfDoors,
      insuranceImageUrl: insuranceImageUrl,
      guidelines: guidelines,
      category: category,
      host: host,
      seatingCapacity: seatingCapacity,
      rating: rating,
      available: available,
      activeStatus: activeStatus,
      gallery: gallery,
      createdAt: createdAt,
      updatedAt: updatedAt,
      numberOfTrips: numberOfTrips,
    );
  }
}
