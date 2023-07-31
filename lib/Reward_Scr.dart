import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:cafe_app/Loyalty_Card.dart';
import 'package:cafe_app/models/Orders.dart';
import 'package:flutter/scheduler.dart';

class RewardScr extends StatefulWidget {
  RewardScr({super.key, required this.numberLoyaltyCard, required this.toRadeemScr, required this.totalPoint, required this.listHistory, required this.updateLoyaltyCard, required this.updateTotalPoint});

  void Function() toRadeemScr;
  int numberLoyaltyCard;
  int totalPoint;
  List<Order>listHistory;
  void Function(int) updateLoyaltyCard;
  void Function(int) updateTotalPoint;
  @override
  State<RewardScr> createState() => _RewardScrState();
}

class _RewardScrState extends State<RewardScr> {

  @override
  Widget build(context){

    String numberLoyaltyCardStr = '${widget.numberLoyaltyCard}' + '/8';
    print("In Reward " + numberLoyaltyCardStr.toString());

    // List Loyalty Card
    List<LoyaltyCard> listLoyaltyCard = [];
    if (widget.numberLoyaltyCard <= 8){
      for (int i = 0; i < widget.numberLoyaltyCard; i++) {
        listLoyaltyCard.add(LoyaltyCard(used: true));
      }
      for (int i = 0; i < 8 - widget.numberLoyaltyCard; i++){
        listLoyaltyCard.add(LoyaltyCard(used: false));
      }
    }
    else {
      for (int i = 0; i < 8; i++) {
        listLoyaltyCard.add(LoyaltyCard(used: true));
      }
    }


    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  'Rewards',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )
                ),
              ),
              
              const SizedBox(height: 20),

              InkWell(
                onTap: (){
                  setState(() {
                    updateCardAndPoint();
                  });
                },
                child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xff324a59),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Loyalty Card", 
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )
                                ),
                                Text(
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  numberLoyaltyCardStr,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    ...listLoyaltyCard.map((card){
                                      return card;
                                    })
                                  ],
                                ),
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ),

              const SizedBox(height: 15),

              // Point && Radeem
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xff324a59),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Text(
                            'My Points: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 15,
                            )
                          ),
                          const SizedBox(height: 20),
                          Text(
                            widget.totalPoint.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25,
                            )
                          ),
                        ],
                      ),

                      const SizedBox(width: 80),

                      Container(
                        padding: const EdgeInsets.only(top: 15),
                        child: ElevatedButton(
                          onPressed: widget.toRadeemScr,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange.shade300, // Màu nền của nút
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // Bán kính bo góc của nút
                            ),
                          ),
                          child: const Text(
                            'Radeem Drinks',
                            style: TextStyle(
                              color: Colors.white, // Màu chữ
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ),

              const SizedBox(height: 15),

              const Text(
                'History Rewards:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              Expanded(
                child: ListView.separated(
                  itemCount: widget.listHistory.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index){
                    return historyItem(index);
                  }
                ),
              )
            ],
          )
        ),
      )
    );
  }

  void updateCardAndPoint(){
    if (widget.numberLoyaltyCard >= 8) {
      double iDouble = widget.numberLoyaltyCard / 8;
      int iInt = iDouble.toInt();
      widget.numberLoyaltyCard -= 8 * iInt;
      widget.totalPoint += 50 * iInt;
    }
    widget.updateLoyaltyCard(widget.numberLoyaltyCard);
    widget.updateTotalPoint(widget.totalPoint);
  }

  Widget historyItem(int index){
    String dayTime = widget.listHistory[index].day.toString() + " " + widget.listHistory[index].month + " | " + widget.listHistory[index].hour.toString() + ":" + widget.listHistory[index].minute.toString() + " PM";
    String pointHere = '+ ' + widget.listHistory[index].point.toString() + ' Pts';
    return Container(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.listHistory[index].detailInfo.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )
              ),
              const SizedBox(height: 10),
              Text(
                dayTime,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(width: 160),
          Text(
            pointHere,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            )
          )
        ]
      )
    );
  }
}