import 'package:flutter/material.dart';

class SuccessScr extends StatelessWidget {
  SuccessScr({required this.toMyOrder, super.key});
  void Function() toMyOrder;
  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Image.asset('assets/image/order-success.png'),
          const SizedBox(height: 30),

          const Text(
            'Order Success',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            )
          ),
          const SizedBox(height: 30),
          const Text(
            'Your order has been placed successfully',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.normal,
              fontSize: 16,
            )
          ),
          const SizedBox(height: 10),
          const Text(
            'For more details, go to my orders',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.normal,
              fontSize: 16,
            )
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: 200,
            height: 40,
            child: TextButton(
              onPressed: toMyOrder,
              style: TextButton.styleFrom(
                
                  backgroundColor: const Color(0xff324a59),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
              ),
              child: const Text(
                'Track my order',
                style: TextStyle(
                  color: Colors.white,
                )
              )
            ),
          )
        ],
      ),
    );
  }
}