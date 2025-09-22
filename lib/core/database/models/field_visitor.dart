import 'package:uuid/uuid.dart';

class FieldVisitor {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? address;
  final String? assignedArea;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  FieldVisitor({
    String? id,
    required this.name,
    required this.email,
    required this.phone,
    this.address,
    this.assignedArea,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.isActive = true,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  // Convert to JSON for Supabase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'assigned_area': assignedArea,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_active': isActive,
    };
  }

  // Create from JSON
  factory FieldVisitor.fromJson(Map<String, dynamic> json) {
    return FieldVisitor(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String?,
      assignedArea: json['assigned_area'] as String?,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  FieldVisitor copyWith({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? assignedArea,
    bool? isActive,
  }) {
    return FieldVisitor(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      assignedArea: assignedArea ?? this.assignedArea,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      isActive: isActive ?? this.isActive,
    );
  }
}