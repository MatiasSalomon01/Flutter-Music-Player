import 'package:flutter/material.dart';
import 'package:music_player/constants/constants.dart';

class StadiumButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Color buttonColor;
  final Color borderColor;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;

  const StadiumButton({
    super.key,
    required this.text,
    this.textColor = white,
    this.fontSize = 15,
    this.fontWeight = FontWeight.w700,
    this.borderColor = white,
    this.buttonColor = lightGreen,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => onPressed(),
      padding: padding,
      splashColor: transparent,
      highlightColor: Colors.black.withOpacity(.3),
      elevation: 0,
      color: buttonColor,
      highlightElevation: 0,
      shape: StadiumBorder(
        side: BorderSide(color: borderColor, width: .3),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
