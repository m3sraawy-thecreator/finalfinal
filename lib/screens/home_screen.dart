import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/app_cubit.dart';
import '../cubits/app_states.dart';
import 'information_screen.dart';
import '../models/person_model.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AppCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Famous Persons'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              // Navigate to Favorites Screen
            },
          ),
        ],
      ),
      body: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PersonsLoadedState) {
            return ListView.builder(
              itemCount: cubit.persons.length,
              itemBuilder: (context, index) {
                final person = cubit.persons[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://image.tmdb.org/t/p/w200/${person.profilePath}'),
                  ),
                  title: Text(person.name),
                  trailing: IconButton(
                    icon: Icon(
                      cubit.favorites.contains(person)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: cubit.favorites.contains(person)
                          ? Colors.red
                          : Colors.grey,
                    ),
                    onPressed: () {
                      cubit.toggleFavorite(person);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              InformationScreen(person.id)),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('Error loading data.'));
          }
        },
      ),
    );
  }
}
