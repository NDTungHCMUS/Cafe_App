import 'package:cafe_app/models/Detail_Info.dart';
import 'package:flutter/material.dart';
import 'package:cafe_app/models/Cafe_Type.dart';
import 'package:cafe_app/models/Orders.dart';
import 'package:intl/intl.dart';
class RadeemScr extends StatefulWidget{
  RadeemScr({super.key, required this.listCafeType, required this.toRewardScr, required this.listOrder, required this.totalPoint, required this.toMyOrderScr, required this.updateTotalPoint});

  List<CafeType> listCafeType;
  List<Order> listOrder;
  void Function() toRewardScr;
  void Function() toMyOrderScr;
  void Function(int) updateTotalPoint;
  int totalPoint;

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  OutlinedButton(
                    onPressed: widget.toRewardScr,
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder( // Xác định hình dạng của viền
                        borderRadius: BorderRadius.circular(10), // Độ cong của viền
                      ),
                      side: const BorderSide(
                        color: Colors.black, // Màu của viền
                        width: 1.0, // Độ dày   của viền
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_back_sharp,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(width: 90),

                  const Text(
                    'Radeem',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 30),

              Expanded(
                child: ListView.separated(
                  itemCount: widget.listCafeType.length,
                  separatorBuilder: (context, index) => const Divider(color: Colors.black),
                  itemBuilder: (context, index){
                    return cafeTypeItem(index);
                  }
                ),
              ),

              

              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue.shade300,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Point',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.totalPoint.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
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
          Expanded(child: widget.listCafeType[index]),
          const SizedBox(width: 40),
          Text('Valid until 01/01/24', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.orange.shade300)),
          const SizedBox(width: 40),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: (){
                change(index);
              },
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
            ),
          )
        ],
      ),
    );
  }

  void change(int index) {
    if (widget.totalPoint >= 50){
      DateTime now = DateTime.now();
      int day = now.day;
      String month = DateFormat('MMMM').format(now);
      int hour = now.hour;
      int minute = now.minute;
      DetailInfo detailInfo = DetailInfo(name: widget.listCafeType[index].name, type: 0, nums: 1, shot: 0, select: 0, size: 0, ice: 0, price: 0);
      setState(() {
        widget.totalPoint -= 50;
        widget.listOrder.add(Order(day: day, month: month, hour: hour, minute: minute, detailInfo: detailInfo, point: 0));
      });
      widget.updateTotalPoint(widget.totalPoint);
      final snackBar = SnackBar(content: Text('Successfull'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // Wait for 1 second before navigating to MyOrder_Scr
      Future.delayed(Duration(seconds: 1), () {
        widget.toMyOrderScr();
      });
    }
  }
}