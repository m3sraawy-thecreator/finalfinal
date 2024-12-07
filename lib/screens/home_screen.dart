import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'favorites_screen.dart';
import 'information_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> famousPersons = [];
  List<int> favoriteList = [];

  @override
  void initState() {
    super.initState();
    fetchFamousPersons();
  }

  Future<void> fetchFamousPersons() async {
    final url =
        'https://api.themoviedb.org/3/person/popular?api_key=2dfe23358236069710a379edd4c65a6b';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          famousPersons = json.decode(response.body)['results'];
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Famous Persons'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(
                    favoritePersons: famousPersons
                        .where((person) => favoriteList.contains(person['id']))
                        .cast<Map<String, dynamic>>()
                        .toList(),
                  ),
                ),
              );
            },
          ),
        ],


      ),
      body: famousPersons.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: famousPersons.length,
        itemBuilder: (context, index) {
          final person = famousPersons[index];
          final isFavorite = favoriteList.contains(person['id']);

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: person['profile_path'] != null
                  ? NetworkImage(
                  'https://image.tmdb.org/t/p/w200${person['profile_path']}')
                  : null,
              child: person['profile_path'] == null
                  ? const Icon(Icons.person)
                  : null,
            ),
            title: Text(person['name'] ?? 'Unknown'),
            trailing: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  if (isFavorite) {
                    favoriteList.remove(person['id']);
                  } else {
                    favoriteList.add(person['id']);
                  }
                });
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailsScreen(personId: person['id']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
