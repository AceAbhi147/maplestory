import 'package:flutter/material.dart';

class PointsPopupData {
  final int points;
  final double x;
  final double y;
  final String id;

  PointsPopupData({
    required this.points,
    required this.x,
    required this.y,
  }) : id = UniqueKey().toString();
}