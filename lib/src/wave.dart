import 'dart:math' as math;

import 'package:flutter/material.dart';

class Wave extends StatefulWidget {
  final double? value;
  final Color color;
  final Axis direction;
  final double? waveInclination;
  final int? waveDurationSeconds;

  const Wave({
    Key? key,
    required this.value,
    required this.color,
    required this.direction,
    this.waveInclination = 30,
    this.waveDurationSeconds = 2,
  }) : super(key: key);

  @override
  _WaveState createState() => _WaveState();
}

class _WaveState extends State<Wave> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.waveDurationSeconds ?? 2),
    );
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
      builder: (context, child) => ClipPath(
        child: Container(
          color: widget.color,
        ),
        clipper: _WaveClipper(
          animationValue: _animationController.value,
          value: widget.value,
          direction: widget.direction,
          waveInclination: widget.waveInclination ?? 30,
        ),
      ),
    );
  }
}

class _WaveClipper extends CustomClipper<Path> {
  final double animationValue;
  final double? value;
  final Axis direction;
  final double waveInclination;

  _WaveClipper({
    required this.animationValue,
    required this.value,
    required this.direction,
    required this.waveInclination,
  });

  @override
  Path getClip(Size size) {
    if (direction == Axis.horizontal) {
      Path path = Path()
        ..addPolygon(_generateHorizontalWavePath(size, waveInclination), false)
        ..lineTo(0.0, size.height)
        ..lineTo(0.0, 0.0)
        ..close();
      return path;
    }

    Path path = Path()
      ..addPolygon(_generateVerticalWavePath(size, waveInclination), false)
      ..lineTo(size.width, size.height)
      ..lineTo(0.0, size.height)
      ..close();
    return path;
  }

  List<Offset> _generateHorizontalWavePath(Size size, double waveInclination) {
    final waveList = <Offset>[];
    for (int i = -3; i <= size.height.toInt() + 3; i++) {
      final waveHeight = (size.width / 50);
      final dx = math.sin((animationValue * 360 - i) % 360 * (math.pi / 180)) *
              waveHeight +
          (size.width * value!);
      waveList.add(Offset(dx, i.toDouble()));
    }
    return waveList;
  }

  List<Offset> _generateVerticalWavePath(Size size, double waveInclination) {
    final waveList = <Offset>[];
    for (int i = -3; i <= size.width.toInt() + 3; i++) {
      final waveHeight = (size.height / waveInclination);
      final dy = math.sin((animationValue * 360 - i) % 360 * (math.pi / 180)) *
              waveHeight +
          (size.height - (size.height * value!));
      waveList.add(Offset(i.toDouble(), dy));
    }
    return waveList;
  }

  @override
  bool shouldReclip(_WaveClipper oldClipper) =>
      animationValue != oldClipper.animationValue;
}
