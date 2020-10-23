import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(MaterialApp(
    title: 'Help Doughnuts',
    home: DoughnutsApp(),
  ));
}

class DoughnutsApp extends StatefulWidget {
  @override
  _DoughnutsAppState createState() => _DoughnutsAppState();
}

class _DoughnutsAppState extends State<DoughnutsApp>
    with TickerProviderStateMixin {
  int _score = 0;

  final _rightPosition = 20.0;
  final _textStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.none);

  AnimationController _controller;

  @override
  initState() {
    super.initState();

    _controller = AnimationController(vsync: this)
      ..value = 0.5
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _increaseScore() {
    setState(() {
      _score++;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

//    set size
    var _h = (size) => ScreenUtil().setHeight(size);

    return Container(
      color: Colors.white,
      child: DefaultTextStyle(
        style: _textStyle,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: _h(80),
              right: _rightPosition,
              child: Text(
                'Score',
                style: TextStyle(fontSize: _h(24)),
              ),
            ),
            Positioned(
              top: _h(130),
              right: _rightPosition,
              child: Text(
                '$_score',
                style: TextStyle(fontSize: _h(49)),
              ),
            ),
            Positioned(
              top: _h(373),
              child: SvgPicture.asset(
                'assets/svg/doughnuts.svg',
                height: _h(156),
              ),
            ),
            Positioned(
              top: _h(840),
              child: GestureDetector(
                child: Lottie.asset('assets/animation/ant.json',
                    width: 200, height: 200, onLoaded: (composition) {
                  _controller
                    ..duration = Duration(milliseconds: 200)
                    ..repeat();
                }),
                onTap: _increaseScore,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
