import 'package:entrolabs_attadance/components/cButton.dart';
import 'package:flutter/material.dart';

import '../constants/cColors.dart';
import '../constants/cStrings.dart';
import '../resourses/text_styles.dart';
import '../utils/display_utils.dart';

class CemaraBottomSheetWidget extends StatelessWidget {
  final Function()? onChanged1;
  final Function()? onChanged2;
  CemaraBottomSheetWidget({
    Key? key,
    required this.onChanged1,
    required this.onChanged2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            vGap(10),
            Container(
              height: 8,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: cGrayColor2,
              ),
            ),
            vGap(10),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                CStrings.uploadImage,
                style: TextStyles.getSubTital20(textColor: cGrayColor2),
              ),
            ),
            vGap(40),
            Column(
              children: [
                CButton(
                    borderColor: cPrimeryColor2,
                    width: getWidth(context),
                    color: cPrimeryColor2,
                    onPressed: onChanged1 ?? () {},
                    text: Text(
                      CStrings.chooseFromCamera,
                      style: TextStyles.getSubTital20(textColor: cBlackColor),
                    )),
                vGap(5),
                CButton(
                    borderColor: cPrimeryColor2,
                    width: getWidth(context),
                    color: cPrimeryColor2,
                    onPressed: onChanged2 ?? () {},
                    text: Text(
                      CStrings.chooseFromGallery,
                      style: TextStyles.getSubTital20(textColor: cBlackColor),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
