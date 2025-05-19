import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_recommendation/models/movie.dart';

class MovieService {
  final String _baseUrl = 'https://tmdb-proxy-backend.vercel.app/api';

  Future<Movie> fetchMovieDetails(String text, int movieId) async {
    final url = Uri.parse('$_baseUrl/$text/$movieId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Movie.fromJson(json);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  Future<List<Movie>> searchMoviesByTitle(String text, String title) async {
    final url = Uri.parse('$_baseUrl/$text/search?query=${Uri.encodeComponent(title)}');
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
  Future<List<Movie>> fetchPopularMovies(String text) async {
    final url = Uri.parse('$_baseUrl/$text/popular');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List results = json['results'];
      return results.map((movieJson) => Movie.fromSummaryJson(movieJson)).toList();
    } else {
      throw Exception('Failed to fetch popular movies');
    }
  }

  Future<List<Movie>> fetchTrendingMovies(String text) async {
    final url = Uri.parse('$_baseUrl/$text/trending');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List results = json['results'];
      return results.map((movieJson) => Movie.fromSummaryJson(movieJson)).toList();
    } else {
      throw Exception('Failed to fetch popular movies');
    }
  }

  Future<List<Movie>> getMoviesByGenre(String text, int genre) async {
    final url = Uri.parse('$_baseUrl/$text/genre?genreId=$genre}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List results = json['results'];
      return results.map((movieJson) => Movie.fromSummaryJson(movieJson)).toList();
    } else {
      throw Exception('Failed to fetch movies by genre');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.parse('$_baseUrl/search/search?search=${Uri.encodeComponent(query)}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];

      return (results)
          .map((json) => Movie.fromSummaryJson(json))
          .toList();
    } else {
      throw Exception('Failed to search movies');
    }
  }
}
