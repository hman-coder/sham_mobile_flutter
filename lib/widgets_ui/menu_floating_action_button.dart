import 'package:flutter/material.dart';

/// [menuItems] are the widgets that will represent menu items.
/// [fromDegree] and [toDegree] define the range within
/// which the widgets should be displayed. They default
/// to 180, and 270 respectively.
/// [animationController] this is particularly useful if you want
/// to hide the menu upon tapping one of the buttons. The [duration]
/// argument will not be used if a controller is specified.
class MenuFloatingActionButton extends StatefulWidget {
  final List<Widget> menuItems;

  final FloatingActionButton fab;

  final double fromDegree;

  final double toDegree;

  final double distance;

  final Duration duration;

  final Curve curve;

  final AnimationController animationController;

  const MenuFloatingActionButton({Key key,
    @required this.menuItems,
    @required this.fab,
    this.curve = Curves.easeInOut,
    this.fromDegree = 180,
    this.toDegree = 270,
    this.distance = 100,
    this.duration = const Duration(milliseconds: 500),
    this.animationController}) :
        assert(menuItems != null && fab != null,
        'You must provide both the FloatingActionButton and '
            'the widgets that would extend from it'),
        assert (fromDegree < toDegree, 'fromDegree should be smaller than toDegree'),
        super(key: key);

  @override
  _MenuFloatingActionButtonState createState() => _MenuFloatingActionButtonState();
}

class _MenuFloatingActionButtonState extends State<MenuFloatingActionButton>
    with SingleTickerProviderStateMixin{

  AnimationController _privateAnimationController;

  List<Animation<Offset>> _offsetAnimations;

  Animation _rotationAnimation;

  AnimationController get _animationController =>
      widget.animationController ?? _privateAnimationController;

  @override
  void initState() {
    if(widget.animationController == null)
      _privateAnimationController = AnimationController(
          duration: widget.duration,
          vsync: this
      );

    _animationController.addStatusListener((status) {
      if(status == AnimationStatus.forward)
        shouldReverse = true;
      else if(status == AnimationStatus.reverse)
        shouldReverse = false;
    });

    _initAnimations();
    super.initState();
  }

  void _initAnimations() {
    _initOffsetAnimations();
    _initRotationAnimation();
  }

  void _initRotationAnimation() {
    _rotationAnimation = Tween(begin: 180.0, end: 0.0)
        .animate(CurvedAnimation(
        parent: _animationController,
        curve: widget.curve)
    );
  }

  void _initOffsetAnimations() {
    int counter = 0;
    _offsetAnimations = widget.menuItems.map<Animation<Offset>>(
            (wdgt) => Tween<Offset>(
            begin: Offset(0, 0), end: _getWidgetOffset(counter++)
        ).animate(CurvedAnimation(
            parent: _animationController,
            curve: widget.curve
        ))
    ).toList();
  }

  Offset _getWidgetOffset(int index) {
    double degreeSpan = widget.toDegree - widget.fromDegree;
    double segmentDegree = degreeSpan / (widget.menuItems.length-1);
    double degreesToIncrement = index * segmentDegree;
    double totalDegrees = widget.fromDegree + degreesToIncrement;
    double inRadians = _radiansFromDegree(totalDegrees);
    return Offset.fromDirection(inRadians, widget.distance);
  }

  double _radiansFromDegree(double degree) {
    double unit = 57.295779513;
    return degree / unit;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: MediaQuery.of(context).size,
      child: Stack(
          alignment: Alignment.center,
          children: _getMenuItems()
            ..add(_buildFab())
      ),
    );
  }

  List<Widget> _getMenuItems() {
    List<Widget> ret = List();
    for(int i = 0; i < widget.menuItems.length; i++)
      ret.add(_buildAnimatedMenuItem(i));

    return ret;
  }

  Widget _buildAnimatedMenuItem(int index) {
    return Positioned(
      bottom: 20,
      right: 20,
      child: AnimatedBuilder(
        animation: _offsetAnimations[index],
        child: widget.menuItems[index],
        builder: (context, child) =>
            Transform.translate(
              offset: _offsetAnimations[index].value,
              child: Transform(
                  transform: Matrix4.rotationZ(_radiansFromDegree(_rotationAnimation.value))..scale(_animationController.value),
                  alignment: Alignment.center,
                  child: child
              ),
            ),
      ),
    );
  }

  Widget _buildFab() {
    return Positioned(
      bottom: 20,
      right: 20,
      child: FloatingActionButton(
        onPressed: _runController,
        child: widget.fab.child,
        elevation: widget.fab.elevation,
        shape: widget.fab.shape,
        backgroundColor: widget.fab.backgroundColor,
        splashColor: widget.fab.splashColor,
        focusNode: widget.fab.focusNode,
        autofocus: widget.fab.autofocus,
        clipBehavior: widget.fab.clipBehavior,
        disabledElevation: widget.fab.disabledElevation,
        focusColor: widget.fab.focusColor,
        focusElevation: widget.fab.focusElevation,
        foregroundColor: widget.fab.foregroundColor,
        heroTag: widget.fab.heroTag,
        highlightElevation: widget.fab.highlightElevation,
        hoverColor: widget.fab.hoverColor,
        hoverElevation: widget.fab.hoverElevation,
        isExtended: widget.fab.isExtended,
        key: widget.fab.key,
        materialTapTargetSize: widget.fab.materialTapTargetSize,
        mini: widget.fab.mini,
        mouseCursor: widget.fab.mouseCursor,
        tooltip: widget.fab.tooltip,
      ),
    );
  }

  bool shouldReverse = false;

  _runController() {
    if(shouldReverse) _animationController.reverse();
    else _animationController.forward();
  }

  @override
  void dispose() {
    if(_privateAnimationController != null)
      _privateAnimationController.dispose();
    super.dispose();
  }
}
