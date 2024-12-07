import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/app_cubit.dart';
import '../cubits/app_states.dart';
import '../models/image_model.dart';
import 'image_viewer_screen.dart';

class InformationScreen extends StatelessWidget {
  final int personId;

  const InformationScreen(this.personId, {super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AppCubit>(context);

    // Fetch person details and images
    cubit.fetchPersonDetails(personId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Person Details'),
      ),
      body: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PersonDetailsLoadedState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      cubit.personDetails['name'] ?? 'Unknown',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      cubit.personDetails['biography'] ?? 'No biography available.',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Images',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cubit.personImages.length,
                      itemBuilder: (context, index) {
                        final ImageModel image = cubit.personImages[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ImageViewerScreen(image.filePath),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w200/${image.filePath}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Error loading person details.'));
          }
        },
      ),
    );
  }
}
