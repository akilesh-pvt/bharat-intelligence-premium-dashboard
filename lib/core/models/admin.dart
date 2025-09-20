class Admin {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final String? accessToken;
  final String? idToken;
  final DateTime? lastLogin;
  final bool isActive;
  final String role;

  Admin({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.accessToken,
    this.idToken,
    this.lastLogin,
    this.isActive = true,
    this.role = 'admin',
  });

  // Convert Admin to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photo_url': photoUrl,
      'access_token': accessToken,
      'id_token': idToken,
      'last_login': lastLogin?.toIso8601String(),
      'is_active': isActive,
      'role': role,
    };
  }

  // Create Admin from JSON
  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      photoUrl: json['photo_url'] as String?,
      accessToken: json['access_token'] as String?,
      idToken: json['id_token'] as String?,
      lastLogin: json['last_login'] != null 
          ? DateTime.parse(json['last_login'] as String)
          : null,
      isActive: json['is_active'] as bool? ?? true,
      role: json['role'] as String? ?? 'admin',
    );
  }

  // Create a copy with updated fields
  Admin copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? accessToken,
    String? idToken,
    DateTime? lastLogin,
    bool? isActive,
    String? role,
  }) {
    return Admin(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      accessToken: accessToken ?? this.accessToken,
      idToken: idToken ?? this.idToken,
      lastLogin: lastLogin ?? this.lastLogin,
      isActive: isActive ?? this.isActive,
      role: role ?? this.role,
    );
  }

  @override
  String toString() {
    return 'Admin(id: $id, name: $name, email: $email, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Admin && other.id == id && other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}