import 'package:flutter/material.dart';
import 'package:cafe_app/models/Orders.dart';
import 'package:cafe_app/models/User.dart';
class OrderWidget extends StatefulWidget {
  
  OrderWidget({super.key, required this.selected, required this.listShow, required this.listAdd, required this.myUser, required this.numberLoyaltyCard, required this.updateLoyaltyCardCount, required this.totalPoint, required this.updateTotalPoint});
  int selected;
  List<Order>listShow;
  List<Order>listAdd;
  User myUser;
  int numberLoyaltyCard;
  int totalPoint;
  Function(int) updateLoyaltyCardCount;
  Function(int) updateTotalPoint;
  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(context){
    return ListView.separated(
      itemCount: widget.listShow.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index){
        if (widget.selected == 1) {
          return buildItem(index);
        }
        return Dismissible(
          direction: DismissDirection.startToEnd,
          key: UniqueKey(),
          background: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(10),
            color: Colors.red,
            child: const Icon(Icons.delete_outline_rounded, color: Colors.white, size: 40),
          ),
          child: buildItem(index),
          onDismissed: (direction){
            setState(() {
              if (widget.selected == 0) {
                widget.listAdd.insert(0, widget.listShow[index].copyWith());
                addLoyaltyCard(widget.listShow[index]);
                addPoint(widget.listShow[index]);
                widget.listShow.removeAt(index);
              }
            });
          },
        );
      }
    );
  }

  void addLoyaltyCard(Order tmp){
    if (tmp.detailInfo.price > 0){
      if (tmp.detailInfo.size == 0 || tmp.detailInfo.size == 1) {
        widget.numberLoyaltyCard += tmp.detailInfo.nums * 1;
      }
      else {
        widget.numberLoyaltyCard += tmp.detailInfo.nums * 2;
      }
      widget.updateLoyaltyCardCount(widget.numberLoyaltyCard);
    }
    print("Widget " + widget.numberLoyaltyCard.toString());
  }

  void addPoint(Order tmp){
    widget.totalPoint += tmp.point;
    widget.updateTotalPoint(widget.totalPoint);
  }

  Widget buildItem(int index){
    String dayTime = "";
    if (widget.listShow[index].hour > 12){
      dayTime = widget.listShow[index].day.toString() + " " + widget.listShow[index].month + " | " + widget.listShow[index].hour.toString() + ":" + widget.listShow[index].minute.toString() + " PM";
    }
    else {
      dayTime = widget.listShow[index].day.toString() + " " + widget.listShow[index].month + " | " + widget.listShow[index].hour.toString() + ":" + widget.listShow[index].minute.toString() + " AM";
    }
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                dayTime,
                style: const TextStyle(
                  color: Colors.grey,
                )
              ),
              const SizedBox(width: 150),
              Text(
                (widget.listShow[index].detailInfo.price > 0) ? widget.listShow[index].detailInfo.price.toString() +  ' USD' : 'Radeem',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.local_cafe_outlined),
              const SizedBox(width: 30),
              Text(
                widget.listShow[index].detailInfo.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.location_on_outlined),
              const SizedBox(width: 30),
              Text(
                widget.myUser.address,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )
              )
            ],
          ),
        ],
      )
    );
  }
}