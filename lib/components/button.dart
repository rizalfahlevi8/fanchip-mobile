import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final double width;
  final String title;
  final bool disable;
  final Function() onPressed;

  const Button(
      {super.key,
      required this.width,
      required this.title,
      required this.disable,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        onPressed: disable ? null : onPressed,
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
