import 'package:flutter/material.dart';
import 'package:movie_recommendation/models/movie.dart';
import 'package:movie_recommendation/pages/movie_detail_page.dart';
import 'package:movie_recommendation/services/movie_service.dart';

class MyListView extends StatefulWidget {
  final String category;
  final bool isAnime;

  const MyListView({
    super.key,
    required this.category,
    this.isAnime = false,
  });

  @override
  State<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  final MovieService service = MovieService();

  List<Movie> _movies = [];

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void> loadMovies() async {
    try {
      final fetched = await service.fetchTrendingMovies(widget.category);
      fetched.shuffle();
      setState(() => _movies = fetched.take(10).toList()); // Only top 5
    } catch (e) {
      debugPrint('Error fetching movies: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_movies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox(
      height: 150, // Set a fixed height
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: _movies.map((movie) {
            final imageUrl = 'https://image.tmdb.org/t/p/w500${movie.posterPath}';
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MovieDetailPage(category: widget.isAnime ? 'tv' : widget.category, movieId: movie.id),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    height: 150,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.broken_image, size: 60, color: Colors.grey),
                      );
                    },
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
