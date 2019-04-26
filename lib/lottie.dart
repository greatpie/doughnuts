import 'dart:ui';

import 'package:flutter/widgets.dart';

SizedBox box;

class Lottie extends AnimatedWidget {
  const Lottie({
    Key key,
    @required this.lottieAnimation,
    @required AnimationController controller,
    @required this.width,
    @required this.height,
    this.semanticsLabel,
  })  : assert(controller != null),
        assert(lottieAnimation != null),
        assert(width != null && width > 0.0),
        assert(height != null && height > 0.0),
        super(key: key, listenable: controller);

  Animation<double> get _progress => listenable;

  final LottieAnimation lottieAnimation;
  final double width;
  final double height;
  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    Widget widget = _Lottie(
      lottieAnimation: lottieAnimation,
      progress: _progress.value,
      width: width,
      height: height,
    );
    if (semanticsLabel != null) {
      widget = Semantics(
        label: semanticsLabel,
        textDirection: Directionality.of(context),
        child: widget,
      );
    }
    return widget;
  }
}

class _Lottie extends LeafRenderObjectWidget {
  const _Lottie(
      {@required this.lottieAnimation,
      @required this.progress,
      @required this.width,
      @required this.height,
      Key key})
      : assert(lottieAnimation != null),
        assert(progress != null),
        assert(progress >= 0.0 && progress <= 1.0),
        assert(width != null && width > 0.0),
        assert(height != null && height > 0.0),
        super(key: key);

  final LottieAnimation lottieAnimation;
  final double progress;
  final double width;
  final double height;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _LottieRenderObject(lottieAnimation, progress, width, height);

  @override
  void updateRenderObject(
    BuildContext context,
    _LottieRenderObject renderObject,
  ) {
    renderObject
      ..lottieAnimation = lottieAnimation
      ..progress = progress
      ..width = width
      ..height = height;
  }
}

class _LottieRenderObject extends RenderBox {
  _LottieRenderObject(
    this._lottieAnimation,
    this._progress,
    this._width,
    this._height,
  );

  LottieAnimation _lottieAnimation;
  LottieAnimation get lottieAnimation => _lottieAnimation;
  set lottieAnimation(LottieAnimation value) {
    if (_lottieAnimation != value) {
      _lottieAnimation = value;
      markNeedsPaint();
    }
  }

  double _progress;
  double get progress => _progress;
  set progress(double value) {
    if (_progress != value) {
      _progress = value;
      markNeedsPaint();
    }
  }

  double _width;
  set width(double value) {
    if (_width != value) {
      _width = value;
      markNeedsPaint();
    }
  }

  double _height;
  set height(double value) {
    if (_height != value) {
      _height = value;
      markNeedsPaint();
    }
  }

  @override
  bool get sizedByParent => true;

  @override
  void paint(PaintingContext context, Offset offset) {
    lottieAnimation.drawFrame(
      context.canvas,
      _progress,
      _height,
      _width,
    );
    // context.canvas.restore();
  }
}