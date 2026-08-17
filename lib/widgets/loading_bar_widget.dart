import 'package:flutter/material.dart';
import 'package:maplestory/widgets/bar_widget.dart';

class LoadingBarWidget extends StatelessWidget {
  final double _loadingProgress;

  const LoadingBarWidget({super.key, required double loadingProgress})
      : _loadingProgress = loadingProgress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BarWidget(
          width: 300,
          height: 20,
          fillColor: Colors.blue,
          backgroundColor: Colors.white,
          progressValue: _loadingProgress,
        ),
        Text(
          "Loading: ${(_loadingProgress * 100).toInt()}%",
          style: TextStyle(fontFamily: "Regular", fontSize: 20),
        ),
      ],
    );
  }

}