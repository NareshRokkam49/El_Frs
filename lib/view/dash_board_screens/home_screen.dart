import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:entrolabs_attadance/components/cButton.dart';
import 'package:entrolabs_attadance/components/cRefresh_indicater.dart';
import 'package:entrolabs_attadance/components/is_loading_widget.dart';
import 'package:entrolabs_attadance/components/progress_indicater_widget.dart';
import 'package:entrolabs_attadance/constants/cColors.dart';
import 'package:entrolabs_attadance/constants/cStrings.dart';
import 'package:entrolabs_attadance/constants/image_constants.dart';
import 'package:entrolabs_attadance/modals/res/employee_details_res.dart';
import 'package:entrolabs_attadance/modals/res/take_brake_res.dart';
import 'package:entrolabs_attadance/resourses/text_styles.dart';
import 'package:entrolabs_attadance/routes/app_routes.dart';
import 'package:entrolabs_attadance/utils/display_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide Response;
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../components/custom_shape.dart';
import '../../modals/services/api_services.dart';
import '../../utils/local_storage_dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _address;

  String formattedDate = DateFormat('EEEE,MMMM d').format(DateTime.now());
  String formattedTime = DateFormat.Hm().format(DateTime.now());
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  final ValueNotifier<bool> _isLoading2 = ValueNotifier(false);

  EmployeeDetailsRes? _employeeDetailsRes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cPrimeryColor2,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 90,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageConstants.bgImagePng),
                  fit: BoxFit.cover)),
        ),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          _employeeDetailsRes == null
              ? CProgressIndicaterWidget(
                  color: cblueColor
                )
              : CRefreshIndicaterWidget(
                onRefresh: () async{
                  await getTheDataFromEmployeeDetails();
                },
                child: ListView.builder(
                    itemCount:
                        _employeeDetailsRes?.data?.length ?? 0,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      final empData =
                          _employeeDetailsRes?.data![index];
              
                      return Container(
                        width: getWidth(context),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24),
                          child: Column(
                            mainAxisAlignment:
                                MainAxisAlignment.end,
                            crossAxisAlignment:
                                CrossAxisAlignment.center,
                            children: [
                              vGap(25),
                              _logoWithNotification(empData!),
                              vGap(10),
              
                              _employeeDetails(empData),
                              vGap(10),
                              _clockInOutWidget(empData),
                              vGap(10),
                              _effectiveOverWidget(
                                  context, empData),
                              locationtracking(empData),
                              vGap(20),
                              //its only when employee after login
                              empData.checkinStatus == "1" &&
                                      empData.breakStatus == 1
                                  ? _takeABrackWidget(empData)
                                  : empData.checkinStatus == "1" &&
                                          empData.breakStatus == 2
                                      ? _takeABrackWidget(empData)
                                      : Container(),
              
                              vGap((getHeight(context) / 15 * 1.2) -
                                  30),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
          CustomPaint(
            foregroundPainter: AppBarPainter(),
            painter: AppBarPainter(),
            child: Container(
              height: 00,
            ),
          ),
        ],
      ),
      //
    );
  }

  Widget backButtonWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: InkWell(
          onTap: () {
            Get.back();
          },
          child: CircleAvatar(
              backgroundColor: cPrimeryColor2,
              child: SvgPicture.asset(
                ImageConstants.arrowBackIconSvg,
              ))),
    );
  }

  Widget locationtracking(EmployeeData empData) {

    return _address == null
        ? CircularProgressIndicator()
        : Row(
            children: [
              SvgPicture.asset(ImageConstants.locationIconSvg),
              Expanded(
                child: Text(
                  '${_address}',
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.getSubTita16(
                      fontWeight: FontWeight.w500, textColor: cblueColor),
                ),
              ),
            ],
          );
  }

  Widget _logoWithNotification(EmployeeData employeeData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(ImageConstants.aGradienticonPng),
        badges.Badge(
          position: BadgePosition.topEnd(top: 1, end: 1),
          badgeStyle: badges.BadgeStyle(
            badgeColor: Colors.transparent,
          ),
          badgeContent: Text(
            employeeData.notificationCnt == "0"
                ? ""
                : employeeData.notificationCnt ?? "",
            style: TextStyles.getSubTita16(textColor: cRedColor),
          ),
          child: InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.notificationScreen)!
                  .then((value) => getTheDataFromEmployeeDetails());
            },
            child: CircleAvatar(
                radius: 25,
                backgroundColor: cWhiteColor,
                child:
                    SvgPicture.asset(ImageConstants.notificationbellIconSvg)),
          ),
        ),
      ],
    );
  }

  Widget _employeeDetails(EmployeeData empData) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.profileScreen)!.then((value) => getTheDataFromEmployeeDetails());
      },
      child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    empData.profileImage == ""
                        ? CircleAvatar(
                            radius: 10,
                            backgroundColor: cWhiteColor,
                            child:
                                SvgPicture.asset(ImageConstants.empoyeeIconPng))
                        : CachedNetworkImage(
                            imageUrl: empData.profileImage ?? "",
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                width: (getHeight(context) / 15 * 1.2) - 10,
                                height: (getHeight(context) / 15 * 1.2) - 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              );
                            },
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CProgressIndicaterWidget(),
                            errorWidget: (context, url, error) => CircleAvatar(
                              backgroundColor: cBgColor2,
                              radius: (getHeight(context) / 26 * 1.2) - 10,
                              backgroundImage: AssetImage(
                                ImageConstants.empoyeeIconPng,
                              ),
                            ),
                          ),
                    hGap(10),
                    Container(
                      width: getWidth(context) / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${empData.name.toString()[0].toUpperCase()}" +
                                  "${empData.name!.substring(1)}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.getSubTita14(
                                  fontWeight: FontWeight.w500,
                                  textColor: cGrayColor6)),
                          Text("employee ID:${empData.employeeId ?? ""}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.getSubTita14(
                                  textColor: cGrayColor6,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward_ios_rounded,
                    size: 20, color: cBlackColor),
              ],
            ),
          )),
    );
  }

  Widget _clockInOutWidget(EmployeeData employeeData) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      ImageConstants.bgImagePng,
                    ),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vGap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        employeeData.checkintime == "" ||
                                employeeData.checkintime == null
                            ? "--:--"
                            : employeeData.checkintime ?? "",
                        style: TextStyles.getSubTita16(textColor: cWhiteColor),
                      ),
                      SvgPicture.asset(ImageConstants.timerIconSvg)
                    ],
                  ),
                  Text(
                    CStrings.clockIn,
                    style: TextStyles.getSubTita16(textColor: cWhiteColor),
                  ),
                  vGap(20),
                ],
              ),
            ),
          ),
        ),
        hGap(15),
        Flexible(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      ImageConstants.bgImagePng,
                    ),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vGap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        employeeData.checkouttime == "" ||
                                employeeData.checkouttime == null
                            ? "--:--"
                            : employeeData.checkouttime ?? "",
                        style: TextStyles.getSubTita15(),
                      ),
                      SvgPicture.asset(ImageConstants.timerIconSvg)
                    ],
                  ),
                  Text(
                    CStrings.clockOut,
                    style: TextStyles.getSubTita15(),
                  ),
                  vGap(20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _effectiveOverWidget(BuildContext context, EmployeeData empData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          empData.checkinStatus == "1"
              ? CStrings.effectiveHours
              : "Current Time",
          style: TextStyles.getSubTita14(textColor: cBlackColor),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            badges.Badge(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return _breakeInfoAlort(context, empData);
                      });
                },
                position: BadgePosition.topEnd(top: 7, end: -25),
                badgeStyle: badges.BadgeStyle(
                  padding: EdgeInsetsDirectional.only(
                    end: 0,
                  ),
                  badgeColor: Colors.transparent,
                ),
                badgeContent: SvgPicture.asset(
                  ImageConstants.infoIconSvg,
                  height: 20,
                ),
                child: Text(
                  empData.checkinStatus == "1"
                      ? empData.effectiveHours ?? ""
                      : formattedTime,
                  style: TextStyles.getHeadline36(),
                ))
          ],
        ),
        Text(
          formattedDate,
          style: TextStyles.getSubTita14(textColor: cBlackColor),
        ),
        InkWell(
          onTap: () {},
          child: Container(
              height: getHeight(context) / 4.5,
              width: getWidth(context) / 1.5,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(empData.checkinStatus == "1"
                          ? ImageConstants.checkoutIconPng
                          : ImageConstants.checkinconPng))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(ImageConstants.touchIconSvg),
                  vGap(10),
                  Text(
                    empData.checkintime == "" || empData.checkintime == null
                        ? CStrings.clockIn
                        : CStrings.clockOut,
                    style: TextStyles.getSubTita16(
                        textColor: cWhiteColor, fontWeight: FontWeight.w700),
                  ),
                ],
              )),
        ),
        vGap(10),
      ],
    );
  }

