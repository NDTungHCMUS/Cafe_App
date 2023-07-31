import 'package:cafe_app/widget/Comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:cafe_app/models/User.dart';
import 'package:cafe_app/widget/User_widget.dart';
import 'package:cafe_app/themes/themes.dart';
import 'package:cafe_app/models/Comments.dart';
import 'package:intl/intl.dart';

class CommentScr extends StatefulWidget {
  CommentScr({required this.listComment, required this.myUser, required this.toHomeScr, super.key});

  void Function() toHomeScr;
  User myUser;
  List<Comment> listComment;
  @override
  State<CommentScr> createState() => _CommentScrState();
}

class _CommentScrState extends State<CommentScr> {
  final TextEditingController _comment = TextEditingController();
  bool finish = false;
  bool isDarkMode = false;

  @override
  Widget build(context){
    DateTime now = DateTime.now();
    int day = now.day;
    String month = DateFormat('MMMM').format(now);
    int hour = now.hour;
    int minute = now.minute;

    return Builder(
      builder: (context) {
        return MaterialApp(
          theme: isDarkMode ? darkThemeData : lightThemeData,
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      OutlinedButton(
                            onPressed: widget.toHomeScr,
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder( // Xác định hình dạng của viền
                                borderRadius: BorderRadius.circular(10), // Độ cong của viền
                              ),
                              side: BorderSide(
                                color: (isDarkMode) ? Colors.white : Colors.black, // Màu của viền
                                width: 1.0, // Độ dày   của viền
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_back_sharp,
                              color: (isDarkMode) ? Colors.white : Colors.black,
                            ),
                          ),
                      const SizedBox(width:50),
                      Text('Comments', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: (isDarkMode) ? Colors.white : Colors.black,)),
                      const SizedBox(width:20),
                      OutlinedButton(
                        child: const Icon(Icons.wb_sunny_rounded, size: 30),
                        onPressed: (){
                          setState(() {
                            isDarkMode = !isDarkMode;
                          });
                        },
                      ),
                    ],
                  ),
            
                  const SizedBox(height: 24),
                    
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your comment: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: (isDarkMode) ? Colors.white : Colors.black,
                        )
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _comment,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                              color: isDarkMode ? Colors.white : Colors.black, // Màu viền dựa vào trạng thái của isDarkMode
                              width: 1.0,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: (){
                              _comment.clear();
                            },
                            icon: Icon(Icons.clear_rounded, color: isDarkMode ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                    
                  Expanded(
                    child: CommentWidget(listComment: widget.listComment, isDarkMode: isDarkMode),
                  ),
            
                  const SizedBox(height: 10),

                  TextButton(
                    onPressed: (){
                      setState(() {
                        widget.listComment.insert(0, Comment(day: day, month: month, hour: hour, minute: minute, name: widget.myUser.fullName, text: _comment.text));
                      });
                    },
                    style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xff324a59),),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0), // Ví dụ: góc bo tròn 8.0
                            ),
                          ),
                        ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )
                    )
                  )
                ]
              ),
            )
          ),
        );
      }
    );
  }
}