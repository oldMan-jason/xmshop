import 'package:flutter/material.dart';

/**
 *  缓存page页面的状态
 */

class CachePageStateWrapperTool extends StatefulWidget {
  final Widget child;
  final bool keepAlive;

  // 自定义构造函数
  const CachePageStateWrapperTool({
    super.key,
    required this.keepAlive,
    required this.child,
  });

  @override
  State<CachePageStateWrapperTool> createState() =>
      _CachePageStateWrapperToolState();
}

class _CachePageStateWrapperToolState extends State<CachePageStateWrapperTool>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}
