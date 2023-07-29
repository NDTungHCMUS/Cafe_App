import 'package:flutter/material.dart';
import 'package:cafe_app/models/Cafe_Type.dart';

class RadeemScr extends StatefulWidget{
  RadeemScr({super.key, required this.listCafeType});

  List<CafeType> listCafeType;
  @override
  State<RadeemScr> createState() => _RadeemScrState();
}

class _RadeemScrState extends State<RadeemScr> {
  @override
  Widget build(context){
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: widget.listCafeType.length,
                  separatorBuilder: (context, index) => const Divider(color: Colors.black),
                  itemBuilder: (context, index){
                    return cafeTypeItem(index);
                  }
                ),
              ),
            ],
          ),
        )
      )
    );
  }
  
  Widget cafeTypeItem(int index){
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.listCafeType[index],
          const SizedBox(width: 100),
          TextButton(
            onPressed: (){},
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xff324a59), // Màu nền của nút
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Bán kính bo góc của nút
              ),
            ),
            child: const Text(
              '50 pts',
              style: TextStyle(
                color: Colors.white,
              )
            )
          )
        ],
      ),
    );
  }
}