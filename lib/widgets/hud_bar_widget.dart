import 'package:flutter/material.dart';
import 'package:maplestory/widgets/bar_widget.dart';

class HudBarWidget extends StatelessWidget {
  final double x;
  final double y;
  final double width;
  final double height;
  final Color fillColor;
  final Color backgroundColor;
  final double progressValue;
  final String title;

  const HudBarWidget({
    super.key,
    required this.width,
    required this.height,
    required this.fillColor,
    required this.backgroundColor,
    required this.progressValue,
    required this.x,
    required this.y, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(x, y),
      child: SizedBox(
        width: 300,
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 30, fontFamily: "Regular")),
            Row(
              children: [
                BarWidget(
                  width: width,
                  height: height,
                  fillColor: fillColor,
                  backgroundColor: backgroundColor,
                  progressValue: progressValue,
                ),
                SizedBox(width: 5,),
                Text(
                  "${(progressValue * 100).toInt()}",
                  style: TextStyle(fontSize: 25, fontFamily: "Regular"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
