import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cafe_app/models/User.dart';
import 'package:cafe_app/widget/User_widget.dart';
import 'package:cafe_app/themes/themes.dart';
import 'package:cafe_app/models/Comments.dart';

class CommentWidget extends StatefulWidget {
  
  CommentWidget({super.key, required this.listComment, required this.isDarkMode});
  List<Comment>listComment;
  bool isDarkMode;
  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(context){
    return ListView.separated(
      itemCount: widget.listComment.length,
      separatorBuilder: (context, index) => Divider(color: widget.isDarkMode ? Colors.white : Colors.black, thickness: 2),
      itemBuilder: (context, index){
          return buildItem(index);
      }
    );
  }


  Widget buildItem(int index){
    String dayTime = "";
    if (widget.listComment[index].hour > 12) {
      dayTime = widget.listComment[index].day.toString() + " " + widget.listComment[index].month + " | " + widget.listComment[index].hour.toString() + ":" + widget.listComment[index].minute.toString() + " PM";
    }
    else {
      dayTime = widget.listComment[index].day.toString() + " " + widget.listComment[index].month + " | " + widget.listComment[index].hour.toString() + ":" + widget.listComment[index].minute.toString() + " AM";
    }
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                dayTime,
                style: TextStyle(
                  color: widget.isDarkMode ? Colors.white : Colors.black,
                )
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.local_cafe_outlined, color: widget.isDarkMode ? Colors.white : Colors.black),
              const SizedBox(width: 30),
              Text(
                widget.listComment[index].name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: widget.isDarkMode ? Colors.white : Colors.black,
                )
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.location_on_outlined, color: widget.isDarkMode ? Colors.white : Colors.black),
              const SizedBox(width: 30),
              Text(
                widget.listComment[index].text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: widget.isDarkMode ? Colors.white : Colors.black
                )
              )
            ],
          ),
        ],
      )
    );
  }
}