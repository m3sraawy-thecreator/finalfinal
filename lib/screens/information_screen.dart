import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailsScreen extends StatefulWidget {
  final int personId;

  const DetailsScreen({Key? key, required this.personId}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Map<String, dynamic>? personDetails;
  List<dynamic> personImages = [];

  @override
  void initState() {
    super.initState();
    fetchPersonDetails();
    fetchPersonImages();
  }

  Future<void> fetchPersonDetails() async {
    final url =
        'https://api.themoviedb.org/3/person/${widget.personId}?api_key=2dfe23358236069710a379edd4c65a6b';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          personDetails = json.decode(response.body);
        });
      }
    } catch (e) {
      print('Error fetching details: $e');
    }
  }

  Future<void> fetchPersonImages() async {
    final url =
        'https://api.themoviedb.org/3/person/${widget.personId}/images?api_key=2dfe23358236069710a379edd4c65a6b';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          personImages = json.decode(response.body)['profiles'];
        });
      }
    } catch (e) {
      print('Error fetching images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Person Details')),
      body: personDetails == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            Text(
              personDetails!['name'] ?? 'Unknown',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(personDetails!['biography'] ?? 'No biography available'),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              itemCount: personImages.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final image = personImages[index];
                return Image.network(
                  'https://image.tmdb.org/t/p/w500${image['file_path']}',
                  fit: BoxFit.cover,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
