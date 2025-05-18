import 'package:flutter/material.dart';
import 'package:movie_recommendation/components/bottom_nav_bar.dart';
import 'package:movie_recommendation/components/header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavBar(), // define below
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(),
          ],
        ),
      ),
    );
  }
}
