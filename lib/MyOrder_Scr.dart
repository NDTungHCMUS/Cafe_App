import 'package:flutter/material.dart';
import 'package:cafe_app/models/Orders.dart';
import 'package:cafe_app/widget/Order_widget.dart';
import 'package:cafe_app/models/User.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
class MyOrderScr extends StatefulWidget {
  MyOrderScr({required this.updateTotalPoint, required this.updateLoyaltyCard, required this.numberLoyaltyCard, required this.totalPoint, required this.listHistory, required this.listOrder, required this.myUser, super.key});
  List<Order> listOrder;
  List<Order> listHistory;
  void Function(int) updateLoyaltyCard;
  void Function(int) updateTotalPoint;
  User myUser;
  int numberLoyaltyCard;
  int totalPoint;
  @override
  State<MyOrderScr> createState(){
    return _MyOrderScrState();
  }
  
}

class _MyOrderScrState extends State<MyOrderScr>  {
  int selected = 0;
  void swapState(){
    setState(() {
      selected = 1 - selected;
    });
  }
  @override
  Widget build(context) {
    List<Color?> textColors = List<Color?>.filled(2, null);
    List<Color?> rectangleColors = List<Color?>.filled(2, null);
    if (selected == 0) {
      textColors[0] = Colors.black;
      rectangleColors[0] = const Color(0xff324a59);
      textColors[1] = Colors.grey;
      rectangleColors[1] = Colors.grey;
    }
    else {
      textColors[1] = Colors.black;
      rectangleColors[1] = const Color(0xff324a59);
      textColors[0] = Colors.grey;
      rectangleColors[0] = Colors.grey;
    }
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                'My Order',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )
              ),
      
              const SizedBox(height: 30),
      
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // On Going
                  TextButton(
                    onPressed: (){
                      swapState();
                    },
                    child: Column(
                      children: [
                        Text(
                          'On Going',
                          style: TextStyle(
                            color: textColors[0],
                            fontWeight: FontWeight.bold,
                          )
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: 70,
                          height: 5,
                          decoration: BoxDecoration(
                            color: rectangleColors[0],
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  
                  // History
                  TextButton(
                    onPressed: (){
                      swapState();
                    },
                    child: Column(
                      children: [
                        Text(
                          'History',
                          style: TextStyle(
                            color: textColors[1],
                            fontWeight: FontWeight.bold,
                          )
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: 70,
                          height: 5,
                          decoration: BoxDecoration(
                            color: rectangleColors[1],
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ), 
      
              const Divider(
                color: Color(0xff324a59), // Màu của đường gạch ngang
                thickness: 2,    // Độ dày của đường gạch ngang
              ),
    
              const SizedBox(height: 10),
        
              Expanded(
                child: (selected == 0) ? OrderWidget(selected: 0, listShow: widget.listOrder, myUser: widget.myUser, listAdd: widget.listHistory, numberLoyaltyCard: widget.numberLoyaltyCard, updateLoyaltyCardCount: widget.updateLoyaltyCard, totalPoint: widget.totalPoint, updateTotalPoint: widget.updateTotalPoint) 
                                       : OrderWidget(selected: 1, listShow: widget.listHistory, listAdd: widget.listOrder, myUser: widget.myUser, numberLoyaltyCard: widget.numberLoyaltyCard, updateLoyaltyCardCount: widget.updateLoyaltyCard, totalPoint: widget.totalPoint, updateTotalPoint: widget.updateTotalPoint),
              )
    
            ],
          ),
        ),
      ),
    );
  }
}