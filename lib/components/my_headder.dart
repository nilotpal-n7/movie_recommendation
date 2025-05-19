import 'package:flutter/material.dart';
import 'package:movie_recommendation/components/my_switch.dart';
import 'package:movie_recommendation/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class MyHeadder extends StatefulWidget {
  const MyHeadder({super.key});

  @override
  State<MyHeadder> createState() => _MyHeadderState();
}

class _MyHeadderState extends State<MyHeadder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Text(
                'Welcome to Movie Mess',
                style: TextStyle(
                  fontSize: 12,
                ),
              )
            ],
          ),
          MySwitch(
            mainAxisAlignment: MainAxisAlignment.start,
            text: 'Dark',
            value: Provider.of<ThemeProvider>(context).isDarkMode,
            onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
          )
        ],  
      ),
    );
  }
}
