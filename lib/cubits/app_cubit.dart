import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/person_model.dart';
import '../models/image_model.dart';
import '../repsitories/api_service.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  final ApiService apiService;

  AppCubit(this.apiService) : super(AppInitialState());

  List<PersonModel> persons = [];
  List<PersonModel> favorites = [];
  Map<String, dynamic> personDetails = {};
  List<ImageModel> personImages = [];

  void fetchPopularPersons() async {
    emit(LoadingState());
    try {
      final response = await apiService.fetchPopularPersons();
      persons = response.map((data) => PersonModel.fromJson(data)).toList();
      emit(PersonsLoadedState());
    } catch (error) {
      emit(ErrorState(error.toString()));
    }
  }

  void fetchPersonDetails(int id) async {
    emit(LoadingState());
    try {
      final details = await apiService.fetchPersonDetails(id);
      final images = await apiService.fetchPersonImages(id);

      personDetails = details;
      personImages = images.map((data) => ImageModel.fromJson(data)).toList();
      emit(PersonDetailsLoadedState());
    } catch (error) {
      emit(ErrorState(error.toString()));
    }
  }

  void toggleFavorite(PersonModel person) {
    if (favorites.contains(person)) {
      favorites.remove(person);
    } else {
      favorites.add(person);
    }
    emit(FavoritesUpdatedState());
  }
}
