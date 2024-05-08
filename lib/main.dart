
import 'package:entrolabs_attadance/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/local_storage_dart';
import 'constants/cColors.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';


void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await GeocodingPlatform.instance.locationFromAddress;
  await Preferences.initSharedPreference(
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(EntroLabApp());
  });
}

class EntroLabApp extends StatelessWidget {
  EntroLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, screenType) {
      
      return GetMaterialApp(
        color: cPrimeryColor2,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          
          primarySwatch: Colors.blue,
         applyElevationOverlayColor: true,
          textTheme: GoogleFonts.dmSansTextTheme(Theme.of(context).textTheme),
          fontFamily: "DmSans",
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
       initialRoute: AppRoutes.initial,
       getPages: AppPages.routes,

      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageConstants.bgImagePng), fit: BoxFit.cover)),
      ),
      );
    });
  }
}


//app labal name change -> mainfest->
//android:label="reuse_project" 
// compaile sdk 33
//target sdk 33
//min sdk 21
//font google font DmSans
//