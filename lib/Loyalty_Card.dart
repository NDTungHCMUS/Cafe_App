import 'package:flutter/material.dart';

class LoyaltyCard extends StatelessWidget {
  LoyaltyCard({required this.used, super.key});
  bool used;
  @override
  Widget build(context) {
    String url;
    if (used) {
      url = 'assets/image/coffee-cup-1.png';
    }
    else {
      url = 'assets/image/coffee-cup-2.png';
    }
    return Container(
      child: Image.asset(url, scale: 0.85),
    );
  }
}