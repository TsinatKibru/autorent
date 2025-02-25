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
  final bool activeStatus;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<String>? gallery;
  final int? numberOfTrips;

  Vehicle(
      {required this.id,
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
      required this.activeStatus,
      this.gallery,
      required this.createdAt,
      this.updatedAt,
      this.numberOfTrips});

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
        activeStatus: map['active_status'] ?? true,
        createdAt: DateTime.parse(map['created_at']),
        updatedAt: map['updated_at'] != null
            ? DateTime.parse(map['updated_at'])
            : null,
        gallery: List<String>.from(map['gallery'] ?? []),
        numberOfTrips: map['number_of_trips'] ?? 0);
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
      'number_of_trips': numberOfTrips,
      'insurance_image_url': insuranceImageUrl,
      'guidelines': guidelines,
      'category': category,
      'host': host,
      'seating_capacity': seatingCapacity,
      'rating': rating,
      'available': available,
      'active_status': activeStatus,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'gallery': gallery,
    };
  }

  @override
  String toString() {
    return 'Vehicle(id: $id, plateNumber: $plateNumber, model: $model, brand: $brand, '
        'pricePerHour: $pricePerHour, previousPricePerHour: $previousPricePerHour, '
        'descriptionNote: ${descriptionNote ?? "N/A"}, batteryCapacity: ${batteryCapacity ?? "N/A"}, '
        'topSpeed: ${topSpeed ?? "N/A"}, transmissionType: $transmissionType, engineOutput: ${engineOutput ?? "N/A"}, '
        'numberOfDoors: $numberOfDoors, insuranceImageUrl: ${insuranceImageUrl ?? "N/A"}, guidelines: ${guidelines ?? "N/A"}, '
        'category: $category, host: $host, seatingCapacity: $seatingCapacity, rating: ${rating ?? "N/A"}, '
        'available: $available, activeStatus: $activeStatus, createdAt: $createdAt, updatedAt: ${updatedAt ?? "N/A"}, '
        'gallery: ${gallery != null && gallery!.isNotEmpty ? gallery!.join(", ") : "N/A"}, '
        'numberOfTrips: ${numberOfTrips ?? 0})';
  }

  Vehicle copyWith({
    int? id,
    String? plateNumber,
    String? model,
    String? brand,
    double? pricePerHour,
    double? previousPricePerHour,
    String? descriptionNote,
    double? batteryCapacity,
    double? topSpeed,
    String? transmissionType,
    double? engineOutput,
    int? numberOfDoors,
    String? insuranceImageUrl,
    String? guidelines,
    String? category,
    String? host,
    int? seatingCapacity,
    double? rating,
    bool? available,
    bool? activeStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? gallery,
    int? numberOfTrips,
  }) {
    return Vehicle(
      id: id ?? this.id,
      plateNumber: plateNumber ?? this.plateNumber,
      model: model ?? this.model,
      brand: brand ?? this.brand,
      pricePerHour: pricePerHour ?? this.pricePerHour,
      previousPricePerHour: previousPricePerHour ?? this.previousPricePerHour,
      descriptionNote: descriptionNote ?? this.descriptionNote,
      batteryCapacity: batteryCapacity ?? this.batteryCapacity,
      topSpeed: topSpeed ?? this.topSpeed,
      transmissionType: transmissionType ?? this.transmissionType,
      engineOutput: engineOutput ?? this.engineOutput,
      numberOfDoors: numberOfDoors ?? this.numberOfDoors,
      insuranceImageUrl: insuranceImageUrl ?? this.insuranceImageUrl,
      guidelines: guidelines ?? this.guidelines,
      category: category ?? this.category,
      host: host ?? this.host,
      seatingCapacity: seatingCapacity ?? this.seatingCapacity,
      rating: rating ?? this.rating,
      available: available ?? this.available,
      activeStatus: activeStatus ?? this.activeStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      gallery: gallery ?? this.gallery,
      numberOfTrips: numberOfTrips ?? this.numberOfTrips,
    );
  }
}
