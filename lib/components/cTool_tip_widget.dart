import 'package:flutter/material.dart';

class CTooltipWidget extends StatelessWidget {
  final Widget? child;
  final String? message;

  CTooltipWidget({
    Key? key,
    required this.child,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
        message: message, showDuration: Duration(seconds: 2), child: child);
  }
}
