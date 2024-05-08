import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:entrolabs_attadance/components/cButton.dart';
import 'package:entrolabs_attadance/components/cTextFormFeild.dart';
import 'package:entrolabs_attadance/components/is_loading_widget.dart';
import 'package:entrolabs_attadance/constants/cColors.dart';
import 'package:entrolabs_attadance/constants/cStrings.dart';
import 'package:entrolabs_attadance/constants/image_constants.dart';
import 'package:entrolabs_attadance/modals/res/edit_profile_res.dart';
import 'package:entrolabs_attadance/modals/res/image_uploading_res.dart';
import 'package:entrolabs_attadance/modals/res/profile_data_res.dart';
import 'package:entrolabs_attadance/modals/services/api_services.dart';
import 'package:entrolabs_attadance/utils/local_storage_dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Response, MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../components/custom_shape.dart';
import '../../components/progress_indicater_widget.dart';
import '../../components/withOut_star_text_widget.dart';
import '../../resourses/text_styles.dart';
import '../../utils/display_utils.dart';
import '../../utils/reg_exp.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _desinationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  ImageUploadingRes? _imageUploadingRes;
  XFile? imageFile;
//String? _profile;
  String? userPref;
  final ProfileDataRes profileData = Get.arguments ?? ProfileDataRes();
  String? _profile = Preferences.getProfile();
    String? _profilePath = Preferences.getProfilePath();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: titleWidget(),
        leading: backButtonWidget(),
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
       body: Form(
        key: _formKey,
         child: Stack(
          clipBehavior: Clip.none,
          children: [
             SingleChildScrollView(
               child: profileData == ""
                ? CProgressIndicaterWidget(color: cblueColor,)
                : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                vGap(10),
                profileWidget(context),
                divider(),
                profileItems(context),
                vGap(25),
                saveChangesBtn(context),
              //  vGap((getHeight(context) / 10 * 1.5) - 20),
                    ],
                  ),
                ),
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

  Widget titleWidget() {
    return Text(
      CStrings.editProfile,
      style: TextStyles.getSubTital20(
          textColor: cWhiteColor, fontWeight: FontWeight.w500),
    );
  }

  Widget profileWidget(BuildContext context) {
    return Column(
      children: [
        vGap(20),
        Stack(clipBehavior: Clip.none, children: [
          imageFile != null
              ? CircleAvatar(
                  radius: getWidth(context) / 4.8,
                  backgroundImage: FileImage(File(imageFile?.path ?? "")),
                  backgroundColor: cBgColor2,
                )
              : CachedNetworkImage(
                  imageUrl: _profile.toString(),
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: getWidth(context) / 2.2,
                      height: (getHeight(context) / 6 * 1.2) - 10,
                      decoration: BoxDecoration(
                        color: cRedColor,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    );
                  },
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CProgressIndicaterWidget(),
                  errorWidget: (context, url, error) => CircleAvatar(
                    radius: getWidth(context) / 4.8,
                    backgroundImage: AssetImage(ImageConstants.empoyeeIconPng),
                  ),
                ),
          Positioned(
              right: 11,
              bottom: 3,
              child: InkWell(
                onTap: () {
                  _bottomSheet(context);
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: cWhiteColor,
                  child: CircleAvatar(
                      radius: 18,
                      backgroundColor: cblueColor,
                      child: SvgPicture.asset(
                        ImageConstants.cemaraIconSvg,
                        width: 25,
                      )),
                ),
              ))
        ])
      ],
    );
  }

  void _bottomSheet(context) {
    showModalBottomSheet(
        useSafeArea: true,
        backgroundColor: cWhiteColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        context: context,
        builder: (BuildContext bc) {
          return SizedBox(
            height: 250,
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
                      color: cBgColor2,
                    ),
                  ),
                  vGap(10),
                  Text(
                    CStrings.uploadImage,
                    style: TextStyles.getSubTita16(textColor: cblueColor),
                  ),
                  vGap(40),
                  Column(
                    children: [
                      CupertinoButton(
                          onPressed: () {
                            selectImage(ImageSource.camera);
                            Get.back();
                          },
                          child: Text(
                            CStrings.chooseCamera,
                            style:
                                TextStyles.getSubTita16(textColor: cblueColor),
                          )),
                      vGap(5),
                      CupertinoButton(
                          onPressed: () {
                            selectImage(ImageSource.gallery);

                            Get.back();
                          },
                          child: Text(
                            CStrings.chooseFromGallery,
                            style:
                                TextStyles.getSubTita16(textColor: cblueColor),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void selectImage(ImageSource source) async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
        source: source,
        imageQuality: 10,
      );
      if (pickedFile != null) {
        setState(() {
          imageFile = pickedFile;
          dataFromImageUploadingApi(pickedFile);
        });
      }
    } on DioException catch (_) {}
  }

  Widget saveChangesBtn(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _isLoading,
        builder: (context, value, child) {
          return CButton(
            image: DecorationImage(
                image: AssetImage(
                  ImageConstants.bgImagePng,
                ),
                fit: BoxFit.cover),
            width: getWidth(context) / 1.2,
            text: _isLoading.value
                ? IsLoadingWidget()
                : Text(
                    CStrings.saveChanges,
                    style: TextStyles.getSubTital20(),
                  ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                await dataFromEditProfileApi();
              }
            },
          );
        });
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
        CWithoutStarTextWidget(
          text: CStrings.name,
          style: TextStyles.getSubTita14(textColor: cBlackColor),
        ),
        vGap(5),
        CTextFormField(
          controller: _nameController,
          validator: (v) {
            if (v!.isEmpty) {
              return CStrings.pleaseEnterName;
            }
            return null;
          },
          hintText: CStrings.name,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[A-Z,a-z ,.]*"))
          ],
        ),
        vGap(10),
        CWithoutStarTextWidget(
          text: CStrings.designation,
          style: TextStyles.getSubTita14(textColor: cBlackColor),
        ),
        vGap(5),
        CTextFormField(
          controller: _desinationController,
          validator: (v) {
            if (v!.isEmpty) {
              return CStrings.pleaseEnterDesignation;
            }
            return null;
          },
          hintText: CStrings.designation,
        ),
        vGap(10),
        CWithoutStarTextWidget(
          text: CStrings.mobileNumber,
          style: TextStyles.getSubTita14(textColor: cBlackColor),
        ),
        vGap(5),
        CTextFormField(
          controller: _phoneController,
          KeyboardType: TextInputType.number,
          validator: (v) {
            if (v!.isEmpty) {
              return CStrings.pleaseEnterMobileNumber;
            } else if (!checkNumberValidation(v)) {
              return CStrings.pleaseEnterValidMobileNumber;
            }
            return null;
          },
          hintText: CStrings.mobileNumber,
        ),
        vGap(10),
        CWithoutStarTextWidget(
          text: CStrings.email,
          style: TextStyles.getSubTita14(textColor: cBlackColor),
        ),
        vGap(5),
        CTextFormField(
          controller: _emailController,
          validator: (v) {
            if (v!.isEmpty) {
              return CStrings.pleaseEnterEmail;
            } else if (!checkEmailValidation(v)) {
              return CStrings.pleaseEnterValidEmail;
            }
            return null;
          },
          hintText: CStrings.email,
        ),
      ],
    );
  }

