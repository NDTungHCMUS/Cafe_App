import 'package:cafe_app/Loyalty_Card.dart';
import 'package:flutter/material.dart';
import 'package:cafe_app/data/Cafe_Type_Store.dart';
import 'package:cafe_app/models/Cafe_Type_Grid.dart';
import 'package:cafe_app/models/User.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
class HomeScr extends StatefulWidget {
  const HomeScr({required this.toMyOrder, required this.toReward, required this.myUser, required this.toProfileScr, required this.numberLoyaltyCard, required this.toCartScr, required this.toDetailScr, super.key});

  final void Function(int type) toDetailScr;
  final void Function() toProfileScr;
  final void Function() toCartScr;
  final void Function() toMyOrder;
  final void Function() toReward;
  final User myUser;
  final int numberLoyaltyCard;


  State<HomeScr> createState() {
    return _HomeScrState(); 
  }
  
}

class _HomeScrState extends State<HomeScr> {

  void chooseCafe(int type) {
    widget.toDetailScr(type);
  }

  @override
  Widget build(context) {
    int nums = widget.numberLoyaltyCard;
    String numberLoyaltyCardStr = '$nums' + '/8';

    // List Loyalty Card
    List<LoyaltyCard> listLoyaltyCard = [];
    for (int i = 0; i < widget.numberLoyaltyCard; i++) {
      listLoyaltyCard.add(LoyaltyCard(used: true));
    }
    for (int i = 0; i < 8 - widget.numberLoyaltyCard; i++){
      listLoyaltyCard.add(LoyaltyCard(used: false));
    }

    // List Cafe Grid Items
    List<CafeTypeGrid> listCafeTypeGrid = [];
    for (final category in availableCafe) {
      listCafeTypeGrid.add(CafeTypeGrid(cafetype: category));
    }

    return Scaffold(
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

                // Header
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Good Morning!',
                            style: TextStyle(
                                color: Colors.grey.withOpacity(0.8),
                                fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              widget.myUser.fullName,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          OutlinedButton(
                            onPressed: widget.toCartScr,
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
                              Icons.shopping_cart_outlined,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 20),
                          OutlinedButton(
                            onPressed: widget.toProfileScr,
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
                              Icons.assignment_ind_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                //Loyalty view
                Container(
                  height: 175,
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
                            height: 110,
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

                const SizedBox(height: 30),

                const Text(
                  'Choose your coffee: ',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )
                ),
                
                const SizedBox(height: 20),

                // List Cafe
                Expanded(
                  child: SizedBox(
                    height: 10,
                    child: GridView(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, 
                        crossAxisSpacing: 30, 
                        mainAxisSpacing: 10
                      ),
                      children: [
                        InkWell(
                          onTap: () {chooseCafe(0);},
                          child: listCafeTypeGrid[0],
                        ),
                        InkWell(
                          onTap: () {chooseCafe(1);},
                          child: listCafeTypeGrid[1],
                        ),
                        InkWell(
                          onTap: () {chooseCafe(2);},
                          child: listCafeTypeGrid[2],
                        ),
                        InkWell(
                          onTap: () {chooseCafe(3);},
                          child: listCafeTypeGrid[3],
                        ),
                      ],
                    ),
                  ),
                ),
            ]
          ),
        ),
      ),
    );
  }
  
}