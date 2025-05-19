import 'package:flutter/material.dart';
import 'package:movie_recommendation/models/movie.dart';
import 'package:movie_recommendation/pages/movie_detail_page.dart';
import 'package:movie_recommendation/providers/theme_provider.dart';
import 'package:movie_recommendation/services/movie_service.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final MovieService _service = MovieService();
  List<Movie> _results = [];
  bool _isLoading = false;

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _results = [];
      });
      return;
    }

    setState(() => _isLoading = true);
    try {
      final results = await _service.searchMovies(query);
      print('kjgsckjjvkhq $results');
      setState(() {
         final filtered = results
      .where((movie) => movie.title.trim().isNotEmpty)
      .toList();

      filtered.sort((a, b) => b.popularity.compareTo(a.popularity));

      _results = filtered.take(10).toList();
      });
    } catch (e) {
      debugPrint('Search error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              onChanged: _performSearch,
              decoration: InputDecoration(
                hintText: 'Search movies or TV shows...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Theme.of(context).cardColor,
              ),
            ),
          ),
      
          // Results
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _results.isEmpty
                    ? const Center(child: Text('No results'))
                    : ListView.builder(
                      itemCount: _results.length,
                      itemBuilder: (context, index) {
                        final movie = _results[index];
      
      
                        //return tiles
                        return Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: context.read<ThemeProvider>().isDarkMode
                                ? Colors.grey.shade800
                                : Colors.grey.shade100,
                            ),
                            child: GestureDetector(
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                                child: Row(
                                  children: [
                                    movie.posterPath.isNotEmpty
                                      ? Image.network(
                                          'https://image.tmdb.org/t/p/w92${movie.posterPath}',
                                          fit: BoxFit.cover,
                                        )
                                      : const Icon(Icons.movie),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        
                                            Text(
                                              movie.title,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),

                                            const SizedBox(height: 10),
      
                                            Text(
                                              movie.overview,
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: Theme.of(context).colorScheme.primary,
                                                fontSize: 12,
                                              ),
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),

                                            const SizedBox(height: 10),

                                            Text(
                                              '⭐ ${movie.voteAverage}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: Theme.of(context).colorScheme.primary,
                                                fontSize: 12,
                                              ),
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
      
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailPage(movieId: movie.id, category: movie.mediaType)));
                              },
                            ),
                        );
                      }
                ),
          ),
        ],
      ),
    );
  }
}
