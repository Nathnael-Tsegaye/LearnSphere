import 'package:flutter/material.dart';

class progress extends StatelessWidget {
  const progress ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Progress"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child:  Container(
         height: 100,
         width: 200,
         decoration: BoxDecoration(
         color:Colors.grey[800],

         ),
         )

      ),
    );
  }
}