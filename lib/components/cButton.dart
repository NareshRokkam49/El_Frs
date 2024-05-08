import 'package:flutter/cupertino.dart';

import '../constants/cColors.dart';



class CButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget text;
  final double? width;
  final double? height;
  final TextStyle? style;
  final Color? color;
  final Color? textColor;
  final Color? loadingColor;
  final EdgeInsets? contentPadding;
  final Color? borderColor;
  final BoxBorder? border;
  final double? borderRadius;
  final bool? loadingView;
  final DecorationImage? image;
final Widget? child;
  CButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.width,
    this.height,
    this.color,
    this.style,
    this.image,
    this.loadingColor,
    this.textColor,
    this.loadingView,
    this.contentPadding,
    this.borderColor,
    this.borderRadius,
    this.border,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
                  image:image?? null,
          borderRadius: BorderRadius.circular(borderRadius ?? 16),
            border: border,
          color: onPressed != null
              ? (color ?? (borderColor ?? cPrimeryColor))
              : null),
      width: width,
      height: height == null ? 55 : height,
      child: CupertinoButton(
        minSize: 45,
        pressedOpacity: .1,
        
        padding: EdgeInsets.all(0),
        onPressed: (loadingView ?? false) ? () {} : onPressed,
        child: Padding(
          padding: contentPadding ?? const EdgeInsets.all(8.0),
          child: (loadingView ?? false)
              ? Center(
                  child:child
                )
              : text,
        ),
      ),
    );
  }
}
