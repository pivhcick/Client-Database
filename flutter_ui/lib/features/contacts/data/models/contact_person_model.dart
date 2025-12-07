import '../../domain/entities/contact_person.dart';

/// Contact person model for JSON serialization
///
/// Handles conversion between Supabase JSON and ContactPerson entity.
class ContactPersonModel {
  final String id;
  final String companyId;
  final String firstName;
  final String lastName;
  final String middleName;
  final String position;
  final String phone;
  final String? email;

  const ContactPersonModel({
    required this.id,
    required this.companyId,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.position,
    required this.phone,
    this.email,
  });

  /// Create model from JSON
  factory ContactPersonModel.fromJson(Map<String, dynamic> json) {
    return ContactPersonModel(
      id: json['id'] as String,
      companyId: json['company_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      middleName: json['middle_name'] as String,
      position: json['position'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'first_name': firstName,
      'last_name': lastName,
      'middle_name': middleName,
      'position': position,
      'phone': phone,
      'email': email,
    };
  }

  /// Convert model to entity
  ContactPerson toEntity() {
    return ContactPerson(
      id: id,
      companyId: companyId,
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      position: position,
      phone: phone,
      email: email,
    );
  }

  /// Create model from entity
  factory ContactPersonModel.fromEntity(ContactPerson entity) {
    return ContactPersonModel(
      id: entity.id,
      companyId: entity.companyId,
      firstName: entity.firstName,
      lastName: entity.lastName,
      middleName: entity.middleName,
      position: entity.position,
      phone: entity.phone,
      email: entity.email,
    );
  }
}
