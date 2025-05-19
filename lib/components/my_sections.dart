import 'package:flutter/material.dart';

class MySections extends StatelessWidget {
  final String currentSection;
  final Function(String) onTap;

  const MySections({
    super.key,
    required this.currentSection,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => onTap('Movies'),
            child: Text(
              'Movies',
              style: TextStyle(
                color: Colors.white,
                fontWeight: currentSection == 'Movies' 
                ? FontWeight.w600
                : FontWeight.w300,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onTap('Animes'),
            child: Text(
              'Animes',
              style: TextStyle(
                color: Colors.white,
                fontWeight: currentSection == 'Animes' 
                ? FontWeight.w600
                : FontWeight.w300,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onTap('TV Shows'),
            child: Text(
              'TV Shows',
              style: TextStyle(
                color: Colors.white,
                fontWeight: currentSection == 'TV Shows' 
                ? FontWeight.w600
                : FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
