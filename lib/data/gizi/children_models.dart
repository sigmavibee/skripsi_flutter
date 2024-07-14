class Child {
  final String id;
  final String childName;
  final String childNik;
  final String childVillage;
  final DateTime dateOfBirth;
  final String gender;
  final String latestAge;
  final double latestHeight;
  final double latestWeight;
  final double latestBmi;
  final String latestHeightCategory;
  final String latestMassCategory;
  final String latestWeightCategory;
  final String creatorUsername;
  final String creatorProfile;
  final DateTime createdAt;

  Child({
    required this.id,
    required this.childName,
    required this.childNik,
    required this.childVillage,
    required this.dateOfBirth,
    required this.gender,
    required this.latestAge,
    required this.latestHeight,
    required this.latestWeight,
    required this.latestBmi,
    required this.latestHeightCategory,
    required this.latestMassCategory,
    required this.latestWeightCategory,
    required this.creatorUsername,
    required this.creatorProfile,
    required this.createdAt,
  });

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json['id'],
      childName: json['child_name'],
      childNik: json['child_nik'],
      childVillage: json['child_village'],
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      gender: json['gender'],
      latestAge: json['latest_age'],
      latestHeight: double.parse(json['latest_height'].toString()),
      latestWeight: double.parse(json['latest_weight'].toString()),
      latestBmi: double.parse(json['latest_bmi'].toString()),
      latestHeightCategory: json['latest_height_category'],
      latestMassCategory: json['latest_mass_category'],
      latestWeightCategory: json['latest_weight_category'],
      creatorUsername: json['creator_username'],
      creatorProfile: json['creator_profile'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
