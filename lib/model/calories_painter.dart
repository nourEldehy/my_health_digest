import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_and_diet_app/global/myColors.dart';
import 'package:training_and_diet_app/model/provider_calories.dart';
import 'package:vector_math/vector_math_64.dart' as maths;
import 'dart:math' as math;

class CaloriesPainter extends StatefulWidget {
  @override
  _CaloriesPainterState createState() => _CaloriesPainterState();
}

class _CaloriesPainterState extends State<CaloriesPainter>
    with SingleTickerProviderStateMixin {
  AnimationController _progressAnimationController;
  Animation<double> _progressAnimation;
  // double progressDegrees = 0;
  // double goalCompleted =
  //     CaloriesProgress.caloriesConsumed / CaloriesProgress.totalCalories;

  @override
  void initState() {
    super.initState();
    _progressAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _progressAnimation =
        Tween(begin: 0.0, end: 360.0).animate(_progressAnimationController)
          ..addListener(() {
            setState(() {
              // progressDegrees = goalCompleted * _progressAnimation.value;
            });
          });
    _progressAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 150,
        width: 150,
        // color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Provider.of<CaloriesProvider>(context)
                  .calculateRemaining()
                  .toString(),
              style: MyColors.T1,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                "kcal",
                style: MyColors.T2,
              ),
            ),
          ],
        ),
      ),
      painter: RadialPainter(
          Provider.of<CaloriesProvider>(context).calculateRemaining() *
              360 /
              Provider.of<CaloriesProvider>(context).dailyCalories),
    );
  }
}

class RadialPainter extends CustomPainter {
  double progressDegrees;
  RadialPainter(this.progressDegrees);

  @override
  void paint(Canvas canvas, Size size) {
    final strokecolor = 0xfff94f46;
    double strokewidth = 15;
    Paint paint = Paint()
      ..color = Colors.transparent
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokewidth;
    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width * 0.4, paint);

    Paint rectPaint = Paint()
      ..color = Color(strokecolor).withOpacity(0.3)
      ..blendMode = BlendMode.darken
      ..style = PaintingStyle.fill;

    for (double angle = 360; angle >= 0; angle = angle - 5) {
      double angleInRadians = angle * math.pi / 180;

      double x = size.width * 0.4 * math.cos(angleInRadians);
      double y = size.width * 0.4 * math.sin(angleInRadians);
      y -= size.width * 0.4;
      y = -y;
      x += size.width / 2;
      canvas.save();
      canvas.translate(x, y + 15);
      canvas.rotate(-angleInRadians);
      canvas.drawRect(
          Rect.fromCenter(height: 1, width: strokewidth, center: Offset(0, 0)),
          rectPaint);
      canvas.restore();
    }

    Paint inner = Paint()
      ..color = Color(strokecolor)
      ..blendMode = BlendMode.darken
      ..style = PaintingStyle.fill;

    for (double angle = 360; angle >= 0; angle = angle - 22.5) {
      double angleInRadians = angle * math.pi / 180;
      double t = 0.27;

      double x = size.width * t * math.cos(angleInRadians);
      double y = size.width * t * math.sin(angleInRadians);
      y -= size.width * t;
      y = -y;
      x += size.width / 2;
      canvas.save();
      canvas.translate(x, y + 35);
      canvas.rotate(-angleInRadians);
      canvas.drawRect(
          Rect.fromCenter(height: 2, width: 2, center: Offset(0, 0)), inner);
      canvas.restore();
    }
    Paint progressPaint = Paint()
      ..color = Color(strokecolor)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokewidth;
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: size.width * 0.4),
        maths.radians(-90),
        maths.radians(progressDegrees),
        false,
        progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
