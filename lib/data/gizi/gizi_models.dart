class NutritionHistory {
  final String id;
  final String childId;
  final String childName;
  final String childNik;
  final String childVillage;
  final String dateOfBirth;
  final String ageText;
  final double height;
  final double weight;
  final String gender;
  final double bmi;
  final String heightCategory;
  final String massCategory;
  final String weightCategory;
  final String creatorId;
  final String createdAt;

  NutritionHistory({
    required this.id,
    required this.childId,
    required this.childName,
    required this.childNik,
    required this.childVillage,
    required this.dateOfBirth,
    required this.ageText,
    required this.height,
    required this.weight,
    required this.gender,
    required this.bmi,
    required this.heightCategory,
    required this.massCategory,
    required this.weightCategory,
    required this.creatorId,
    required this.createdAt,
  });

  factory NutritionHistory.fromJson(Map<String, dynamic> json) {
    try {
      return NutritionHistory(
        id: json['id'] as String,
        childId: json['child_id'] as String,
        childName: json['child_name'] as String,
        childNik: json['child_nik'] as String,
        childVillage: json['child_village'] as String,
        dateOfBirth: json['date_of_birth'] as String,
        ageText: json['age_text'] as String,
        height: (json['height'] as num).toDouble(),
        weight: (json['weight'] as num).toDouble(),
        gender: json['gender'] as String,
        bmi: (json['bmi'] as num).toDouble(),
        heightCategory: json['height_category'] as String,
        massCategory: json['mass_category'] as String,
        weightCategory: json['weight_category'] as String,
        creatorId: json['creator_id'] as String,
        createdAt: json['created_at'] as String,
      );
    } catch (e) {
      print('Error in NutritionHistory.fromJson: $e');
      print('JSON data: $json');
      rethrow;
    }
  }
}
