class PersonModel {
  final int id;
  final String name;
  final String profilePath;

  PersonModel({required this.id, required this.name, required this.profilePath});

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path'] ?? '',
    );
  }
}
