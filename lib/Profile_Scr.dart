import 'package:flutter/material.dart';
import 'package:cafe_app/models/User.dart';
import 'package:cafe_app/widget/User_widget.dart';
import 'package:cafe_app/themes/themes.dart';

class ProfileScr extends StatefulWidget {
  ProfileScr({required this.myUser, required this.toHomeScr, super.key});

  void Function() toHomeScr;
  User myUser;
  @override
  State<ProfileScr> createState() => _ProfileScrState();
}

class _ProfileScrState extends State<ProfileScr> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  bool finish = false;
  bool isDarkMode = false;

  @override
  Widget build(context){
    IconData iconFinish = (finish) ? Icons.check : Icons.clear;
    _name.text = widget.myUser.fullName;
    _phoneNumber.text = widget.myUser.phoneNumber;
    _email.text = widget.myUser.email;
    _address.text = widget.myUser.address;
    Color colorFinish = (finish) ? Colors.green : Colors.grey;
    return Builder(
      builder: (context) {
        return MaterialApp(
          theme: isDarkMode ? darkThemeData : lightThemeData,
          home: Scaffold(
            body: ListView(
              padding: const EdgeInsets.all(32),
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
                    UserWidget(imagePath: widget.myUser.imagePath, onClicked: (){}),
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
                      "Full Name: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: (isDarkMode) ? Colors.white : Colors.black,
                      )
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _name,
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
                            _name.clear();
                          },
                          icon: Icon(iconFinish, color: colorFinish),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Phone Number: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: (isDarkMode) ? Colors.white : Colors.black,
                      )
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _phoneNumber,
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
                            _phoneNumber.clear();
                          },
                          icon: Icon(iconFinish, color: colorFinish),
                        ),
                      ),
                    ),
                  ],
                ),
        
                const SizedBox(height: 24),
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: (isDarkMode) ? Colors.white : Colors.black,
                      )
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _email,
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
                            _email.clear();
                          },
                          icon: Icon(iconFinish, color: colorFinish),
                        ),
                      ),
                    ),
                  ],
                ),
        
                 const SizedBox(height: 24),
        
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Address: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: (isDarkMode) ? Colors.white : Colors.black,
                      )
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _address,
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
                            _address.clear();
                          },
                          icon: Icon(iconFinish, color: colorFinish),
                        ),
                      ),
                    ),
                  ],
                ),
        
                const SizedBox(height: 50),
        
                TextButton(
                  onPressed: (){
                    setState(() {
                      finish = true;
                      widget.myUser.fullName = _name.text;
                      widget.myUser.phoneNumber = _phoneNumber.text;
                      widget.myUser.address = _address.text;
                      widget.myUser.email = _email.text;
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
              ],
            ),
          ),
        );
      }
    );
  }
}