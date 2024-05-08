import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:entrolabs_attadance/constants/cColors.dart';
import 'package:entrolabs_attadance/constants/cStrings.dart';
import 'package:entrolabs_attadance/constants/image_constants.dart';
import 'package:entrolabs_attadance/modals/res/profile_data_res.dart';
import 'package:entrolabs_attadance/utils/local_storage_dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Response;
import 'package:sizer/sizer.dart';

import '../../../../utils/display_utils.dart';
import '../../components/cButton.dart';
import '../../components/progress_indicater_widget.dart';
import '../../modals/services/api_services.dart';
import '../../resourses/text_styles.dart';
import '../../routes/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  ProfileDataRes? _profileDataRes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cPrimeryColor2,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 90,
        elevation: 0,
        leading: backButtonWidget(),
        title: Text(
          "Profile",
          style: TextStyles.getSubTita16(
              textColor: cWhiteColor, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: getHeight(context),
        width: getWidth(context),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                ImageConstants.bgImagePng,
              ),
              fit: BoxFit.cover),
        ),
        child: _profileDataRes == null
            ? CProgressIndicaterWidget()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    vGap((getHeight(context) / 7 * 1.5) - 40),
                    Container(
                      width: getWidth(context),
                      decoration: BoxDecoration(
                          color: cPrimeryColor2,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            profileWidget(context),
                            divider(),
                            profileItems(context),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
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

  Widget profileWidget(BuildContext context) {
    return Column(
      children: [
        vGap(getHeight(context) / 40),
        Row(
          children: [
            _profileDataRes?.employeeProfile != ""
                ? CachedNetworkImage(
                    imageUrl: _profileDataRes?.employeeProfile ?? "",
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        width: getWidth(context) / 6,
                        height: (getHeight(context) / 10 * 1.2) - 10,
                        decoration: BoxDecoration(
                          color: cBgColor2,
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
                      radius: 30,
                      backgroundImage: AssetImage(
                        ImageConstants.empoyeeIconPng,
                      ),
                    ),
                  )
                : CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                      ImageConstants.empoyeeIconPng,
                    ),
                  ),
            hGap(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _profileDataRes?.name == "" || _profileDataRes?.name == null
                      ? ""
                      : "${_profileDataRes?.name![0].toUpperCase()}" +
                          "${_profileDataRes!.name!.substring(1)}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  _profileDataRes?.designation == "" ||
                          _profileDataRes?.designation == null
                      ? ""
                      : "${_profileDataRes?.designation![0].toUpperCase()}" +
                          "${_profileDataRes!.designation!.substring(1)}",
                  style: TextStyles.getSubTita15(textColor: cblueColor),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget divider() {
    return Divider(
      color: cGrayColor,
      endIndent: 10,
      indent: 10,
    );
  }

  Widget profileItems(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        vGap(10),
        Text(
          "Account Settings",
          style: TextStyles.getSubTita16(textColor: cGrayColor4),
        ),
        ListTile(
          onTap: () {
            Get.toNamed(AppRoutes.editProfileScreen,
                    arguments: _profileDataRes)!
                .then((value) => dataFromProfileApi());
          },
          title: Text(
            "Edit Profile",
            style: TextStyles.getSubTita15(textColor: cBlackColor),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: cBlackColor,
          ),
        ),
        ListTile(
          onTap: () {
            Get.toNamed(AppRoutes.changePasswordScreen);
          },
          title: Text(
            CStrings.changePassword,
            style: TextStyles.getSubTita15(textColor: cBlackColor),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: cBlackColor,
          ),
        ),
        ListTile(
          title: Text(
            CStrings.privacyPolicy,
            style: TextStyles.getSubTita15(textColor: cBlackColor),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: cBlackColor,
          ),
        ),
        vGap(10),
        Text(
          CStrings.other,
          style: TextStyles.getSubTita15(textColor: cGrayColor4),
        ),
        ListTile(
          onTap: () {
            showDialog(
                useSafeArea: true,
                barrierDismissible: false,
                context: context,
                builder: (context) => Center(
                      child: _alortBox(context),
                    ));
          },
          title: Text(
            CStrings.logout,
            style: TextStyles.getSubTita15(textColor: cBlackColor),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: cBlackColor,
          ),
        ),
        vGap(getHeight(context) / 2.5)
      ],
    );
  }

  Widget _alortBox(BuildContext context) {
    return AlertDialog(
        insetPadding: EdgeInsets.all(15),
        buttonPadding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                CStrings.logout,
                style: TextStyles.getHeadline28(
                    fontSize: 20, textColor: cBlackColor),
              ),
            ),
            vGap(15),
            Text(
              "Are you sure want to logout?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            vGap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                vGap(2.h),
                CButton(
                    border: Border.all(color: cblueColor),
                    height: 40,
                    width: getWidth(context) / 4,
                    color: cWhiteColor,
                    borderRadius: 25,
                    text: Text(
                      CStrings.cancel,
                      style: TextStyle(
                          color: cblueColor,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                    onPressed: () async {
                      Get.back();
                    }),
                hGap(10),
                CButton(
                  border: Border.all(color: cblueColor),
                  color: cWhiteColor,
                  height: 40,
                  width: getWidth(context) / 4,
                  borderRadius: 25,
                  text: Text(
                    CStrings.ok,
                    style: TextStyle(
                        color: cblueColor,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                  onPressed: () async {
                    await dataClear();
                  },
                ),
              ],
            ),
          ],
        ));
  }
//apis calling --------------- ------------------ ------------------- --------------------------

  //profile Api
  dataFromProfileApi() async {
    final userName = Preferences.getUserName();
    try {
      final profilePayload = {
        "getProfileData": true,
        "username": userName ?? ""
      };
      final _header = {
        'Ver': ApiServices.apiVer,
        "ApiKey": ApiServices.apiKey,
      };

      Response fileResponse = await Dio().post(ApiServices.baseUrl,
          data: profilePayload, options: Options(headers: _header));
      final fileResult = ProfileDataRes.fromJson(fileResponse.data);
      _isLoading.value = false;
      setState(() {
        _profileDataRes = fileResult;
      });
      if (fileResult.result == "success" &&
          (fileResponse.statusCode == 200 || fileResponse.statusCode == 201)) {
        Preferences.setProfile(await fileResult.employeeProfile ?? "");
        Preferences.setProfilePath(await fileResult.employeeProfilePath ?? "");
      }
    } catch (_) {
      showErrorMessage(context, "Error occured!!!");
    }
  }

  Future<void> dataClear() async {
    await Preferences.clearPreference();
    await Get.offAllNamed(AppRoutes.loginScreen);
  }

  @override
  void initState() {
    dataFromProfileApi();
    super.initState();
  }
}
