import 'package:flutter/material.dart';

class MyListView extends StatelessWidget {
  final String category;

  const MyListView({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = List.generate(
      5,
      (index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 150,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text('${index + 1}'),
      ),
    );

    return SizedBox(
      height: 150, // Set a fixed height
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: items,
        ),
      ),
    );
  }
}
