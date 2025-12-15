/// Contact person entity
///
/// Represents a contact person associated with a company.
class ContactPerson {
  final String id;
  final String companyId;
  final String firstName;
  final String lastName;
  final String middleName;
  final String position;
  final String phone;
  final String? email;

  const ContactPerson({
    required this.id,
    required this.companyId,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.position,
    required this.phone,
    this.email,
  });

  /// Get full name (Last First Middle)
  String get fullName => '$lastName $firstName $middleName';

  /// Get short name (Last F.M.)
  String get shortName {
    final firstInitial = firstName.isNotEmpty ? firstName[0] : '';
    final middleInitial = middleName.isNotEmpty ? middleName[0] : '';
    return '$lastName $firstInitial.$middleInitial.';
  }

  /// Get clean phone number without formatting (no spaces, dashes, parentheses)
  String get cleanPhone => phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');

  /// Create a copy with updated fields
  ContactPerson copyWith({
    String? id,
    String? companyId,
    String? firstName,
    String? lastName,
    String? middleName,
    String? position,
    String? phone,
    String? email,
  }) {
    return ContactPerson(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      position: position ?? this.position,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContactPerson && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
