import 'package:entrolabs_attadance/resourses/text_styles.dart';
import 'package:entrolabs_attadance/utils/display_utils.dart';
import 'package:flutter/material.dart';

import '../constants/cColors.dart';

class CProgressIndicaterWidget extends StatelessWidget {
  final Color? color;
 
   const CProgressIndicaterWidget({
    Key? key,
  this.color,
   
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
                child: CircularProgressIndicator(
                  color:color?? cWhiteColor,
                  strokeWidth: 3
                )
              ),
              vGap(10),
              Text("Loading...",style: TextStyles.getSubTita13(textColor:color?? cWhiteColor ),)
      ],
    );
  }
}
