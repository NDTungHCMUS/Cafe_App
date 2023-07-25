import 'package:flutter/material.dart';
import 'package:cafe_app/models/Detail_Info.dart';


class DetailScr extends StatefulWidget {
  DetailScr({required this.toHomeScr, required this.toCartScr, required this.type, required this.detailInfo, super.key});

  final void Function() toHomeScr;
  final void Function() toCartScr;
  final int type;
  DetailInfo detailInfo;

  @override
  State<DetailScr> createState() {
    return _DetailScrState();
  }
}

class _DetailScrState extends State<DetailScr> {

  void increaseNums() {
    setState(() {
      widget.detailInfo.nums++;
      widget.detailInfo.price = (widget.detailInfo.shot + 1) * (2 * widget.detailInfo.size + 1) * widget.detailInfo.nums;
    });
  }

  void decreaseNums() {
    setState(() {
      if (widget.detailInfo.nums >= 1){
        widget.detailInfo.nums--;
        widget.detailInfo.price = (widget.detailInfo.shot + 1) * (2 * widget.detailInfo.size + 1) * widget.detailInfo.nums;
      }
    });
  }

  void singleClick() {
    setState(() {
      widget.detailInfo.shot = 0;
      widget.detailInfo.price = (widget.detailInfo.shot + 1) * (2 * widget.detailInfo.size + 1) * widget.detailInfo.nums;
    });
  }

  void doubleClick() {
    setState(() {
      widget.detailInfo.shot = 1;
      widget.detailInfo.price = (widget.detailInfo.shot + 1) * (2 * widget.detailInfo.size + 1) * widget.detailInfo.nums;
    });
  }

  void cupClick(){
    setState(() {
      widget.detailInfo.select = 0;
    });
  }

  void glassClick(){
    setState(() {
      widget.detailInfo.select = 1;
    });
  }

  void smallSizeClick(){
    setState(() {
      widget.detailInfo.size = 0;
      widget.detailInfo.price = (widget.detailInfo.shot + 1) * (2 * widget.detailInfo.size + 1) * widget.detailInfo.nums;
    });
  }

  void mediumSizeClick(){
    setState(() {
      widget.detailInfo.size = 1;
      widget.detailInfo.price = (widget.detailInfo.shot + 1) * (2 * widget.detailInfo.size + 1) * widget.detailInfo.nums;
    });
  }

