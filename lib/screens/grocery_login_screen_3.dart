import 'package:flutter/material.dart';

class GroceryLoginScreen3 extends StatefulWidget {
  const GroceryLoginScreen3({super.key});

  @override
  State<GroceryLoginScreen3> createState() => _GroceryLoginScreen3State();
}

class _GroceryLoginScreen3State extends State<GroceryLoginScreen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset('images/bottom_bg.png'),
          )
        ],
      ),
    );
  }
}