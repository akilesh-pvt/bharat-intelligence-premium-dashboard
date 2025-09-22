import 'package:uuid/uuid.dart';

enum AllowanceStatus { pending, approved, rejected }

class Allowance {
  final String id;
  final String visitorId;
  final double distanceKm;
  final double? amountCalculated;
  final String? odometerStartPhoto;
  final String? odometerEndPhoto;
  final List<String> farmerVisitPhotos;
  final AllowanceStatus status;
  final String? adminComments;
  final DateTime createdAt;
  final DateTime? approvedAt;

  Allowance({
    String? id,
    required this.visitorId,
    required this.distanceKm,
    this.amountCalculated,
    this.odometerStartPhoto,
    this.odometerEndPhoto,
    List<String>? farmerVisitPhotos,
    this.status = AllowanceStatus.pending,
    this.adminComments,
    DateTime? createdAt,
    this.approvedAt,
  }) : id = id ?? const Uuid().v4(),
       farmerVisitPhotos = farmerVisitPhotos ?? [],
       createdAt = createdAt ?? DateTime.now();

  // Convert to JSON for Supabase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'visitor_id': visitorId,
      'distance_km': distanceKm,
      'amount_calculated': amountCalculated,
      'odometer_start_photo': odometerStartPhoto,
      'odometer_end_photo': odometerEndPhoto,
      'farmer_visit_photos': farmerVisitPhotos,
      'status': status.name,
      'admin_comments': adminComments,
      'created_at': createdAt.toIso8601String(),
      'approved_at': approvedAt?.toIso8601String(),
    };
  }

  // Create from JSON
  factory Allowance.fromJson(Map<String, dynamic> json) {
    return Allowance(
      id: json['id'] as String,
      visitorId: json['visitor_id'] as String,
      distanceKm: (json['distance_km'] as num).toDouble(),
      amountCalculated: (json['amount_calculated'] as num?)?.toDouble(),
      odometerStartPhoto: json['odometer_start_photo'] as String?,
      odometerEndPhoto: json['odometer_end_photo'] as String?,
      farmerVisitPhotos: List<String>.from(json['farmer_visit_photos'] ?? []),
      status: _parseStatus(json['status'] as String?),
      adminComments: json['admin_comments'] as String?,
      createdAt: DateTime.parse(json['created_at']),
      approvedAt: json['approved_at'] != null 
          ? DateTime.parse(json['approved_at'] as String)
          : null,
    );
  }

  static AllowanceStatus _parseStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return AllowanceStatus.pending;
      case 'approved':
        return AllowanceStatus.approved;
      case 'rejected':
        return AllowanceStatus.rejected;
      default:
        return AllowanceStatus.pending;
    }
  }

  Allowance copyWith({
    double? distanceKm,
    double? amountCalculated,
    String? odometerStartPhoto,
    String? odometerEndPhoto,
    List<String>? farmerVisitPhotos,
    AllowanceStatus? status,
    String? adminComments,
    DateTime? approvedAt,
  }) {
    return Allowance(
      id: id,
      visitorId: visitorId,
      distanceKm: distanceKm ?? this.distanceKm,
      amountCalculated: amountCalculated ?? this.amountCalculated,
      odometerStartPhoto: odometerStartPhoto ?? this.odometerStartPhoto,
      odometerEndPhoto: odometerEndPhoto ?? this.odometerEndPhoto,
      farmerVisitPhotos: farmerVisitPhotos ?? this.farmerVisitPhotos,
      status: status ?? this.status,
      adminComments: adminComments ?? this.adminComments,
      createdAt: createdAt,
      approvedAt: approvedAt ?? this.approvedAt,
    );
  }

  String get statusDisplay {
    switch (status) {
      case AllowanceStatus.pending:
        return 'Pending';
      case AllowanceStatus.approved:
        return 'Approved';
      case AllowanceStatus.rejected:
        return 'Rejected';
    }
  }

  // Calculate amount based on distance (₹12 per km)
  double get calculatedAmount => distanceKm * 12.0;
}