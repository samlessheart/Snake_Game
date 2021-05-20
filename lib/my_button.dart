import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final child;
  final function;
  const MyButton({this.child, this.function});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        color: Colors.grey,
        child: child,
      ),
    );
  }
}


