import 'dart:ui';

import 'package:flutter/material.dart';

/// A widget that shows an array of asset images one after
/// the other.
class ImageSwitcher extends StatefulWidget {
  /// The list of asset images URL's
  final List<String> images;

  /// The wait time before switching to the other image
  final Duration duration;

  /// Controls the animation curve
  final Curve curve;

  /// The direction from which an image should enter/leave.
  final TextDirection direction;

  const ImageSwitcher({
    Key key,
    @required this.images,
    @required this.duration,
    this.direction = TextDirection.ltr,
    this.curve = Curves.easeInExpo})
      : assert(images != null),
        assert (duration != null),
        super(key: key);

  @override
  _ImageSwitcherState createState() => _ImageSwitcherState();
}

class _ImageSwitcherState extends State<ImageSwitcher>
    with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Widget firstImage;
  Widget secondImage;
  int _currentIndex = 0;

  Animation _animation;

  @override
  void initState() {
    _resetImages();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _controller.addListener(() => setState(() {}));

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _controller,
        curve: widget.curve
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _resetImages();
        _controller.reset();
        _controller.forward();
      }
    });

    _controller.forward();

    super.initState();
  }

  void _resetImages() {
    firstImage = Image.asset(widget.images[_currentIndex++], fit: BoxFit.fitHeight);

    _currentIndex = _currentIndex >= widget.images.length ? 0 : _currentIndex;
    print(_currentIndex);
    secondImage = Image.asset(widget.images[_currentIndex], fit: BoxFit.fitHeight,);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
            children: [
              _buildComponent(
                  animation: _animation,
                  child: firstImage,
                  position: _calculateFirstWidgetPosition(context)
              ),

              _buildComponent(
                  animation: _animation,
                  child: secondImage,
                  position: _calculateSecondWidgetPosition(context)
              ),
            ]
    );
  }

  double _calculateFirstWidgetPosition(BuildContext context) {
    return -1 * _animation.value * MediaQuery.of(context).size.width;
  }

  double _calculateSecondWidgetPosition(BuildContext context) {
    return (1 - _animation.value) * MediaQuery.of(context).size.width;
  }

  Widget _buildComponent({@required Animation animation, @required Widget child, @required double position}) {
    return Transform.translate(
      offset: Offset(position, 0),
      child: child,
    );
  }
}
