import 'package:flutter/material.dart';

class Food extends StatefulWidget {
  double foodX;
  double foodY;
  Food(
    this.foodX,
    this.foodY,
  );

  @override
  _FoodState createState() => _FoodState();
}

class _FoodState extends State<Food> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1),
      alignment: Alignment(widget.foodX, widget.foodY),
      child: Container(
        height: 8,
        width: 8,

        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }
}
