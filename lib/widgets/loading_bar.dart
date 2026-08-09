import 'package:flutter/material.dart';

class LoadingBar extends StatelessWidget {
  final double _loadingProgress;

  const LoadingBar({super.key, required double loadingProgress})
      : _loadingProgress = loadingProgress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 300,
          height: 20,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: _loadingProgress,
              color: Colors.blue,
              backgroundColor: Colors.white,
            ),
          ),
        ),
        Text(
          "Loading: ${(_loadingProgress * 100).toInt()}%",
          style: TextStyle(fontFamily: "Regular", fontSize: 20),
        ),
      ],
    );
  }

}