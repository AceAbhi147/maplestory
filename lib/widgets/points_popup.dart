import 'package:flutter/material.dart';

class PointsPopup extends StatefulWidget {
  final int points;
  final VoidCallback onFinished;

  const PointsPopup({
    super.key,
    required this.points,
    required this.onFinished,
  });

  @override
  State<PointsPopup> createState() => _PointsPopupState();
}

class _PointsPopupState extends State<PointsPopup>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _opacity;
  late final Animation<double> _offsetY;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _opacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _offsetY = Tween<double>(begin: 0, end: -50).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward().whenComplete(widget.onFinished);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.translate(
            offset: Offset(0, _offsetY.value),
            child: child,
          ),
        );
      },
      child: Text(
        "${widget.points > 0 ? '+' : ''}${widget.points}",
        style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
          fontFamily: "Regular",
          color: widget.points > 0 ? Colors.green.shade900 : Colors.red.shade900,
        ),
      ),
    );
  }
}
