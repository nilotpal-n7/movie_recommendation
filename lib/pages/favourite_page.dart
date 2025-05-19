import 'package:flutter/material.dart';
import 'package:movie_recommendation/pages/movie_detail_page.dart';
import 'package:movie_recommendation/providers/favorite_provider.dart';
import 'package:movie_recommendation/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    final favourite = context.watch<FavoriteProvider>().favourite;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Favourite Movies',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                textAlign: TextAlign.center,
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<FavoriteProvider>(context, listen: false).clearFav();
                },
                child: Text(
                  'Clear all',
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if(favourite.isEmpty) Center(
            child: Text(
              'No movie saved yet.',
              style: TextStyle(
                color: Colors.grey.shade300,
              ),
            ),
          )
          else Expanded(
            child: ListView.builder(
                itemCount: favourite.length,
                itemBuilder: (context, index) {
                  final movie = favourite[index];
                  return Dismissible(
                    key: Key(movie['id'].toString() + index.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.centerRight,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) {
                      context.read<FavoriteProvider>().removeMovieAt(index);
                    },
                    child: Container(
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
                              Image.network(
                                "https://image.tmdb.org/t/p/w500${movie['posterPath']}",
                                width: 70,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                   
                                      Text(
                                        movie['title'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                
                                      Text(
                                        movie['tagline'],
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailPage(movieId: movie['id'], category: movie['media_type'])));
                        },
                      ),
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
