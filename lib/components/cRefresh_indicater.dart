import 'package:flutter/material.dart';

import '../constants/cColors.dart';


class CRefreshIndicaterWidget extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  CRefreshIndicaterWidget(
      {Key? key, required this.onRefresh, required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      displacement: 50,
      edgeOffset: 50,
      strokeWidth: 3,
      color: cPrimeryColor,
      backgroundColor: cPrimeryColor2,
      onRefresh: onRefresh,
      child: child,
    ));
  }
}
