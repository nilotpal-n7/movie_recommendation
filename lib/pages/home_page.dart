import 'package:flutter/material.dart';
import 'package:movie_recommendation/components/my_bottom_nav_bar.dart';
import 'package:movie_recommendation/components/my_carousel.dart';
import 'package:movie_recommendation/components/my_category.dart';
import 'package:movie_recommendation/components/my_headder.dart';
import 'package:movie_recommendation/components/my_list_view.dart';
import 'package:movie_recommendation/components/my_sections.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String _currentSection = 'Movies';

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onSectionTapped(String section) {
    setState(() {
      _currentSection = section;
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyHeadder(),
              MySections(
                currentSection: _currentSection,
                onTap: _onSectionTapped,
              ),
              MyCarousel(),
              MyCategory(text: _currentSection),
              MyListView(category: ''),
            ],
          ),
        ),
      ),
    );
  }
}
