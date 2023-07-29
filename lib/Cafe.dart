import 'package:cafe_app/Detail_Scr.dart';
import 'package:cafe_app/Profile_Scr.dart';
import 'package:cafe_app/Reward_Scr.dart';
import 'package:flutter/material.dart';
import 'package:cafe_app/Start_Scr.dart';
import 'package:cafe_app/Home_Scr.dart';
import 'package:cafe_app/models/Detail_Info.dart';
import 'package:cafe_app/Cart_Scr.dart';
import 'package:cafe_app/Success_Scr.dart';
import 'package:cafe_app/MyOrder_Scr.dart';
import 'package:cafe_app/Radeem_Scr.dart';
import 'package:cafe_app/models/User.dart';
import 'package:cafe_app/models/Orders.dart';
import 'package:cafe_app/models/Cafe_Type.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
class Cafe extends StatefulWidget {
  const Cafe({super.key});
  @override
  State<Cafe> createState() {
    return _CafeState();

  }
}

class _CafeState extends State<Cafe>{

  String activeScreen = 'Start_Scr';
  int numberLoyaltyCard = 1;
  int activeCafeType = 0;

  // Manage detail, cart  
  DetailInfo detailInfo = DetailInfo(name: 'Americano',nums: 1, type: 1, shot: 0, select: 0, ice: 1, size: 0, price: 1);
  List<DetailInfo> listDetailInfo = [];
  int totalPrice = 0;

  // Manage profile
  User myUser = User(fullName : 'Dinh Tung', phoneNumber : '0935976367', email : 'ndtung21@gmail.com', address : 'Binh Chanh district, HCM city', imagePath : 'assets/image/face.png', isDarkMode: false);

  // Manage myOrder
  List<Order> listOrder = [];
  List<Order> listHistory = [];

  // Manage navigation bar
  bool barAppear = false;

  // Manage point
  int totalPoint = 100;

  // Manage radeem
  List<CafeType> listCafeType = [
    const CafeType(name: 'Americano', type: 1),
    const CafeType(name: 'Flat White', type: 2),
    const CafeType(name: 'Capuchino', type: 3),
    const CafeType(name: 'Mocha', type: 4),
  ];

  void startToHome(){
    setState(() {
      barAppear = true;
      if (activeScreen == 'Start_Scr') {
        activeScreen = 'Home_Scr';
      }
    });
  }
  void profileToHome() {
    setState(() {
      barAppear = true;
      if (activeScreen == 'Profile_Scr') {
        activeScreen = 'Home_Scr';
      }
    });
  }
  void homeToDetail(int type) {
    activeCafeType = type;
    detailInfo.type = type;
    setState(() {
      barAppear = false;
      if (activeScreen == 'Home_Scr') {
        activeScreen = 'Detail_Scr';
      }
    });
  }

  void homeToProfile(){
    setState(() {
      barAppear = false;
      if (activeScreen == 'Home_Scr') {
        activeScreen = 'Profile_Scr';
      }
    });
  }

  void homeToCart(){
    setState(() {
      barAppear = false;
      if (activeScreen == 'Home_Scr') {
        activeScreen = 'Cart_Scr';
      }
    });
  }

  void homeToMyOrder(){
    setState(() {
      if (activeScreen == 'Home_Scr') {
        activeScreen = 'MyOrder_Scr';
      }
    });
  }

  void homeToReward() {
    setState(() {
      if (activeScreen == 'Home_Scr') {
        activeScreen = 'Reward_Scr';
      }
    });
  }

  void detailToHome(){
    setState(() {
      barAppear = true;
      if (activeScreen == 'Detail_Scr') {
        activeScreen = 'Home_Scr';
      }
    });
  }


  void detailToCart(){
    int index = detailInfo.similarToItemInList(listDetailInfo);
    if (index == -1) {
      DetailInfo newDetailInfo = detailInfo.copyWith();
      listDetailInfo.add(newDetailInfo);
    }
    else {
      listDetailInfo[index].nums += detailInfo.nums;
      listDetailInfo[index].price = (listDetailInfo[index].shot + 1) * (2 * listDetailInfo[index].size + 1) * listDetailInfo[index].nums;
    }
    setState(() {
      barAppear = false;
      if (activeScreen == 'Detail_Scr') {
        activeScreen = 'Cart_Scr';
      }
    });
  }

  void cartToDetail(){
    setState(() {
      barAppear = false;
      if (activeScreen == 'Cart_Scr') {
        activeScreen = 'Detail_Scr';
      }
    });
  }

  void cartToSuccess(){
    setState(() {
      barAppear = false;
      if (activeScreen == 'Cart_Scr') {
        activeScreen = 'Success_Scr';
      }
    });
  }

