import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

/// Main Class
/// [percentage] from 0 to 100 percentage circle
/// [showPercentage] show percentage text
/// [color] percentage line color
/// [backColor] back circle color
class CircularProgress extends StatefulWidget {
  final double percentage;
  final Color color;
  final Color backColor;
  final bool showPercentage;

  CircularProgress({
    @required this.percentage,
    this.color = Colors.orange,
    this.backColor = Colors.black,
    this.showPercentage = true,
  });

  @override
  _CircularProgressState createState() => _CircularProgressState();
}

class _CircularProgressState extends State<CircularProgress>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  double oldPercentage;

  @override
  void initState() {
    oldPercentage = widget.percentage;
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0);

    final diferencia = widget.percentage - oldPercentage;
    oldPercentage = widget.percentage;

    return Container(
      margin: EdgeInsets.all(10),
      child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget child) {
            return Stack(
              fit: StackFit.expand,
              overflow: Overflow.clip,
              children: [
                (widget.showPercentage)
                    ? Center(
                        child: Text(
                            '${((widget.percentage - diferencia) + (diferencia * controller.value)).toInt()} %'))
                    : Container(),
                CustomPaint(
                  painter: _Circle(
                      percentage: (widget.percentage - diferencia) +
                          (diferencia * controller.value),
                      color: widget.color,
                      back: widget.backColor),
                ),
              ],
            );
          }),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _Circle extends CustomPainter {
  final percentage;
  final color;
  final back;

  _Circle(
      {@required this.percentage, @required this.color, @required this.back});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..color = back;

    final center = Offset(size.width * 0.5, size.height * 0.5);
    final radius = min(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(center, radius, paint);

    final Rect rect = Rect.fromCircle(
      center: Offset(0, 0),
      radius: 180,
    );
    final gradient = LinearGradient(colors: [Colors.purpleAccent, color]);

    final paintSecondary = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10
      ..shader = gradient.createShader(rect);

    double arcAngle = 2 * pi * (percentage / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, paintSecondary);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
