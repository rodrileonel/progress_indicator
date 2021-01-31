import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

/// CircularProgress Class
/// [percentage] from 0 to 100 percentage circle
/// [color] percentage line color
/// [backColor] back circle color
/// [showPercentage] show percentage text
/// [gradient] show gradient instead of color
/// [textStyle] text percentage style
/// [stroke] stroke size
/// [round] round stroke
class CircularProgress extends StatefulWidget {
  final double percentage;
  final Color color;
  final Color backColor;
  final bool showPercentage;
  final Gradient gradient;
  final TextStyle textStyle;
  final double stroke;
  final bool round;

  CircularProgress({
    @required this.percentage,
    this.color = Colors.orange,
    this.backColor = Colors.transparent,
    this.showPercentage = true,
    this.gradient,
    TextStyle textStyle,
    this.stroke = 20,
    this.round = true,
  }) : this.textStyle = textStyle ??
            TextStyle(
              color: Colors.black,
            );

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
      padding: EdgeInsets.all(50),
      child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget child) {
            final textSpan = TextSpan(
              text:
                  '${((widget.percentage - diferencia) + (diferencia * controller.value)).toInt()} %',
              style: widget.textStyle,
            );
            return Stack(
              fit: StackFit.expand,
              children: [
                CustomPaint(
                  painter: _Circle(
                      percentage: (widget.percentage - diferencia) +
                          (diferencia * controller.value),
                      color: widget.color,
                      backColor: widget.backColor,
                      text: (widget.showPercentage)
                          ? textSpan
                          : TextSpan(text: ''),
                      gradient: widget.gradient,
                      stroke: widget.stroke,
                      round: widget.round),
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
  final double percentage;
  final Color color;
  final Color backColor;
  final TextSpan text;
  final Gradient gradient;
  final double stroke;
  final bool round;

  _Circle(
      {@required this.percentage,
      @required this.color,
      @required this.backColor,
      this.text,
      this.gradient,
      this.stroke,
      this.round = true});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..color = backColor;

    final center = Offset(size.width * 0.5, size.height * 0.5);
    final radius = min(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(center, radius, paint);

    final paintProgress = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = round ? StrokeCap.round : StrokeCap.butt
      ..strokeWidth = 10;

    if (gradient != null) {
      final Rect rect = Rect.fromCircle(
        center: Offset(0, 0),
        radius: 360,
      );
      paintProgress.shader = gradient.createShader(rect);
    } else
      paintProgress.color = color;

    double arcAngle = 2 * pi * (percentage / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, paintProgress);

    final textPainter =
        TextPainter(text: text, textDirection: TextDirection.ltr)..layout();

    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) * 0.5,
        (size.height - textPainter.height) * 0.5,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
