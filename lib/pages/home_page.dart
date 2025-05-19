import 'package:flutter/material.dart';
import 'package:movie_recommendation/components/my_bottom_nav_bar.dart';
import 'package:movie_recommendation/components/my_carousel.dart';
import 'package:movie_recommendation/components/my_category.dart';
import 'package:movie_recommendation/components/my_headder.dart';
import 'package:movie_recommendation/components/my_list_view.dart';
import 'package:movie_recommendation/components/my_listview_genre.dart';
import 'package:movie_recommendation/pages/favourite_page.dart';
import 'package:movie_recommendation/pages/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  TextEditingController controller = TextEditingController();

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      // Home tab
      CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: MyHeadder()),
          SliverToBoxAdapter(child: MyCarousel(category: 'movie')),
          SliverToBoxAdapter(child: MyCategory(text: 'Trending Movies')),
          SliverToBoxAdapter(child: MyListView(category: 'movie')),
          SliverToBoxAdapter(child: MyCategory(text: 'Popular TV Shows')),
          SliverToBoxAdapter(child: MyListView(category: 'tv')),
          SliverToBoxAdapter(child: MyCategory(text: 'New Animes')),
          SliverToBoxAdapter(child: MyListView(category: 'anime', isAnime: true)),
          SliverToBoxAdapter(child: MyCategory(text: 'Fantasy')),
          SliverToBoxAdapter(child: MyListViewGenre(category: 'movie', genreId: 12)),
          SliverToBoxAdapter(child: MyCategory(text: 'Sci-Fi')),
          SliverToBoxAdapter(child: MyListViewGenre(category: 'movie', genreId: 878)),
        ],
      ),

      // Search tab
      Column(
        children: [
          MyHeadder(),
          const Expanded(child: SearchPage()),
        ],
      ),

      // Favorites tab
      Column(
        children: [
          MyHeadder(),
          const Expanded(child: FavouritePage()),
        ],
      ),
    ];
  }

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
    );
  }
}
