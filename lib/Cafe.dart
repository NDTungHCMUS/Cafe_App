import 'package:cafe_app/Detail_Scr.dart';
import 'package:cafe_app/Profile_Scr.dart';
import 'package:cafe_app/Reward_Scr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cafe_app/Start_Scr.dart';
import 'package:cafe_app/Home_Scr.dart';
import 'package:cafe_app/models/Detail_Info.dart';
import 'package:cafe_app/Cart_Scr.dart';
import 'package:cafe_app/Success_Scr.dart';
import 'package:cafe_app/MyOrder_Scr.dart';
import 'package:cafe_app/Radeem_Scr.dart';
import 'package:cafe_app/models/Comments.dart';
import 'package:cafe_app/Comment_Scr.dart';
import 'package:cafe_app/models/User.dart';
import 'package:cafe_app/models/Orders.dart';
import 'package:cafe_app/models/Cafe_Type.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';
class Cafe extends StatefulWidget {
  const Cafe({super.key});
  @override
  State<Cafe> createState() {
    return _CafeState();

  }
}

class _CafeState extends State<Cafe>{

  String activeScreen = 'Start_Scr';
  int numberLoyaltyCard = 0;
  int activeCafeType = 0;

  // Manage detail, cart  
  DetailInfo detailInfo = DetailInfo(name: 'Americano',nums: 1, type: 1, shot: 0, select: 0, ice: 1, size: 0, price: 1);
  List<DetailInfo> listDetailInfo = [];
  int totalPrice = 0;
  int cartBack = 0; //0: toHomeScr, 1: toDetailScr

  // Manage profile
  User myUser = User.empty();

  // Manage myOrder
  List<Order> listOrder = [];
  List<Order> listHistory = [];

  // Manage navigation bar
  bool barAppear = false;

  // Manage point
  int totalPoint = 0;

  // Manage radeem
  List<CafeType> listCafeType = [
    const CafeType(name: 'Americano', type: 1),
    const CafeType(name: 'Flat White', type: 2),
    const CafeType(name: 'Capuchino', type: 3),
    const CafeType(name: 'Mocha', type: 4),
  ];

  // Manage comment
  List<Comment> listComment = [];

  void initState() {
    super.initState();
    readJson();
  }

  Future <void> readJson() async {
    final String response = await rootBundle.loadString('assets/dataSaving.json');
    final data = await json.decode(response);
    setState(() {
      // Read user information
      myUser = User.fromJson(data["User"]);

      // Read number loyalty cards
      numberLoyaltyCard = data["Loyalty Card"];

      // Read total Point
      totalPoint = data["Total Point"];

      // Read list items in cart (listDetailInfo)
      List<dynamic> listItemsJson = data["List Items"];
      listDetailInfo = listItemsJson.map((item) => DetailInfo.fromJson(item)).toList();

      // Read list history items
      List<dynamic> listHistoryJson = data["History"];
      listHistory = listHistoryJson.map((item) => Order.fromJson(item)).toList();

      // Read list comment
      List<dynamic> listCommentJson = data['Comments'];
      listComment = listCommentJson.map((item) => Comment.fromJson(item)).toList();
    });
  }


  Future<void> saveData() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('assets/dataSaving.json');

      final data = {
        "Loyalty Card": numberLoyaltyCard,
        "Total Point": totalPoint,
        "User": myUser.toJson(),
        "List Items": listDetailInfo.map((item) => item.toJson()).toList(),
        "History": listHistory.map((item) => item.toJson()).toList(),
      };

      final jsonData = json.encode(data);
      await file.writeAsString(jsonData);
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  void saveToJson(void Function() onSaveComplete) async{
    print(myUser.fullName);
    await saveData();
    onSaveComplete();
  }
  // Function to swap between screens
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
      cartBack = 0;
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

  void detailToCart(int added){
    if (added == 1){
      int index = detailInfo.similarToItemInList(listDetailInfo);
      if (index == -1) {
        DetailInfo newDetailInfo = detailInfo.copyWith();
        listDetailInfo.add(newDetailInfo);
      }
      else {
        listDetailInfo[index].nums += detailInfo.nums;
        listDetailInfo[index].price = (listDetailInfo[index].shot + 1) * (2 * listDetailInfo[index].size + 1) * listDetailInfo[index].nums;
      }
    } 
    setState(() {
      cartBack = 1;
      barAppear = false;
      if (activeScreen == 'Detail_Scr') {
        activeScreen = 'Cart_Scr';
      }
    });
  }

  void cartToHome(){
    setState(() {
      barAppear = true;
      if (activeScreen == 'Cart_Scr') {
        activeScreen = 'Home_Scr';
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

    // Update listOrder
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

    // Delete listDetailInfo
    listDetailInfo.clear();

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

  void redeemToReward(){
    setState(() {
      barAppear = true;
      if (activeScreen == 'Radeem_Scr'){
        activeScreen = 'Reward_Scr';
      }
    });
  }

  void redeemToMyOrder(){
    setState(() {
      barAppear = true;
      if (activeScreen == 'Radeem_Scr'){
        activeScreen = 'MyOrder_Scr';
      }
    });
  }

  void homeToComment(){
    setState(() {
      barAppear = false;
      activeScreen = 'Comment_Scr';
    });
  }
  
  void commentToHome(){
    setState(() {
      barAppear = true;
      activeScreen = 'Home_Scr';
    });
  }
  @override
  Widget build(context) {

    Widget screenWidget = StartScr(startToHome);
    if (activeScreen == 'Home_Scr') {
      screenWidget = HomeScr(toCommentScr: homeToComment, saveToJson: saveToJson, myUser: myUser, numberLoyaltyCard: numberLoyaltyCard, toDetailScr: homeToDetail, toProfileScr: homeToProfile, toCartScr: homeToCart, toMyOrder: homeToMyOrder, toReward: homeToReward);
    }
    else if (activeScreen == 'Detail_Scr') {
      screenWidget = DetailScr(type: activeCafeType, toHomeScr: detailToHome, toCartScr: detailToCart, detailInfo: detailInfo);
    }
    else if (activeScreen == 'Cart_Scr'){
      screenWidget = CartScr(cartBack: cartBack, toDetail: cartToDetail, listDetailInfo: listDetailInfo, toHome: cartToHome, toSuccess: cartToSuccess);
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
      screenWidget = RadeemScr(listCafeType: listCafeType, toRewardScr: redeemToReward, totalPoint: totalPoint, listOrder: listOrder, toMyOrderScr: redeemToMyOrder, updateTotalPoint: updateTotalPoint);
    }
    else if (activeScreen == 'Comment_Scr'){
      screenWidget = CommentScr(listComment: listComment, myUser: myUser, toHomeScr: commentToHome);
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