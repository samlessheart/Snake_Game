import 'package:flutter/material.dart';

class MyBody extends StatefulWidget {
  double bodyX;
  double bodyY;
  MyBody(double bodyX, double bodyY) {
    this.bodyX = bodyX;
    this.bodyY = bodyY;
  }

  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: Alignment(widget.bodyX, widget.bodyY),
      duration: Duration(milliseconds: 1),
      child: Container(
        color: Colors.black,
        height: 10,
        width: 10,
      ),
    );
  }
}