  void bigSizeClick(){
    setState(() {
      widget.detailInfo.size = 2;
      widget.detailInfo.price = (widget.detailInfo.shot + 1) * (2 * widget.detailInfo.size + 1) * widget.detailInfo.nums;
    });
  }
  @override
  Widget build(context) {
    widget.detailInfo.type = widget.type;
    int tmp = widget.type + 1;
    final String url =  'assets/image/coffee-type-' + '$tmp' + '.png';

    if (widget.detailInfo.type == 0) {
      widget.detailInfo.name = 'Americano';
    }
    else if (widget.detailInfo.type == 1) {
      widget.detailInfo.name = 'Flat White';
    }
    else if (widget.detailInfo.type == 2) {
      widget.detailInfo.name = 'Capuchino';
    }
    else if (widget.detailInfo.type == 3) {
      widget.detailInfo.name = 'Mocha';
    }

    // Deal with Shot
    Color singleColor; Color doubleColor;
    if (widget.detailInfo.shot == 0) {
      singleColor = Colors.black;
      doubleColor = Colors.grey.shade300;
    }
    else{
      doubleColor = Colors.black;
      singleColor = Colors.grey.shade300;
    }

    // Deal with Selection
    Color cupColor; Color glassColor;
    if (widget.detailInfo.select == 0) {
      cupColor = Colors.black;
      glassColor = Colors.grey.shade300;
    }
    else{
      glassColor = Colors.black;
      cupColor = Colors.grey.shade300;
    }

    // Deal with Size
    Color smallSizeColor; Color mediumSizeColor; Color bigSizeColor;
    if (widget.detailInfo.size == 0) {
      smallSizeColor = Colors.black;
      mediumSizeColor = Colors.grey.shade300;
      bigSizeColor = Colors.grey.shade300;
    }
    else if (widget.detailInfo.size == 1){
      smallSizeColor = Colors.grey.shade300;
      mediumSizeColor = Colors.black;
      bigSizeColor = Colors.grey.shade300;
    }
    else {
      smallSizeColor = Colors.grey.shade300;
      mediumSizeColor = Colors.grey.shade300;
      bigSizeColor = Colors.black;
    }

    // Deal with Price
    String priceStr = widget.detailInfo.price.toString() + ' USD';
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // First line
              Row(
                children: [
                  OutlinedButton(
                    onPressed: widget.toHomeScr,
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

                  const SizedBox(width: 90),

                  const Text(
                    'Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 90),

                  OutlinedButton(
                    onPressed: (){},
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
                ]
              ),

              const SizedBox(height: 20),

              // Second line: Image
              Container(
                height: 175,
                decoration: BoxDecoration(
                  color: const Color(0xfff7f8fb),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black, width: 2.0),
                ),
                child: Center(
                  child: Image.asset(url, scale: 0.8),
                ),
              ),

              const SizedBox(height: 20),

              // Third line: Name of cafe
              Row(
                children: [
                  Text(
                    widget.detailInfo.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    )
                  ),

                  const SizedBox(width: 90),

                  OutlinedButton(
                    onPressed: (){
                      decreaseNums();
                    },
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
                      Icons.remove,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(width: 20),
                  
                  Text(
                    widget.detailInfo.nums.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    )
                  ),

                  const SizedBox(width: 20),

                  OutlinedButton(
                    onPressed: (){
                      increaseNums();
                    },
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
                      Icons.add,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),

                ]
              ),

              const SizedBox(height: 10),

              const Divider(
                height: 1, // Chiều cao của đường gạch ngang
                color: Colors.black, // Màu của đường gạch ngang
              ),

              const SizedBox(height: 10),

              // Fourth line: Shot
              Row(
                children: [
                  const Text(
                    'Shot',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    )
                  ),

                  const SizedBox(width: 140),

                  TextButton(
                    onPressed: (){
                      singleClick();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: singleColor,
                      shape: RoundedRectangleBorder( // Xác định hình dạng của viền
                        borderRadius: BorderRadius.circular(10), // Độ cong của viền
                      ),
                      side: const BorderSide(
                        color: Colors.black, // Màu của viền
                        width: 1.0, // Độ dày   của viền
                      ),
                    ),
                    child: Text(
                      'Single',
                      style: TextStyle(
                        color: singleColor,
                      ) 
                    ),
                  ),

                  const SizedBox(width: 30),

                  TextButton(
                    onPressed: (){
                      doubleClick();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: doubleColor,
                      shape: RoundedRectangleBorder( // Xác định hình dạng của viền
                        borderRadius: BorderRadius.circular(10), // Độ cong của viền
                      ),
                      side: const BorderSide(
                        color: Colors.black, // Màu của viền
                        width: 1.0, // Độ dày   của viền
                      ),
                    ),
                    child: Text(
                      'Double',
                      style: TextStyle(
                        color: doubleColor,
                      ) 
                    ),
                  ),

                ]
              ),

              const SizedBox(height: 10),

              const Divider(
                height: 1, // Chiều cao của đường gạch ngang
                color: Colors.black, // Màu của đường gạch ngang
              ),

              const SizedBox(height: 10),

              // Fifth line: Selection
              Row(
                children: [
                  const Text(
                    'Select',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    )
                  ),

                  const SizedBox(width: 140),

                  IconButton(
                    onPressed: (){
                      cupClick();
                    },
                    icon:Image.asset(
                      'assets/image/Cup.png',
                      color: cupColor,
                    ),
                  ),

                  const SizedBox(width: 30),

                  IconButton(
                    onPressed: (){
                      glassClick();
                    },
                    icon:Image.asset(
                      'assets/image/Glass.png',
                      color: glassColor,
                    ),
                  ),
                ]
              ),

              const SizedBox(height: 10),

              const Divider(
                height: 1, // Chiều cao của đường gạch ngang
                color: Colors.black, // Màu của đường gạch ngang
              ),

              const SizedBox(height: 10),

              // Sixth line: Size
              Row(
                children: [
                  const Text(
                    'Size',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    )
                  ),

                  const SizedBox(width: 100),

                  IconButton(
                    onPressed: (){
                      smallSizeClick();
                    },
                    icon:Image.asset(
                      'assets/image/size-1.png',
                      color: smallSizeColor,
                    ),
                  ),

                  const SizedBox(width: 30),

                  IconButton(
                    onPressed: (){
                      mediumSizeClick();
                    },
                    icon:Image.asset(
                      'assets/image/size-2.png',
                      color: mediumSizeColor,
                    ),
                  ),

                  const SizedBox(width: 30),

                  IconButton(
                    onPressed: (){
                      bigSizeClick();
                    },
                    icon:Image.asset(
                      'assets/image/size-3.png',
                      color: bigSizeColor,
                    ),
                  ),
                ]
              ),

              const SizedBox(height: 70),
              
              // Price
              Row(
                children:[
                  const Text(
                    'Total Amount:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  const SizedBox(width: 120),
                  Text(
                    widget.detailInfo.price.toString() + ' USD',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )
                  )
                ],
              ),

              const SizedBox(height: 20),

              // Add to Cart
              TextButton(
                onPressed: widget.toCartScr,
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 9, 51, 49),
                  shape: RoundedRectangleBorder( // Xác định hình dạng của viền
                    borderRadius: BorderRadius.circular(10), // Độ cong của viền
                  ),
                  side: const BorderSide(
                    color: Colors.black, // Màu của viền
                    width: 1.0, // Độ dày   của viền
                  ),
                ),
                child: const Text(
                  'Add To Cart',
                  style: TextStyle(
                    color: Colors.white,
                  ) 
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}