import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


late FragmentProgram fragmentProgram;

void main() async {
  fragmentProgram = await FragmentProgram.fromAsset('shaders/fractal_pyramid.glsl');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late final Ticker _ticker;
  final timeWrapper = TimeWrapper();

  @override
  void initState() {
    super.initState();

    _ticker = createTicker(
      (elapsed) {
        timeWrapper.time += 0.01;
        setState(() {});
      },
    );
    _ticker.start();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: CustomPaint(
        painter: MyPainter(
          timeWrapper: timeWrapper,
          shader: fragmentProgram.fragmentShader(),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  MyPainter({
    required this.timeWrapper,
    required this.shader,
  });

  final TimeWrapper timeWrapper;
  final FragmentShader shader;

  @override
  void paint(Canvas canvas, Size size) {
    // print(timeWrapper.time);
    shader.setFloat(0, timeWrapper.time);
    shader.setFloat(1, size.width);
    shader.setFloat(2, size.height);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return true;
  }
}

class TimeWrapper {
  TimeWrapper() : time = 0;
  double time;
}