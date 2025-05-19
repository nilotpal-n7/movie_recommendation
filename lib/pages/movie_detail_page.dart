import 'package:flutter/material.dart';
import 'package:movie_recommendation/models/movie.dart';
import 'package:movie_recommendation/providers/favorite_provider.dart';
import 'package:movie_recommendation/services/movie_service.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;
  final String category;

  const MovieDetailPage({
    super.key,
    required this.movieId,
    required this.category
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late Future<Movie> _movieFuture;
  final MovieService service = MovieService();

  @override
  void initState() {
    super.initState();
    _movieFuture = service.fetchMovieDetails(widget.category, widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final isFav = context.watch<FavoriteProvider>().isFavorite(widget.movieId, widget.category);

    return Scaffold(
      body: FutureBuilder<Movie>(
        future: _movieFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found.'));
          }

          final movie = snapshot.data!;
          final languages = movie.spokenLanguages.map((l) => l.englishName).join(', ');
          final countries = movie.productionCountries.map((c) => c.name).join(', ');
          final companies = movie.productionCompanies.map((p) => p.name).join(', ');

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (movie.posterPath.isNotEmpty)
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          //height: 350,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
            
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (movie.tagline.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            movie.tagline,
                            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[600]),
                          ),
                        ),
                        
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: isFav ? Colors.red : Colors.white,
                        ),
                        onPressed: () {
                          final provider = context.read<FavoriteProvider>();
                          
                          if (isFav) {
                            final index = provider.favourite.indexWhere((item) =>
                                item['id'] == movie.id && item['media_type'] == widget.category);
                            if (index != -1) provider.removeMovieAt(index);
                            
                          } else {
                            provider.addMovie({
                              'id': movie.id,
                              'title': movie.title,
                              'tagline': movie.tagline,
                              'media_type': widget.category,
                              'posterPath': movie.posterPath,
                            });
                          }
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
            
                  Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 18, color: Colors.grey[700]),
                      const SizedBox(width: 6),
                      Text('Release: ${movie.releaseDate}'),
                      const SizedBox(width: 16),
                      Icon(Icons.access_time, size: 18, color: Colors.grey[700]),
                      const SizedBox(width: 6),
                      Text('${movie.runtime} min'),
                    ],
                  ),
                  const SizedBox(height: 10),
            
                  Wrap(
                    spacing: 8,
                    children: movie.genres
                      .map((genre) => Chip(
                          label: Text(genre.name),
                          backgroundColor: Colors.blueGrey[100],
                        ))
                      .toList(),
                  ),
            
                  const SizedBox(height: 16),
                  _buildSectionTitle(context, 'Overview'),
                  Text(movie.overview),
            
                  const SizedBox(height: 16),
                  _buildSectionTitle(context, 'Language(s)'),
                  Text(languages),
            
                  const SizedBox(height: 16),
                  _buildSectionTitle(context, 'Production Countries'),
                  Text(countries),
            
                  const SizedBox(height: 16),
                  _buildSectionTitle(context, 'Production Companies'),
                  Text(companies),
            
                  const SizedBox(height: 16),
                  _buildSectionTitle(context, 'IMDb ID'),
                  Text(movie.imdbId),
            
                  const SizedBox(height: 16),
                  _buildSectionTitle(context, 'Budget & Revenue'),
                  Text('\$${movie.budget.toString()} budget, \$${movie.revenue.toString()} revenue'),
            
                  const SizedBox(height: 16),
                  _buildSectionTitle(context, 'Rating'),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 6),
                      Text('${movie.voteAverage} (${movie.voteCount} votes)'),
                    ],
                  ),
            
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}
