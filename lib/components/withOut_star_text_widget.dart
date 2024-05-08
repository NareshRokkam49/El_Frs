import 'package:flutter/material.dart';

import '../constants/cColors.dart';
import '../resourses/text_styles.dart';


class CWithoutStarTextWidget extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final TextStyle? style;
  CWithoutStarTextWidget({
    Key? key,
    required this.text,
    this.textColor,
    this.style

  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style:style?? TextStyles.getSubTita16(
          textColor:textColor?? cBlackColor, fontWeight: FontWeight.w700),
    );
  }
}
