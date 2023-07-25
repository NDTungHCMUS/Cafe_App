import 'package:flutter/material.dart';

class CafeType extends StatelessWidget {

  const CafeType({required this.name, required this.type, super.key});

  final int type;

  final String name;

  @override
  Widget build(context) {
    String url =  'assets/image/coffee-type-' + '$type' + '.png';
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(url),
        SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}