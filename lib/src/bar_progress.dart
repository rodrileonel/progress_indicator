import 'package:flutter/material.dart';

/// BarProgress Class
/// [percentage] from 0 to 100 percentage circle
/// [color] percentage line color
/// [backColor] back circle color
/// [showPercentage] show percentage text
/// [gradient] show gradient instead of color
/// [textStyle] text percentage style
/// [stroke] stroke size
/// [margin] stroke size
class BarProgress extends StatefulWidget {
  final double percentage;
  final Color color;
  final Color backColor;
  final bool showPercentage;
  final Gradient? gradient;
  final TextStyle textStyle;
  final double stroke;
  final bool round;
  final EdgeInsets? margin;

  BarProgress(
      {required this.percentage,
      this.color = Colors.orange,
      this.backColor = Colors.transparent,
      this.showPercentage = true,
      this.gradient,
      TextStyle? textStyle,
      this.stroke = 20,
      this.round = true,
      this.margin})
      : this.textStyle = textStyle ??
            TextStyle(
              color: Colors.black,
            );

  @override
  _BarProgressState createState() => _BarProgressState();
}

class _BarProgressState extends State<BarProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late double oldPercentage;

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
      height: double.minPositive,
      margin: widget.margin,
      child: AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, Widget? child) {
            final textSpan = TextSpan(
              text:
                  '${((widget.percentage - diferencia) + (diferencia * controller.value)).toInt()} %',
              style: widget.textStyle,
            );
            return Stack(
              fit: StackFit.expand,
              children: [
                CustomPaint(
                  painter: _Bar(
                    percentage: (widget.percentage - diferencia) +
                        (diferencia * controller.value),
                    color: widget.color,
                    back: widget.backColor,
                    text:
                        (widget.showPercentage) ? textSpan : TextSpan(text: ''),
                    gradient: widget.gradient,
                    stroke: widget.stroke,
                    round: widget.round,
                  ),
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

class _Bar extends CustomPainter {
  final double percentage;
  final Color color;
  final Color back;
  final TextSpan? text;
  final Gradient? gradient;
  final double? stroke;
  final bool round;

  _Bar({
    required this.percentage,
    required this.color,
    required this.back,
    this.text,
    this.gradient,
    this.stroke,
    this.round = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = round ? StrokeCap.round : StrokeCap.butt
      ..strokeWidth = this.stroke!
      ..color = back;

    canvas.drawLine(Offset(0, 0), Offset(size.width, 0), paint);

    final paintProgress = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = round ? StrokeCap.round : StrokeCap.butt
      ..strokeWidth = this.stroke!
      ..color = color;

    if (gradient != null) {
      final Rect rect = Rect.fromCircle(
        center: Offset(0, 0),
        radius: 360,
      );
      paintProgress.shader = gradient!.createShader(rect);
    } else
      paintProgress.color = color;

    canvas.drawLine(
        Offset(0, 0), Offset(size.width * percentage / 100, 0), paintProgress);

    final textPainter = TextPainter(
      text: text,
      textDirection: TextDirection.ltr,
    )..layout();
    final height =
        (size.height - textPainter.height) * 0.5 - (size.height) * 0.5;
    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) * 0.5,
        height,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
