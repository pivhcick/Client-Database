/// Contact record entity
///
/// Represents a record of contact/interaction with a company.
class ContactRecord {
  final String id;
  final String companyId;
  final String content;
  final DateTime createdAt;
  final String createdByUserId;
  final String? createdByUserName; // Denormalized from users table

  const ContactRecord({
    required this.id,
    required this.companyId,
    required this.content,
    required this.createdAt,
    required this.createdByUserId,
    this.createdByUserName,
  });

  /// Copy with new values
  ContactRecord copyWith({
    String? id,
    String? companyId,
    String? content,
    DateTime? createdAt,
    String? createdByUserId,
    String? createdByUserName,
  }) {
    return ContactRecord(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdByUserName: createdByUserName ?? this.createdByUserName,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContactRecord &&
        other.id == id &&
        other.companyId == companyId &&
        other.content == content &&
        other.createdAt == createdAt &&
        other.createdByUserId == createdByUserId &&
        other.createdByUserName == createdByUserName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        companyId.hashCode ^
        content.hashCode ^
        createdAt.hashCode ^
        createdByUserId.hashCode ^
        createdByUserName.hashCode;
  }

  @override
  String toString() {
    return 'ContactRecord(id: $id, companyId: $companyId, content: $content, createdAt: $createdAt, createdByUserId: $createdByUserId, createdByUserName: $createdByUserName)';
  }
}