//apis  calling -------------- - ----------------------- ------------------ ------------
// edit profile api
  dataFromEditProfileApi() async {
    _isLoading.value = true;
         final userName =Preferences.getUserName();

    try {
      final editPayload = {
        "edit_profile": true,
        "username":userName??"",
        "name": _nameController.text,
        "email": _emailController.text,
        "designation": _desinationController.text,
        "mobile": _phoneController.text,
        "image": _imageUploadingRes?.filename ?? _profilePath,
      };
      
      final headerData = {
        'Ver': ApiServices.apiVer,
        "ApiKey": ApiServices.apiKey,
      };
      Response fileResponse = await Dio().post(ApiServices.baseUrl,
          data: editPayload, options: Options(headers: headerData));
      final fileResult = EditProfileRes.fromJson(fileResponse.data);
      _isLoading.value = false;
      if (fileResult.result == "success" &&
          (fileResponse.statusCode == 200 || fileResponse.statusCode == 201)) {
        showSuccessMessage(context, "Profile updated successfully!!!");
        Get.back();
      }
    } catch (_) {
        showErrorMessage(context, "Error occured!!!");

    }
  }

  @override
  void initState() {
    getProfileDate();
    checkPermissions();
    super.initState();
  }

  getProfileDate() {
    _nameController.text =profileData.name==""?"": "${profileData.name![0].toUpperCase()}"+"${profileData.name!.substring(1)}" ;
    _emailController.text = profileData.email ?? "";
    _phoneController.text = profileData.mobile ?? "";
    _desinationController.text = profileData.designation ?? "";
  }
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
//uploading image
  dataFromImageUploadingApi(XFile args) async {
     final userName =Preferences.getUserName();
    try {
      List<MultipartFile> files = [];
      files.add(await MultipartFile.fromFile((args.path)));
      File file = File(args.path);
      String fileName = file.toString().split("/").last;
      if (fileName.contains('scaled_')) {
        fileName = fileName.replaceAll("scaled_", "");
      }

      final formData = FormData.fromMap({
        "uploadImage": true,
        "username": userName??"",
        "filename": fileName,
        "file": files,
      });
 
      final headerData = {
        'Ver': ApiServices.apiVer,
        "ApiKey": ApiServices.apiKey,
      };
      Response imageResponce = await Dio().post(ApiServices.baseUrl,
          data: formData, options: Options(headers: headerData));
      final imageResult = ImageUploadingRes.fromJson(imageResponce.data);
      setState(() {
        _imageUploadingRes = imageResult;
      });

    }  catch (_) {
  showErrorMessage(context, "Error occured!!!");

    }
  }
}