  void successToMyOrder(){
    DateTime now = DateTime.now();
    int day = now.day;
    String month = DateFormat('MMMM').format(now);
    int hour = now.hour;
    int minute = now.minute;
    for (int i = 0; i < listDetailInfo.length; i++){
      bool check = false;
      for (int j = 0; j < listOrder.length; j++){
        if (listDetailInfo[i].similarName(listOrder[j].detailInfo)){
          listOrder[j].detailInfo.price += listDetailInfo[i].price;
          listOrder[j].point = listOrder[j].detailInfo.price;
          check = true;
          break;
        }
      }
      if (check == false) {
        DetailInfo newDetailInfo = listDetailInfo[i].copyWith();
        listOrder.add(Order(detailInfo: newDetailInfo, month: month ,  day: day, hour: hour, minute: minute, point: newDetailInfo.price));
      }
    }
    setState(() {
      barAppear = true;
      if (activeScreen == 'Success_Scr') {
        activeScreen = 'MyOrder_Scr';
      }
    });
  }
  
  void myOrderToHome(){
    setState(() {
      barAppear = true;
      if (activeScreen == 'MyOrder_Scr') {
        activeScreen = 'Home_Scr';
      }
    });
  }

  void myOrderToReward(){
    setState(() {
      barAppear = true;
      if (activeScreen == 'MyOrder_Scr') {
        activeScreen = 'Reward_Scr';
      }
    });
  }

  void rewardToHome(){
    setState(() {
      barAppear = true;
      if (activeScreen == 'Reward_Scr') {
        activeScreen = 'Home_Scr';
      }
    });
  }
  
  void rewardToMyOrder(){
    setState(() {
      barAppear = true;
      if (activeScreen == 'Reward_Scr') {
        activeScreen = 'MyOrder_Scr';
      }
    });
  }

  void rewardToRadeem(){
    setState(() {
      barAppear = false;
      if (activeScreen == 'Reward_Scr') {
        activeScreen = 'Radeem_Scr';
      }
    });
  }

  void updateLoyaltyCard(int newCount) {
    setState(() {
      numberLoyaltyCard = newCount;
    });
  }

  void updateTotalPoint(int newPoint){
    setState(() {
      totalPoint = newPoint;
    });
  }
  @override
  Widget build(context) {

    Widget screenWidget = StartScr(startToHome);
    if (activeScreen == 'Home_Scr') {
      screenWidget = HomeScr(myUser: myUser, numberLoyaltyCard: numberLoyaltyCard, toDetailScr: homeToDetail, toProfileScr: homeToProfile, toCartScr: homeToCart, toMyOrder: homeToMyOrder, toReward: homeToReward);
    }
    else if (activeScreen == 'Detail_Scr') {
      screenWidget = DetailScr(type: activeCafeType, toHomeScr: detailToHome, toCartScr: detailToCart, detailInfo: detailInfo);
    }
    else if (activeScreen == 'Cart_Scr'){
      screenWidget = CartScr(listDetailInfo: listDetailInfo, toDetail: cartToDetail, toSuccess: cartToSuccess);
    }
    else if (activeScreen == 'Success_Scr'){
      screenWidget = SuccessScr(toMyOrder: successToMyOrder);
    }
    else if (activeScreen == 'MyOrder_Scr'){
      screenWidget = MyOrderScr(listOrder: listOrder, listHistory: listHistory, myUser: myUser, numberLoyaltyCard: numberLoyaltyCard, updateLoyaltyCard: updateLoyaltyCard, totalPoint: totalPoint, updateTotalPoint: updateTotalPoint);
    }
    else if (activeScreen == 'Profile_Scr'){
      screenWidget = ProfileScr(toHomeScr: profileToHome, myUser: myUser);
    }
    else if (activeScreen == 'Reward_Scr'){
      screenWidget = RewardScr(numberLoyaltyCard: numberLoyaltyCard, totalPoint: totalPoint, toRadeemScr: rewardToRadeem, listHistory: listHistory, updateLoyaltyCard: updateLoyaltyCard, updateTotalPoint: updateTotalPoint);
    }
    else if (activeScreen == 'Radeem_Scr'){
      screenWidget = RadeemScr(listCafeType: listCafeType);
    }
    return MaterialApp(
      //theme: ThemeData.dark(),
      home: Scaffold(
        bottomNavigationBar: (barAppear == false) ? null : navigation(),
        body: Container (
          child: screenWidget,
        ),
      ),
    );
  }

  Widget navigation(){
    int _selectedIndex = 0;
    if (activeScreen == 'Home_Scr'){
      _selectedIndex = 0;
    }
    else if (activeScreen == 'Reward_Scr'){
      _selectedIndex = 1;
    }
    else {
      _selectedIndex = 2;
    }

    return Container(
            color: Colors.pink.shade200,
            child: GNav(
              backgroundColor: Colors.orange.shade200,
              tabBackgroundColor: Colors.green.shade300,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 3),
              selectedIndex: _selectedIndex,
              onTabChange: (index){
                if (index == 0) {
                  setState(() {
                    activeScreen = 'Home_Scr';
                  });
                }
                if (index == 1) {
                  setState(() {
                    activeScreen = 'Reward_Scr';
                  });
                }
                if (index == 2) {
                  setState(() {
                    activeScreen = 'MyOrder_Scr';
                  });
                }
              },
              tabs: const [
                GButton(
                  icon: Icons.home_outlined,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.card_giftcard_rounded,
                  text: 'Reward',
                ),
                GButton(
                  icon: Icons.receipt_long_sharp,
                  text: 'Order',
                )
              ]
            ),
          );
  }
}