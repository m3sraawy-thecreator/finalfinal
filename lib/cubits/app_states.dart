abstract class AppStates {}

class AppInitialState extends AppStates {}

class PersonsLoadedState extends AppStates {}

class PersonDetailsLoadedState extends AppStates {}

class ImagesLoadedState extends AppStates {}

class FavoritesUpdatedState extends AppStates {}

class LoadingState extends AppStates {}

class ErrorState extends AppStates {
  final String error;
  ErrorState(this.error);
}
