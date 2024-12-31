// import 'package:car_rent/features/car/domain/entities/vehicle.dart';

// class VehicleModel extends Vehicle {
//   VehicleModel({
//     required super.id,
//     required super.plateNumber,
//     required super.model,
//     required super.brand,
//     required super.pricePerHour,
//     super.previousPricePerHour,
//     super.descriptionNote,
//     super.batteryCapacity,
//     super.topSpeed,
//     required super.transmissionType,
//     super.engineOutput,
//     required super.numberOfDoors,
//     super.insuranceImageUrl,
//     super.guidelines,
//     required super.category,
//     required super.host,
//     required super.seatingCapacity,
//     super.rating,
//     required super.available,
//     super.gallery,
//     required super.createdAt,
//     super.updatedAt,
//   });

//   factory VehicleModel.fromJson(Map<String, dynamic> map) {
//     return VehicleModel(
//       id: map['id'],
//       plateNumber: map['plate_number'],
//       model: map['model'],
//       brand: map['brand'],
//       pricePerHour: map['price_per_hour'],
//       previousPricePerHour: map['previous_price_per_hour'],
//       descriptionNote: map['description_note'],
//       batteryCapacity: map['battery_capacity'],
//       topSpeed: map['top_speed'],
//       transmissionType: map['transmission_type'],
//       engineOutput: map['engine_output'],
//       numberOfDoors: map['number_of_doors'],
//       insuranceImageUrl: map['insurance_image_url'],
//       guidelines: map['guidelines'],
//       category: map['category'],
//       host: map['host'],
//       seatingCapacity: map['seating_capacity'],
//       rating: map['rating'],
//       available: map['available'],
//       createdAt: DateTime.parse(map['created_at']),
//       gallery: List<String>.from(map['gallery'] ?? []), // Parse gallery
//       updatedAt:
//           map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'plate_number': plateNumber,
//       'model': model,
//       'brand': brand,
//       'price_per_hour': pricePerHour,
//       'previous_price_per_hour': previousPricePerHour,
//       'description_note': descriptionNote,
//       'battery_capacity': batteryCapacity,
//       'top_speed': topSpeed,
//       'transmission_type': transmissionType,
//       'engine_output': engineOutput,
//       'number_of_doors': numberOfDoors,
//       'insurance_image_url': insuranceImageUrl,
//       'guidelines': guidelines,
//       'category': category,
//       'host': host,
//       'seating_capacity': seatingCapacity,
//       'rating': rating,
//       'available': available,
//       'gallery': gallery,
//       'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt?.toIso8601String(),
//     };
//   }
// }

import 'package:car_rent/features/car/domain/entities/vehicle.dart';

class VehicleModel extends Vehicle {
  VehicleModel({
    required super.id,
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
    super.gallery,
    required super.createdAt,
    super.updatedAt,
  });

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
      insuranceImageUrl: map['insurance_image_url'],
      guidelines: map['guidelines'],
      category: map['category'] ?? 'general',
      host: map['host'] ?? '',
      seatingCapacity: map['seating_capacity'] ?? 5,
      rating: (map['rating'] as num?)?.toDouble(),
      available: map['available'] ?? true,
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
}
