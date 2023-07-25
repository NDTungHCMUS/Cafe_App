import 'package:cafe_app/Detail_Scr.dart';
import 'package:flutter/material.dart';
import 'package:cafe_app/Start_Scr.dart';
import 'package:cafe_app/Home_Scr.dart';
import 'package:cafe_app/models/Detail_Info.dart';
import 'package:cafe_app/Cart_Scr.dart';
import 'package:cafe_app/Success_Scr.dart';
import 'package:cafe_app/MyOrder_Scr.dart';

class Cafe extends StatefulWidget {
  const Cafe({super.key});
  @override
  State<Cafe> createState() {
    return _CafeState();
  }
}

class _CafeState extends State<Cafe> {

  var activeScreen = 'Start_Scr';
  int numberLoyaltyCard = 1;
  int activeCafeType = 0;

  // Manage detail, cart  
  DetailInfo detailInfo = DetailInfo(name: 'Americano',nums: 1, type: 1, shot: 0, select: 0, ice: 1, size: 0, price: 1);
  List<DetailInfo> listDetailInfo = [];
  int totalPrice = 0;

  void switchScreen(){
    setState(() {
      if (activeScreen == 'Start_Scr') {
        activeScreen = 'Home_Scr';
      }
    });
  }

  void chooseCafe(int type) {
    activeCafeType = type;
    detailInfo.type = type;
    setState(() {
      if (activeScreen == 'Home_Scr') {
        activeScreen = 'Detail_Scr';
      }
    });
  }

  void detailToHome(){
    setState(() {
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
      if (activeScreen == 'Detail_Scr') {
        activeScreen = 'Cart_Scr';
      }
    });
  }

  void cartToDetail(){
    setState(() {
      if (activeScreen == 'Cart_Scr') {
        activeScreen = 'Detail_Scr';
      }
    });
  }

  void cartToSuccess(){
    setState(() {
      if (activeScreen == 'Cart_Scr') {
        activeScreen = 'Success_Scr';
      }
    });
  }

  void successToMyOrder(){
    setState(() {
      if (activeScreen == 'Success_Scr') {
        activeScreen = 'MyOrder_Scr';
      }
    });
  }
  @override
  Widget build(context) {

    Widget screenWidget = StartScr(switchScreen);
    if (activeScreen == 'Home_Scr') {
      screenWidget = HomeScr(numberLoyaltyCard: numberLoyaltyCard, toDetailScr: chooseCafe);
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
      screenWidget = const MyOrderScr();
    }
    return MaterialApp(
      //theme: ThemeData.dark(),
      home: Scaffold(
        body: Container (
          child: screenWidget,
        ),
      ),
    );
  }
}