import 'package:flutter/material.dart';

class DesignText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final TextOverflow? textOverflow;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  const DesignText(
    this.text, {
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.textOverflow,
    this.decoration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize ?? 16,
        color: color,
        overflow: textOverflow,
        fontWeight: fontWeight,
        decoration: decoration,
      ),
    );
  }
}
