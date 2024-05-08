import 'package:entrolabs_attadance/components/cButton.dart';
import 'package:entrolabs_attadance/constants/cColors.dart';
import 'package:entrolabs_attadance/utils/display_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/image_constants.dart';

class GetStartScreen extends StatelessWidget {
  const GetStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: getWidth(context),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      ImageConstants.bgImagePng,
                    ),
                    fit: BoxFit.cover)),
            child: Column(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(ImageConstants.entrolabsLogoIconSvg),

                    vGap(getHeight(context)/5),
                    CButton(
                      width: getWidth(context)/1.5,
                      color: cWhiteColor,
                      onPressed: () {
                        
                      },
                      text: Text("Get Started")),
                      vGap(getHeight(context)/6),
              ],
            )));
  }
}
