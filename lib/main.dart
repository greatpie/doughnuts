import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

class _DoughnutsAppState extends State<DoughnutsApp> {
  int _score = 0;

  final _rightPosition = 20.0;
  final _textStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.none);

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
                child: SvgPicture.asset(
                  'assets/svg/ant.svg',
                  height: _h(76),
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
