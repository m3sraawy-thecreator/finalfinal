import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> favoritePersons;

  const FavoritesScreen({Key? key, required this.favoritePersons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
      ),
      body: favoritePersons.isEmpty
          ? const Center(
        child: Text(
          'No favorites added!',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: favoritePersons.length,
        itemBuilder: (context, index) {
          final person = favoritePersons[index];

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
          );
        },
      ),
    );
  }
}
