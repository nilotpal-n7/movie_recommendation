import 'package:flutter/material.dart';
import 'package:movie_recommendation/services/storage_service.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _favourite = [];

  List<Map<String, dynamic>> get favourite => _favourite;

  FavoriteProvider() {
    loadFav();
  }

  void addMovie(Map<String, dynamic> movie) {
    _favourite.insert(0, movie);
    StorageService.saveStringList('favourite', _favourite);
    notifyListeners();
  }

  void removeMovieAt(int index) {
    _favourite.removeAt(index);
    StorageService.saveStringList('favourite', _favourite);
    notifyListeners();
  }

  void clearFav() {
    _favourite.clear();
    StorageService.saveStringList('favourite', _favourite);
    notifyListeners();
  }

  Future<void> loadFav() async {
    _favourite = await StorageService.loadStringList('favourite');
    notifyListeners();
  }
}
