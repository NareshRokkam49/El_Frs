import 'package:flutter/material.dart';

import '../constants/cColors.dart';
import '../resourses/text_styles.dart';

class StarTextWidget extends StatelessWidget {
  final String? text;
  StarTextWidget({
    Key? key,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text ?? "",
          style: TextStyles.getSubTita16(
              textColor: cBlackColor, fontWeight: FontWeight.w600),
        ),
        Text(
          ' *',
          style: TextStyles.getSubTita16(
              textColor: cRedColor, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
