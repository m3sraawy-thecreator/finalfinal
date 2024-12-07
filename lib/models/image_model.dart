class ImageModel {
  final String filePath;

  ImageModel({required this.filePath});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(filePath: json['file_path']);
  }
}