// location permisson

  void checkPermissions() async {
    PermissionStatus locationStatus = await Permission.location.status;
    PermissionStatus cemaraStatus = await Permission.camera.status;

    if (locationStatus.isDenied && cemaraStatus.isDenied) {
      // Permissions are already granted, proceed with log-related functionality.
      requestPermissions();
    } else {
      // Permissions are not granted, you can request them.
      requestPermissions();
    }
  }

  void requestPermissions() async {
    Map<Permission, PermissionStatus> permissionStatus = await [
      Permission.location,
      Permission.camera,
    ].request();

    if (permissionStatus[Permission.location]!.isGranted &&
        permissionStatus[Permission.camera]!.isGranted) {
      await getPresentLocation();
    } else if (permissionStatus[Permission.location]!.isDenied &&
        permissionStatus[Permission.camera]!.isDenied) {
      openAppSettings();
    } else if (permissionStatus[Permission.location]!.isPermanentlyDenied &&
        permissionStatus[Permission.camera]!.isPermanentlyDenied) {
      // Permissions are denied or permanently denied.
      // You can show an error message or guide the user to enable permissions in settings.
      openAppSettings();
    }
  }

  Future<void> getLocationPermission() async {
    final permissionStatus = await [
      Permission.location,
      Permission.camera,
    ].request();
    ;

    if (permissionStatus[Permission.camera]!.isGranted &&
        permissionStatus[Permission.location]!.isGranted) {
      await getPresentLocation();
    } else if (permissionStatus[Permission.camera]!.isDenied &&
        permissionStatus[Permission.camera]!.isDenied) {
    } else {
      openAppSettings();
    }
  }

