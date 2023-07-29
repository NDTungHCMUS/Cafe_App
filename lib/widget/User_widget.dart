import 'package:flutter/material.dart';

class UserWidget extends StatelessWidget {

  UserWidget({required this.imagePath, required this.onClicked, super.key});
  final String imagePath;
  final VoidCallback onClicked;

  @override
  Widget build(context) {
    return Center(
      child: Stack(
        children:[ 
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(
              Colors.black
            )
          ),
        ],
      ),
    );
  }

  Widget buildImage(){
    final image = AssetImage(imagePath);
    return ClipOval(
              child: Material(
                color: Colors.transparent,
                child: Ink.image(
                  fit: BoxFit.cover,
                  image: image,
                  width: 128, 
                  height: 128,
                  child: InkWell(
                    onTap: onClicked,
                  )
                ),
              ),
            );
  }

  Widget buildEditIcon(Color color){
    return buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
        child: const Icon(
                Icons.edit,
                size: 20,
              ), 
        all: 8, 
        color: Colors.orange,
      ),
    );
  }

  Widget buildCircle({required Widget child, required double all, required Color color}){
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
  }
}