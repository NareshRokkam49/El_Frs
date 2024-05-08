import 'dart:async';
import 'package:entrolabs_attadance/routes/app_routes.dart';
import 'package:entrolabs_attadance/utils/local_storage_dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../constants/image_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      ImageConstants.bgImagePng,
                    ),
                    fit: BoxFit.cover)),
            child: Center(
                child: SvgPicture.asset(ImageConstants.entrolabsLogoIconSvg))));
  }

  void initState() {
    getValidation();
    super.initState();
  }

  getValidation() async {
    final userName=Preferences.getUserName();
     Timer(Duration(seconds: 3), () {
      Get.offAllNamed(userName == userName.toString() && userName != null && userName.isNotEmpty
          ? AppRoutes.btmNavigationScreen
          : AppRoutes.loginScreen);
   });
}
}
