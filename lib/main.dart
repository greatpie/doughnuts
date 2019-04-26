import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie_flutter/lottie_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

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
    with SingleTickerProviderStateMixin {
  int _score = 0;
  final _rightPosition = 20.0;
  final _textStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.none);

  LottieComposition _composition;
  String _assetName;
  AnimationController _controller;
  bool _repeat;

  @override
  initState() {
    super.initState();

    _repeat = false;
    _assetName = 'assets/animation/ant.json';
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _controller.addListener(() => setState(() {}));
    _controller.repeat();

    loadAsset(_assetName).then((LottieComposition composition) {
      setState(() {
        _composition = composition;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _loadButtonPressed(String assetName) {
    loadAsset(assetName).then((LottieComposition composition) {
      setState(() {
        _assetName = assetName;
        _composition = composition;
        _controller.reset();
      });
    });
  }

  void _increaseScore() {
    setState(() {
      // _controller.repeat();
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
                child: Lottie(
                  composition: _composition,
                  size: Size(200.0, 200.0),
                  controller: _controller,
                ),
                onTap: _increaseScore,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<LottieComposition> loadAsset(String assetName) async {
  return await rootBundle
      .loadString(assetName)
      .then<Map<String, dynamic>>((String data) => json.decode(data))
      .then((Map<String, dynamic> map) => new LottieComposition.fromMap(map));
}
