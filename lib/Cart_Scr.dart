import 'package:flutter/material.dart';
import 'package:cafe_app/models/Detail_Info.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartScr extends StatefulWidget {
  CartScr({required this.toSuccess, required this.toDetail, required this.listDetailInfo, super.key});
  void Function() toDetail;
  void Function() toSuccess;
  List<DetailInfo> listDetailInfo;

  State<CartScr> createState() {
    return _CartScrState();
  }
}


class _CartScrState extends State<CartScr> {

  Widget listSlide(index, List<String> shotName, List<String> selectName, List<String> sizeName) {
    int tmp = widget.listDetailInfo[index].type + 1;
    final String url =  'assets/image/coffee-type-' + '$tmp' + '.png';
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: const Color(0xfff7f8fb),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey, width: 2.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Image.asset(
                url,
                width: 75,
                height: 75,
              )
            ],
          ),

          const SizedBox(width: 30),
    
          Column(
            children:[
              const SizedBox(height: 5),

              Row(
                children: [
                  Text(
                    widget.listDetailInfo[index].name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Text(
                    shotName[index] + ' | ' + selectName[index] + ' | ' + sizeName[index],
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Text(
                    'x ' + widget.listDetailInfo[index].nums.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ],
          ),
    
          const SizedBox(width: 25),
          
          Center(
            child: Text(
              widget.listDetailInfo[index].price.toString() + ' USD',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(context) {

    // Print the cart 
    List<String> shotName = [], selectName = [], sizeName = [];
    for (int i = 0; i < widget.listDetailInfo.length; i++){
      if (widget.listDetailInfo[i].type == 0) {
        widget.listDetailInfo[i].name = 'Americano';
      }
      else if (widget.listDetailInfo[i].type == 1) {
        widget.listDetailInfo[i].name = 'Flat White';
      }
      else if (widget.listDetailInfo[i].type == 2) {
        widget.listDetailInfo[i].name = 'Capuchino';
      }
      else if (widget.listDetailInfo[i].type == 3) {
        widget.listDetailInfo[i].name = 'Mocha';
      }

      if (widget.listDetailInfo[i].shot == 0) {
        shotName.add('Single');
      }
      else {
        shotName.add('Double');
      }


      if (widget.listDetailInfo[i].select == 0) {
        selectName.add('Cup');
      }
      else {
        selectName.add('Glass');
      }

      if (widget.listDetailInfo[i].size == 0) {
        sizeName.add('Small');
      }
      else if (widget.listDetailInfo[i].size == 1){
        sizeName.add('Medium');
      }
      else {
        sizeName.add('Big');
      }
    }

    // Print total Price
    int totalPrice = 0;
    for (int i = 0; i < widget.listDetailInfo.length; i++){
      totalPrice += widget.listDetailInfo[i].price;
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  OutlinedButton(
                    onPressed: widget.toDetail,
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
                      Icons.arrow_back_sharp,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              const Row(
                children:[
                  Text(
                    'My Cart',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    )
                  ),
                ],
              ),

              const SizedBox(height: 30),

              Expanded(
                child: ListView.separated(
                  itemCount: widget.listDetailInfo.length,
                  itemBuilder: (context, index){
                    return Dismissible(
                      direction: DismissDirection.startToEnd,
                      key: UniqueKey(),
                      background: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(10),
                        color: Colors.red,
                        child: Icon(Icons.delete_outline_rounded, color: Colors.white, size: 40),
                      ),
                      child: listSlide(index, shotName, selectName, sizeName),
                      onDismissed: (direction){
                        setState(() {
                          widget.listDetailInfo.removeAt(index);
                        });
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ),

              Row(
                children: [
                  const SizedBox(width: 30),
                  Column(
                    children: [
                      const Text(
                        'Total Price: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )
                      ),
                      const SizedBox(height: 5),
                      Text(
                        totalPrice.toString() + ' USD',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ],
                  ),
                  const SizedBox(width: 110),
                  
                  ElevatedButton(
                    onPressed: widget.toSuccess,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xff324a59),),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0), // Ví dụ: góc bo tròn 8.0
                        ),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.shopping_cart_outlined, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          'Checkout',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          )
                        )
                      ],
                    ),
                  ),
                ],
            
              ),
            ],
          ),
        ),
      ),
    );
  }
}