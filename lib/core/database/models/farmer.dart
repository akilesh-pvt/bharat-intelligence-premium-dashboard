import 'package:uuid/uuid.dart';

class Farmer {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final String address;
  final double? farmSize;
  final List<String> crops;
  final String? governmentId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Farmer({
    String? id,
    required this.name,
    required this.phone,
    this.email,
    required this.address,
    this.farmSize,
    List<String>? crops,
    this.governmentId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : id = id ?? const Uuid().v4(),
       crops = crops ?? [],
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  // Convert to JSON for Supabase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'farm_size': farmSize,
      'crops': crops,
      'government_id': governmentId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Create from JSON
  factory Farmer.fromJson(Map<String, dynamic> json) {
    return Farmer(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      address: json['address'] as String,
      farmSize: json['farm_size']?.toDouble(),
      crops: List<String>.from(json['crops'] ?? []),
      governmentId: json['government_id'] as String?,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Farmer copyWith({
    String? name,
    String? phone,
    String? email,
    String? address,
    double? farmSize,
    List<String>? crops,
    String? governmentId,
  }) {
    return Farmer(
      id: id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      farmSize: farmSize ?? this.farmSize,
      crops: crops ?? this.crops,
      governmentId: governmentId ?? this.governmentId,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}