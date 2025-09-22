import 'package:uuid/uuid.dart';

enum TaskPriority { high, medium, low }
enum TaskStatus { pending, inProgress, completed, cancelled }

class Task {
  final String id;
  final String title;
  final String? description;
  final TaskPriority priority;
  final TaskStatus status;
  final String? assignedTo; // Field Visitor ID
  final String? farmerId;
  final DateTime? deadline;
  final DateTime createdAt;
  final DateTime updatedAt;

  Task({
    String? id,
    required this.title,
    this.description,
    this.priority = TaskPriority.medium,
    this.status = TaskStatus.pending,
    this.assignedTo,
    this.farmerId,
    this.deadline,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  // Convert to JSON for Supabase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority.name.toLowerCase(),
      'status': status.name,
      'assigned_to': assignedTo,
      'farmer_id': farmerId,
      'deadline': deadline?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Create from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      priority: _parsePriority(json['priority'] as String?),
      status: _parseStatus(json['status'] as String?),
      assignedTo: json['assigned_to'] as String?,
      farmerId: json['farmer_id'] as String?,
      deadline: json['deadline'] != null 
          ? DateTime.parse(json['deadline'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  static TaskPriority _parsePriority(String? priority) {
    switch (priority?.toLowerCase()) {
      case 'high':
        return TaskPriority.high;
      case 'medium':
        return TaskPriority.medium;
      case 'low':
        return TaskPriority.low;
      default:
        return TaskPriority.medium;
    }
  }

  static TaskStatus _parseStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return TaskStatus.pending;
      case 'in_progress':
        return TaskStatus.inProgress;
      case 'completed':
        return TaskStatus.completed;
      case 'cancelled':
        return TaskStatus.cancelled;
      default:
        return TaskStatus.pending;
    }
  }

  Task copyWith({
    String? title,
    String? description,
    TaskPriority? priority,
    TaskStatus? status,
    String? assignedTo,
    String? farmerId,
    DateTime? deadline,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      assignedTo: assignedTo ?? this.assignedTo,
      farmerId: farmerId ?? this.farmerId,
      deadline: deadline ?? this.deadline,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  String get priorityDisplay {
    switch (priority) {
      case TaskPriority.high:
        return 'High';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.low:
        return 'Low';
    }
  }

  String get statusDisplay {
    switch (status) {
      case TaskStatus.pending:
        return 'Pending';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.completed:
        return 'Completed';
      case TaskStatus.cancelled:
        return 'Cancelled';
    }
  }
}