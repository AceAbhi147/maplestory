import 'package:flutter/material.dart';

class BarWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color fillColor;
  final Color backgroundColor;
  final double progressValue;

  const BarWidget({
    super.key,
    required this.width,
    required this.height,
    required this.fillColor,
    required this.backgroundColor,
    required this.progressValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: LinearProgressIndicator(
          value: progressValue,
          color: fillColor,
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }
}
