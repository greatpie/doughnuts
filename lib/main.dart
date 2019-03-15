import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MaterialApp(
    title: 'Help Doughnuts',
    home: DoughnutsApp(),
    theme: _customTheme,
  ));
}
var _customTheme =ThemeData(
  primaryColor: Colors.black,
  backgroundColor: Colors.white,
);
class DoughnutsApp extends StatefulWidget {
  @override
  _DoughnutsAppState createState() => _DoughnutsAppState();
}

class _DoughnutsAppState extends State<DoughnutsApp> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
//    double statusH = ScreenUtil.statusBarHeight;

    double rightPosition = 20.0;
    var textStyle = TextStyle(
        color: Colors.black,
        fontSize: ScreenUtil(allowFontScaling: true).setSp(24),
        fontWeight: FontWeight.normal,
        decoration: TextDecoration.none);

    return Container(
      color: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[     
          Positioned(
            top: ScreenUtil().setSp(80),
            right: rightPosition,
            child: Text(
              'Score',
              style: textStyle,
            ),
          ),
          Positioned(
            top: ScreenUtil().setSp(130),
            right: rightPosition,
            child: Text(
              '100',
              style: textStyle,
            ),
          ),
          Positioned(
            top: ScreenUtil().setSp(373),
            child: Image(
              image: AssetImage("assets/donuts.png"),
              height: ScreenUtil().setHeight(156),
            ),
          ),
        ],
      ),
    );
  }
}
