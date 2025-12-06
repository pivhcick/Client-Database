/// Organization entity (domain layer)
///
/// Represents an organization in the system.
/// Multiple users belong to one organization, and data is isolated by organization.
class Organization {
  final String id;
  final String name;
  final DateTime createdAt;

  const Organization({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Organization &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Organization(id: $id, name: $name)';
}
