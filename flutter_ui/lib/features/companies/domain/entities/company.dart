/// Company status enumeration
enum CompanyStatus {
  real('real', 'Реальный'),
  potential('potential', 'Потенциальный'),
  lost('lost', 'Потерянный');

  final String value;
  final String displayName;

  const CompanyStatus(this.value, this.displayName);

  static CompanyStatus fromString(String value) {
    return CompanyStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => CompanyStatus.potential,
    );
  }
}

/// Company entity
///
/// Represents a client company in the organization.
class Company {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final String address;
  final CompanyStatus status;
  final String? content;
  final DateTime? lastContactDate;
  final String organizationId;
  final String createdByUserId;
  final DateTime createdAt;

  const Company({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    required this.address,
    required this.status,
    this.content,
    this.lastContactDate,
    required this.organizationId,
    required this.createdByUserId,
    required this.createdAt,
  });

  /// Create a copy with updated fields
  Company copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? address,
    CompanyStatus? status,
    String? content,
    DateTime? lastContactDate,
    String? organizationId,
    String? createdByUserId,
    DateTime? createdAt,
  }) {
    return Company(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      status: status ?? this.status,
      content: content ?? this.content,
      lastContactDate: lastContactDate ?? this.lastContactDate,
      organizationId: organizationId ?? this.organizationId,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Company && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
