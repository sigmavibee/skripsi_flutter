class Consultation {
  final String id;
  final String consultantDescription;
  final String consultantPhone;
  final String consultantId;
  final String consultantUsername;
  final String consultantProfile;
  final String createdAt;

  Consultation({
    required this.id,
    required this.consultantDescription,
    required this.consultantPhone,
    required this.consultantId,
    required this.consultantUsername,
    required this.consultantProfile,
    required this.createdAt,
  });

  factory Consultation.fromJson(Map<String, dynamic> json) {
    try {
      return Consultation(
        id: json['id'] as String,
        consultantDescription: json['consultant_description'] as String,
        consultantPhone: json['consultant_phone'] as String,
        consultantId: json['consultant_id'] as String,
        consultantUsername: json['consultant_username'] as String,
        consultantProfile: json['consultant_profile'] as String,
        createdAt: json['created_at'] as String,
      );
    } catch (e) {
      rethrow;
    }
  }
}
