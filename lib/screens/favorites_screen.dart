import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/app_cubit.dart';
import '../models/person_model.dart';
import 'information_screen.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AppCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: cubit.favorites.isEmpty
          ? Center(
        child: Text(
          'No favorites added yet.',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: cubit.favorites.length,
        itemBuilder: (context, index) {
          final PersonModel person = cubit.favorites[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://image.tmdb.org/t/p/w200/${person.profilePath}'),
            ),
            title: Text(person.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InformationScreen(person.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
