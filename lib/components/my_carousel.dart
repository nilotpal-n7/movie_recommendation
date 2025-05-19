import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_recommendation/models/movie.dart';
import 'package:movie_recommendation/pages/movie_detail_page.dart';
import 'package:movie_recommendation/services/movie_service.dart';

class MyCarousel extends StatefulWidget {
  final String category;
  const MyCarousel({super.key, required this.category});

  @override
  State<MyCarousel> createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  int _currentIndex = 0;
  final MovieService service = MovieService();
  List<Movie> _movies = [];

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  Future<void> loadMovies() async {
    try {
      final fetched = await service.fetchPopularMovies(widget.category);
      setState(() => _movies = fetched.take(5).toList()); // Only top 5
    } catch (e) {
      debugPrint('Error fetching movies: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_movies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            height: 300,
            aspectRatio: 1,
            viewportFraction: 0.7,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: _movies.map((movie) {
            final imageUrl = 'https://image.tmdb.org/t/p/w500${movie.posterPath}';
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MovieDetailPage(category: widget.category ,movieId: movie.id),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.broken_image, size: 60, color: Colors.grey),
                    );
                  },
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_movies.length, (index) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index
                    ? Colors.white
                    : Colors.white.withAlpha(40),
              ),
            );
          }),
        ),
      ],
    );
  }
}
