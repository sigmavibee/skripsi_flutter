class NutritionHistory {
  final String id;
  final String childName;
  final String ageText;
  final int height;
  final int weight;
  final double bmi;
  final String weightCategory;
  final String gender;
  final String creatorId;
  final DateTime updatedAt;
  final DateTime createdAt;
  final DateTime? deletedAt;

  NutritionHistory({
    required this.id,
    required this.childName,
    required this.ageText,
    required this.height,
    required this.weight,
    required this.bmi,
    required this.weightCategory,
    required this.gender,
    required this.creatorId,
    required this.updatedAt,
    required this.createdAt,
    this.deletedAt,
  });

  factory NutritionHistory.fromJson(Map<String, dynamic> json) {
    return NutritionHistory(
      id: json['id'],
      childName: json['child_name'],
      ageText: json['age_text'],
      height: json['height'],
      weight: json['weight'],
      bmi: json['bmi'].toDouble(),
      weightCategory: json['weight_category'],
      gender: json['gender'],
      creatorId: json['creator_id'],
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
    );
  }
}
