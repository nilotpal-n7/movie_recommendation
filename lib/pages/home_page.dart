import 'package:flutter/material.dart';
import 'package:movie_recommendation/components/my_bottom_nav_bar.dart';
import 'package:movie_recommendation/components/my_carousel.dart';
import 'package:movie_recommendation/components/my_category.dart';
import 'package:movie_recommendation/components/my_headder.dart';
import 'package:movie_recommendation/components/my_list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: MyBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // HEADER
            SliverToBoxAdapter(child: MyHeadder()),

            // CAROUSEL
            SliverToBoxAdapter(child: MyCarousel(category: 'movie')),

            // MOVIES
            SliverToBoxAdapter(child: MyCategory(text: 'Trending Movies')),
            SliverToBoxAdapter(child: MyListView(category: 'movie')),

            // TV SHOWS
            SliverToBoxAdapter(child: MyCategory(text: 'Trending TV Shows')),
            SliverToBoxAdapter(child: MyListView(category: 'tv')),

            // ANIME
            SliverToBoxAdapter(child: MyCategory(text: 'Trending Animes')),
            SliverToBoxAdapter(child: MyListView(category: 'anime', isAnime: true)),
          ],
        ),
      ),
    );
  }
}
