import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_recommendation/models/movie.dart';

class MovieService {
  final String _baseUrl = 'https://tmdb-proxy-backend.vercel.app/api';

  /// Fetch movie details by ID
  Future<Movie> fetchMovieDetails(int movieId) async {
    final url = Uri.parse('$_baseUrl/movie/$movieId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Movie.fromJson(json);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  /// Search movies by title
  Future<List<Movie>> searchMoviesByTitle(String title) async {
    final url = Uri.parse('$_baseUrl/search?query=${Uri.encodeComponent(title)}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List results = json['results'];
      return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
    } else {
      throw Exception('Failed to search movies');
    }
  }

  /// Fetch popular movies
  Future<List<Movie>> fetchPopularMovies() async {
    final url = Uri.parse('$_baseUrl/popular');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List results = json['results'];
      return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
    } else {
      throw Exception('Failed to fetch popular movies');
    }
  }

  /// Fetch movies by genre
  Future<List<Movie>> getMoviesByGenre(String genre) async {
    final url = Uri.parse('$_baseUrl/genre?name=${Uri.encodeComponent(genre)}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List results = json['results'];
      return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
    } else {
      throw Exception('Failed to fetch movies by genre');
    }
  }
}
