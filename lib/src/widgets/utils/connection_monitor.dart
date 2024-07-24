import 'package:flutter/widgets.dart';

class ConnectivityBannerHost extends StatefulWidget {
  const ConnectivityBannerHost({
    super.key,
    required this.isConnected,
    required this.banner,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.fastOutSlowIn,
  });

  final bool isConnected;
  final Widget banner;
  final Widget child;
  final Duration? duration;
  final Curve curve;

  @override
  State<ConnectivityBannerHost> createState() => ConnectivityBannerHostState();
}

class ConnectivityBannerHostState extends State<ConnectivityBannerHost>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      value: widget.isConnected ? 0.0 : 1.0,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
  }

  @override
  void didUpdateWidget(covariant ConnectivityBannerHost oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isConnected != widget.isConnected) {
      if (widget.isConnected) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: _ConnectivityBannerHostDelegate(_animation),
      children: [
        LayoutId(
          id: _ConnectivityBannerHostWidgetId.child,
          child: widget.child,
        ),
        LayoutId(
          id: _ConnectivityBannerHostWidgetId.banner,
          child: widget.banner,
        ),
      ],
    );
  }
}

enum _ConnectivityBannerHostWidgetId { child, banner }

class _ConnectivityBannerHostDelegate extends MultiChildLayoutDelegate {
  _ConnectivityBannerHostDelegate(this._animation)
      : super(relayout: _animation);

  final Animation<double> _animation;

  @override
  void performLayout(Size size) {
    layoutChild(
        _ConnectivityBannerHostWidgetId.child, BoxConstraints.tight(size));
    positionChild(_ConnectivityBannerHostWidgetId.child, Offset.zero);

    final bannerSize = layoutChild(
      _ConnectivityBannerHostWidgetId.banner,
      BoxConstraints.tightFor(width: size.width),
    );
    positionChild(
      _ConnectivityBannerHostWidgetId.banner,
      Offset(
        0.0,
        size.height - (_animation.value * bannerSize.height),
      ),
    );
  }

  @override
  bool shouldRelayout(covariant _ConnectivityBannerHostDelegate oldDelegate) {
    return _animation != oldDelegate._animation;
  }
}
