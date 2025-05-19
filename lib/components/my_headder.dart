import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHeadder extends StatefulWidget {
  const MyHeadder({super.key});

  @override
  State<MyHeadder> createState() => _MyHeadderState();
}

class _MyHeadderState extends State<MyHeadder> {
  @override
  Widget build(BuildContext context) {
    bool isDark = true;

    void toggleMode(bool value) {
      setState(() {
        isDark = !value;
      });
    }

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
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Text(
                'Welcome to Movie Mess',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              )
            ],
          ),
          Row(
            children: [
              Text('Dark'),
              Transform.scale(
                scale: 0.7,
                child: CupertinoSwitch(
                  value: isDark,
                  onChanged: toggleMode,
                  activeTrackColor: Colors.blueAccent.shade400,
                ),
              ),
            ],
          ),
        ],  
      ),
    );
  }
}
