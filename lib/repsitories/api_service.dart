import 'package:dio/dio.dart';

class ApiService {
  static const String apiKey = "2dfe23358236069710a379edd4c65a6b";
  static const String baseUrl = "https://api.themoviedb.org/3";

  final Dio dio = Dio();

  Future<List<dynamic>> fetchPopularPersons() async {
    final response = await dio.get('$baseUrl/person/popular?api_key=$apiKey');
    return response.data['results'];
  }

  Future<Map<String, dynamic>> fetchPersonDetails(int id) async {
    final response = await dio.get('$baseUrl/person/$id?api_key=$apiKey');
    return response.data;
  }

  Future<List<dynamic>> fetchPersonImages(int id) async {
    final response = await dio.get('$baseUrl/person/$id/images?api_key=$apiKey');
    return response.data['profiles'];
  }
}
