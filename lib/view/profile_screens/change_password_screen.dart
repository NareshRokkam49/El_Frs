import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../components/cButton.dart';
import '../../components/cTextFormFeild.dart';
import '../../components/withOut_star_text_widget.dart';
import '../../constants/cColors.dart';
import '../../constants/cStrings.dart';
import '../../constants/image_constants.dart';
import '../../resourses/text_styles.dart';
import '../../utils/display_utils.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final TextEditingController _setController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //background: var(--gradiant-blue-2, linear-gradient(122deg, #3EF2FE -39.38%, #5A74FD 53.86%, #041DFF 129.19%));
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        elevation: 0,
        leading: backButtonWidget(),
        title: Text(
          CStrings.changePassword,
          style: TextStyles.getSubTita16(
              textColor: cWhiteColor, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Container(
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
            children: [vGap(130), _cardWidget(context)],
          ),
        ),
      ),
    );
  }

  Widget backButtonWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
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

  Widget _cardWidget(BuildContext context) {
    return Expanded(
      child: Container(
        width: getWidth(context),
        height: getHeight(context),
        decoration: BoxDecoration(
          color: cPrimeryColor2,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vGap(20),
              CWithoutStarTextWidget(text: CStrings.newPassword),
              vGap(10),
              newPasswordWidget(),
              vGap(20),
              CWithoutStarTextWidget(text: CStrings.confirmPassword),
              vGap(10),
              confirmWidget(),
              vGap(20),
              _changePswdBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget newPasswordWidget() {
    return CTextFormField(
      controller: _setController,
      KeyboardType: TextInputType.emailAddress,
      hintText: CStrings.characterCapitalLetter,
      validator: (v) {
        if (v!.isEmpty) {
          return CStrings.pleaseEnterNewPassword;
        }
        return null;
      },
    );
  }

  Widget confirmWidget() {
    return CTextFormField(
      controller: _confirmController,
      KeyboardType: TextInputType.emailAddress,
      hintText: CStrings.characterCapitalLetter,
      validator: (v) {
        if (v!.isEmpty) {
          return CStrings.pleaseEnterconfirmPassword;
        }
        return null;
      },
    );
  }

  Widget _changePswdBtn() {
    return ValueListenableBuilder(
        valueListenable: _isLoading,
        builder: (context, value, child) {
          return CButton(
              image: DecorationImage(
                  image: AssetImage(ImageConstants.bgImagePng),
                  fit: BoxFit.cover),
              width: getWidth(context),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  //  Get.toNamed(AppRoutes.otpScreen);
                }
              },
              text: Text(
                CStrings.changePassword,
                style: TextStyles.getSubTital20(),
              ));
        });
  }
}
