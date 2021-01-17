import 'package:flutter/material.dart';

/// A button that will be disabled onTap until its onTap
/// call is done.
class SingleTapButton extends StatefulWidget {
  final Widget child;

  final Function() onTap;

  final Duration duration;

  final Color color;

  const SingleTapButton({Key key,
    @required this.onTap,
    @required this.child,
    this.duration = const Duration(milliseconds: 700),
    this.color = Colors.grey}) :
        assert(onTap != null, 'You must provide an onTap function'),
        assert (child != null, 'You must provide a child'),
        super(key: key);

  @override
  _SingleTapButtonState createState() => _SingleTapButtonState();
}

class _SingleTapButtonState extends State<SingleTapButton>
    with SingleTickerProviderStateMixin{

  AnimationController _controller;

  Animation<double> _opacityAnimation;

  @override
  void initState() {
    _controller = AnimationController(duration: widget.duration,vsync: this);

    _opacityAnimation = Tween<double>(begin: 0, end: 0.65)
        .animate(CurveTween(curve: Curves.easeOutSine,)
        .animate(_controller));

    super.initState();
  }

  bool isRunning = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: _buildChildren().toList(),
      ),
    );
  }

  void _onTap() async {
    if(! isRunning) {
      setState(() => isRunning = true);
      _controller.repeat(reverse: true);

      await widget.onTap();
      setState(() => isRunning = false);
      _controller.reset();

    }
  }

  Iterable<Widget> _buildChildren() sync*{
    yield widget.child;
    if(isRunning)
      yield AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Container(
          constraints: BoxConstraints.expand(),
          color: Colors.grey.withOpacity(_opacityAnimation.value),
        ),
      );
  }
}
