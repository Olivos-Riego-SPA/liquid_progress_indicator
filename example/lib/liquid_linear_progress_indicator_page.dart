import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class LiquidLinearProgressIndicatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liquid Linears Progress Indicators"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _AnimatedLiquidLinearProgressIndicator(),
          Container(
            width: double.infinity,
            height: 150,
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: LiquidLinearProgressIndicator(
              direction: Axis.vertical,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation(Colors.red),
              waveDurationSeconds: 1,
              waveInclination: 3,
            ),
          ),
          Container(
            width: double.infinity,
            height: 35,
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: LiquidLinearProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation(Colors.pink),
              borderColor: Colors.red,
              borderWidth: 5.0,
              direction: Axis.vertical,
            ),
          ),
          Container(
            width: double.infinity,
            height: 35,
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: LiquidLinearProgressIndicator(
              direction: Axis.horizontal,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation(Colors.grey),
              borderColor: Colors.blue,
              borderWidth: 5.0,
              center: Text(
                "Loading...",
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 35,
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: LiquidLinearProgressIndicator(
              backgroundColor: Colors.lightGreen,
              valueColor: AlwaysStoppedAnimation(Colors.blueGrey),
              direction: Axis.vertical,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedLiquidLinearProgressIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _AnimatedLiquidLinearProgressIndicatorState();
}

class _AnimatedLiquidLinearProgressIndicatorState
    extends State<_AnimatedLiquidLinearProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    _animationController.addListener(() => setState(() {}));
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = _animationController.value * 100;
    return Center(
      child: Container(
        width: double.infinity,
        height: 150.0,
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: LiquidLinearProgressIndicator(
          value: _animationController.value,
          direction: Axis.vertical,
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation(Colors.blue),
          borderRadius: 12.0,
          center: Text(
            "${percentage.toStringAsFixed(0)}%",
            style: TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
