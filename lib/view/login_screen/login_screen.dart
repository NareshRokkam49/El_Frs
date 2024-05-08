import 'package:dio/dio.dart';
import 'package:entrolabs_attadance/modals/res/login_res.dart';
import 'package:entrolabs_attadance/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Response;
import 'package:permission_handler/permission_handler.dart';
import '../../components/cButton.dart';
import '../../components/cTextFormFeild.dart';
import '../../components/is_loading_widget.dart';
import '../../components/withOut_star_text_widget.dart';
import '../../constants/cColors.dart';
import '../../constants/cStrings.dart';
import '../../constants/image_constants.dart';
import '../../modals/services/api_services.dart';
import '../../resourses/text_styles.dart';
import '../../utils/display_utils.dart';
import '../../utils/local_storage_dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: getWidth(context),
          height: getHeight(context),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  ImageConstants.bgImagePng,
                ),
                fit: BoxFit.cover),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _attendanceText(),
                vGap((getHeight(context) / 20 * 1.2) - 30),
                _loginWidget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _attendanceText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          SvgPicture.asset(ImageConstants.latterSvg),
          hGap(5),
          Text(
            CStrings.attendanceApp,
            style: TextStyles.getSubTital20(),
          ),
        ],
      ),
    );
  }

  Widget _loginWidget(BuildContext context) {
    return Container(
      width: getWidth(context),
      decoration: BoxDecoration(
        color: cPrimeryColor2,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32), topRight: Radius.circular(32)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                  height: getHeight(context) / 3,
                  child: Image.asset(
                    ImageConstants.loginLogoPng,
                    fit: BoxFit.contain,
                  )),
            ),
            hGap(5),
            Text(
              CStrings.login,
              style: TextStyles.getHeadline28(),
            ),
            vGap(10),
            CWithoutStarTextWidget(
              text: CStrings.userId,
            ),
            vGap(10),
            userIdWidget(),
            vGap(10),
            CWithoutStarTextWidget(
              text: CStrings.password,
            ),
            vGap(10),
            passwordWidget(),
            _forgotPassword(),
            vGap(20),
            _loginBtn(),
            vGap((getHeight(context) / 10 * 1.2) - 30),
          ],
        ),
      ),
    );
  }

  Widget userIdWidget() {
    return CTextFormField(
      controller: _userController,
      KeyboardType: TextInputType.emailAddress,
      hintText: CStrings.userId,
      validator: (v) {
        if (v!.isEmpty) {
          return CStrings.pleaseEnterUserId;
        }
        return null;
      },
    );
  }

  Widget passwordWidget() {
    return CTextFormField(
      controller: _passwordController,
      KeyboardType: TextInputType.emailAddress,
      hintText: CStrings.password,
      validator: (v) {
        if (v!.isEmpty) {
          return CStrings.pleaseEnterPassword;
        }
        return null;
      },
    );
  }

  Widget _forgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: CButton(
        height: 40,
        contentPadding: EdgeInsets.all(0),
        onPressed: () {
          Get.toNamed(AppRoutes.forgotPasswordScreen);
        },
        color: Colors.transparent,
        text: Text(
          CStrings.forgotPassword,
          textAlign: TextAlign.end,
          style: TextStyles.getSubTital20(
              fontSize: 15, fontWeight: FontWeight.w400, textColor: cblueColor),
        ),
      ),
    );
  }

  Widget _loginBtn() {
    return ValueListenableBuilder(
        valueListenable: _isLoading,
        builder: (context, value, child) {
          return Center(
            child: CButton(
                image: DecorationImage(
                    image: AssetImage(
                      ImageConstants.bgImagePng,
                    ),
                    fit: BoxFit.cover),
                width: getWidth(context) / 1.2,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                       await  dataFromLoginApi(context);
                       _userController.clear();
                       _passwordController.clear();
                  }
                },
                text:_isLoading.value?
                IsLoadingWidget():
                 Text(
                  CStrings.login,
                  style: TextStyles.getSubTital20(),
                )),
          );
        });
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

  //apis calling -----------------------------    --------------------------
  dataFromLoginApi(BuildContext context) async {
    _isLoading.value=true;
    try {
      final loginPayload = {
        "login": true,
        "username": _userController.text.toUpperCase(),
        "password": _passwordController.text
      };
        final _header = {
        'Ver': ApiServices.apiVer,
        "ApiKey": ApiServices.apiKey,
      };
      Response loginResponse = await Dio().post(ApiServices.baseUrl,
          data: loginPayload, options: Options(headers: _header));
      final loginResult = LoginRes.fromJson(loginResponse.data);
      _isLoading.value = false;
      if (loginResult.result == "success" &&
          (loginResponse.statusCode == 200 ||
              loginResponse.statusCode == 201)) {
             showSuccessMessage(context, "User Successfully Logged");
              Preferences.setUserName( await loginResult.username ?? "");
              Preferences.setPhone(await loginResult.mobile??"");
              Preferences.setEmpId(await loginResult.employeeId??"");
              Preferences.setProfile(await loginResult.employeeProfile??"");
              Preferences.setName(await loginResult.name??"");

         await   Get.offAndToNamed(AppRoutes.btmNavigationScreen);

      }else {
        showErrorMessage(context, loginResult.error??"");
      }
    }on DioException catch (_) {
  showErrorMessage(context, "Error occured!!!");
      _isLoading.value = false;    }
  }
  @override
  void initState() {
checkPermissions();
    super.initState();
  }
}
