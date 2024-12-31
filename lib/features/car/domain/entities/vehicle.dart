// class Vehicle {
//   final int id;
//   final String plateNumber;
//   final String model;
//   final String brand;
//   final double pricePerHour;
//   final double? previousPricePerHour;
//   final String? descriptionNote;
//   final double? batteryCapacity;
//   final double? topSpeed;
//   final String transmissionType;
//   final double? engineOutput;
//   final int numberOfDoors;
//   final String? insuranceImageUrl;
//   final String? guidelines;
//   final String category;
//   final String host;
//   final int seatingCapacity;
//   final double? rating;
//   final bool available;
//   final DateTime createdAt;
//   final DateTime? updatedAt;
//   final List<String>? gallery; // New field for gallery

//   Vehicle({
//     required this.id,
//     required this.plateNumber,
//     required this.model,
//     required this.brand,
//     required this.pricePerHour,
//     this.previousPricePerHour,
//     this.descriptionNote,
//     this.batteryCapacity,
//     this.topSpeed,
//     required this.transmissionType,
//     this.engineOutput,
//     required this.numberOfDoors,
//     this.insuranceImageUrl,
//     this.guidelines,
//     required this.category,
//     required this.host,
//     required this.seatingCapacity,
//     this.rating,
//     required this.available,
//     this.gallery, // Initialize gallery
//     required this.createdAt,
//     this.updatedAt,
//   });

//   factory Vehicle.fromJson(Map<String, dynamic> map) {
//     return Vehicle(
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
//       updatedAt:
//           map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
//       gallery:
//           List<String>.from(map['gallery'] ?? []), // Parse gallery from JSON
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
//       'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt?.toIso8601String(),
//       'gallery': gallery, // Add gallery to JSON
//     };
//   }
// }
class Vehicle {
  final int id;
  final String plateNumber;
  final String model;
  final String brand;
  final double pricePerHour;
  final double? previousPricePerHour;
  final String? descriptionNote;
  final double? batteryCapacity;
  final double? topSpeed;
  final String transmissionType;
  final double? engineOutput;
  final int numberOfDoors;
  final String? insuranceImageUrl;
  final String? guidelines;
  final String category;
  final String host;
  final int seatingCapacity;
  final double? rating;
  final bool available;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<String>? gallery;

  Vehicle({
    required this.id,
    required this.plateNumber,
    required this.model,
    required this.brand,
    required this.pricePerHour,
    this.previousPricePerHour,
    this.descriptionNote,
    this.batteryCapacity,
    this.topSpeed,
    required this.transmissionType,
    this.engineOutput,
    required this.numberOfDoors,
    this.insuranceImageUrl,
    this.guidelines,
    required this.category,
    required this.host,
    required this.seatingCapacity,
    this.rating,
    required this.available,
    this.gallery,
    required this.createdAt,
    this.updatedAt,
  });

  factory Vehicle.fromJson(Map<String, dynamic> map) {
    assert(map['id'] != null, 'ID is required');
    assert(map['price_per_hour'] != null, 'Price per hour is required');

    return Vehicle(
      id: map['id'],
      plateNumber: map['plate_number'] ?? '',
      model: map['model'] ?? '',
      brand: map['brand'] ?? '',
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plate_number': plateNumber,
      'model': model,
      'brand': brand,
      'price_per_hour': pricePerHour,
      'previous_price_per_hour': previousPricePerHour,
      'description_note': descriptionNote,
      'battery_capacity': batteryCapacity,
      'top_speed': topSpeed,
      'transmission_type': transmissionType,
      'engine_output': engineOutput,
      'number_of_doors': numberOfDoors,
      'insurance_image_url': insuranceImageUrl,
      'guidelines': guidelines,
      'category': category,
      'host': host,
      'seating_capacity': seatingCapacity,
      'rating': rating,
      'available': available,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'gallery': gallery,
    };
  }
}
