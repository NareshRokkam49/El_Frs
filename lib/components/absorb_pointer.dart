import 'package:flutter/material.dart';
import '../constants/cColors.dart';
import '../utils/display_utils.dart';

class CAbsorbPointerWidget extends StatelessWidget {
  final String? text;
  final double? height;
  CAbsorbPointerWidget({
    Key? key,
    required this.text,
    this.height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: cTextFeildFillColor,
            border: Border.all(color: cGrayColor)),
        height: 90,
        width: getWidth(context),
        child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    text ?? "",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              
              ],
            ),
          ),
        ));
  }
}
