import 'package:flutter/material.dart';
import 'package:cafe_app/models/Cafe_Type.dart';

class CafeTypeGrid extends StatelessWidget {
  const CafeTypeGrid({required this.cafetype, super.key});

  final CafeType cafetype;
  @override
  Widget build(context) {

    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color.fromARGB(255, 14, 57, 51), width: 2.0),
        ),
        child: Center(
            child: cafetype,
        ) 
    );
    
  }
}