//
  Future<void> getPresentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];

        String fullAddress =
            " ${placemark.name}  ${placemark.thoroughfare} ${placemark.subLocality} ${placemark.locality} ${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}";
        setState(() {
          _address = fullAddress;
        });
      } else {}
    } catch (_) {}
  }

  @override
  void initState() {
    super.initState();
    checkPermissions();
    currentDateAndTimeWidget();
    getTheDataFromEmployeeDetails();
  }

  Widget currentDateAndTimeWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Date: $formattedDate',
          style: TextStyle(fontSize: 24),
        ),
        Text(
          'Time: $formattedTime',
          style: TextStyle(fontSize: 24),
        ),
      ],
    );
  }

  Widget _takeABrackWidget(EmployeeData empData) {
    return ValueListenableBuilder(
        valueListenable: _isLoading2,
        builder: (context, value, child) {
          return CButton(
              image: DecorationImage(
                  image: AssetImage(
                    ImageConstants.bgImagePng,
                  ),
                  fit: BoxFit.cover),
              width: getWidth(context),
              onPressed: () async {
                await empData.breakStatus == 1
                    ? dataFromTakeBrakeApi("1")
                    : dataFromTakeBrakeApi("2");
              },
              text: _isLoading2.value
                  ? IsLoadingWidget()
                  : Text(
                      empData.breakStatus == 1
                          ? CStrings.takeBreak
                          : "Resume Work",
                      style: TextStyles.getSubTita16(textColor: cWhiteColor),
                    ));
        });
  }

  Widget _breakeInfoAlort(BuildContext context, EmployeeData empData) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        content: Container(
          width: getWidth(context),
          height: getHeight(context) / 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Breaks info",
                    style: TextStyles.getSubTital20(textColor: cBlackColor),
                  ),
                  CButton(
                      borderColor: Colors.transparent,
                      onPressed: () {
                        Get.back();
                      },
                      text:
                          SvgPicture.asset(ImageConstants.circleCrossIconSvg)),
                ],
              ),
              empData.breakDuration!.isEmpty
                  ? Column(
                      children: [
                        Image.asset(
                          ImageConstants.noDataFoundPng,
                          height: getHeight(context) / 4,
                        ),
                      ],
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: empData.breakDuration?.length ?? 0,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            final brakeData = empData.breakDuration![index];
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                vGap(10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        "Start time: ${brakeData.breakStart ?? ""}"),
                                    Text(
                                        "End time: ${brakeData.breakResume ?? ""}"),
                                    vGap(10),
                                  ],
                                ),
                              ],
                            );
                          }),
                    ),
            ],
          ),
        ));
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  //apis calling ------------------------- ----------------------- -------------
  //employee details api
  getTheDataFromEmployeeDetails() async {
    _isLoading.value = true;
    final userName = Preferences.getUserName();

    try {
      final employeesPayload = {
        "EmployeeDetails": true,
        "employee_id": userName ?? ""
      };
      final _header = {
        'Ver': ApiServices.apiVer,
        "ApiKey": ApiServices.apiKey,
      };
      Response empResponse = await Dio().post(ApiServices.baseUrl,
          data: employeesPayload, options: Options(headers: _header));
      final empResult = EmployeeDetailsRes.fromJson(empResponse.data);
      _isLoading.value = false;
      setState(() {
        _employeeDetailsRes = empResult;
      });
    } catch (e) {
      _isLoading.value = true;
      showErrorMessage(context, "Error occured!!!");
    }
  }

//take a brake Api
  dataFromTakeBrakeApi(type) async {
    _isLoading2.value = true;
    final userName = Preferences.getUserName();

    try {
      final brackPayload = {
        "TakeBreak": true,
        "username": userName ?? "",
        "break_type": type ?? ""
      };
      final _header = {
        'Ver': ApiServices.apiVer,
        "ApiKey": ApiServices.apiKey,
      };
      Response brakeResponse = await Dio().post(ApiServices.baseUrl,
          data: brackPayload, options: Options(headers: _header));
      final brakeResult = TakeBrakeRes.fromJson(brakeResponse.data);
      _isLoading2.value = false;

      if (brakeResult.result == "success" &&
          (brakeResponse.statusCode == 200 ||
              brakeResponse.statusCode == 201)) {
        await getTheDataFromEmployeeDetails();
      }
    } catch (_) {
      showErrorMessage(context, "Error occured!!!");
    }
  }
}
