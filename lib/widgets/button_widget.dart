import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onClicked;
  final String text;
  final Color backgroundColor;
  final Color color;
  const ButtonWidget({Key? key, required this.onClicked, required this.text, this.backgroundColor = Colors.white, this.color = Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked,
      child: Container(
        padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: backgroundColor
          ),
          child: Text(text, style: TextStyle(color: color, fontSize: 24),)),


    );
  }
}
