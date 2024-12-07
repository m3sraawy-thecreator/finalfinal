class PersonModel {
  final int id;
  final String name;
  final String? profilePath;

  PersonModel({
    required this.id,
    required this.name,
    this.profilePath,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      profilePath: json['profile_path'],
    );
  }
}
