import 'package:entrolabs_attadance/utils/local_storage_dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../components/cButton.dart';
import '../../components/cTextFormFeild.dart';
import '../../components/withOut_star_text_widget.dart';
import '../../constants/cColors.dart';
import '../../constants/cStrings.dart';
import '../../constants/image_constants.dart';
import '../../resourses/text_styles.dart';
import '../../utils/display_utils.dart';

class FrsIntegrationScreen extends StatefulWidget {
  FrsIntegrationScreen({super.key});

  @override
  State<FrsIntegrationScreen> createState() => _FrsIntegrationScreenState();
}

class _FrsIntegrationScreenState extends State<FrsIntegrationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _empController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);
  final _formKey = GlobalKey<FormState>();
  final userName = Preferences.getUserName();
  final mobileNumber = Preferences.getPhone();
  final empId = Preferences.getEmpId();
  final name=Preferences.getName();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
        
          width: getWidth(context),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(ImageConstants.bgImagePng),fit: BoxFit.cover),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                vGap(100),
                _attendanceText(),
                vGap(20),
                _frsWidget(context)
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

  Widget _frsWidget(BuildContext context) {
    return Container(
      width: getWidth(context),
      height: getHeight(context),
      decoration: BoxDecoration(
        color: cPrimeryColor2,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32), topRight: Radius.circular(32)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              CStrings.frsIntegration,
              style: TextStyles.getHeadline28(),
            ),
            vGap(20),
            CWithoutStarTextWidget(
              text: CStrings.name,
            ),
            vGap(10),
            nameWidget(),
            vGap(10),
            CWithoutStarTextWidget(
              text: CStrings.employeeId,
            ),
            vGap(5),
            employeeWidget(),
            CWithoutStarTextWidget(
              text: CStrings.mobileNumber,
            ),
            vGap(5),
            mobileWidget(),
            vGap(20),
            _loginBtn(),
          ],
        ),
      ),
    );
  }

  Widget nameWidget() {
    return CTextFormField(
      controller: _nameController,
      hintstyle: TextStyle(color: cBlackColor),
      labelStyle: TextStyle(color: cBlackColor),
      fillcolor: cPrimeryColor2,
      isfilled: true,
      KeyboardType: TextInputType.emailAddress,
      hintText: CStrings.name,
      validator: (v) {
        if (v!.isEmpty) {
          return CStrings.pleaseEnterName;
        }
        return null;
      },
    );
  }

  Widget employeeWidget() {
    return AbsorbPointer(
      absorbing: true,
      child: CTextFormField(
        fillcolor: cTextfeildBdrColor,
        isfilled: true,
        controller: _empController,
        hintstyle: TextStyle(color: cBlackColor),
        labelStyle: TextStyle(color: cBlackColor),
        KeyboardType: TextInputType.emailAddress,
        hintText: CStrings.employeeId,
        validator: (v) {
          if (v!.isEmpty) {
            return CStrings.pleaseEnteremployeeId;
          }
          return null;
        },
      ),
    );
  }

  Widget mobileWidget() {
    return CTextFormField(
textCapitalization: TextCapitalization.words,
      fillcolor: cPrimeryColor2,
      isfilled: true,
      controller: _mobileController,
      KeyboardType: TextInputType.number,
      hintstyle: TextStyle(color: cBlackColor),
      labelStyle: TextStyle(color: cBlackColor),
      hintText: CStrings.mobileNumber,
      validator: (v) {
        if (v!.isEmpty) {
          return CStrings.pleaseEnterMobileNumber;
        }
        return null;
      },
    );
  }

  Widget _loginBtn() {
    return ValueListenableBuilder(
        valueListenable: _isLoading,
        builder: (context, value, child) {
          return CButton(
              width: getWidth(context),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                }
              },
              text: Text(
                CStrings.submit,
                style: TextStyles.getSubTital20(),
              ));
        });
  }

  getTheDataFromPref(){
    _empController.text=empId??"";
   _nameController.text=name==""?"":"${name![0].toUpperCase()}"+"${name!.substring(1)}";
   _mobileController.text=mobileNumber??"";
  }
  @override
  void initState() {
    getTheDataFromPref();
    super.initState();
  }
}
