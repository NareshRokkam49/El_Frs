import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

import '../../components/cButton.dart';
import '../../constants/cColors.dart';
import '../../constants/cStrings.dart';
import '../../constants/image_constants.dart';
import '../../resourses/text_styles.dart';
import '../../routes/app_routes.dart';
import '../../utils/display_utils.dart';

class OtpScreenScreen extends StatefulWidget {
   OtpScreenScreen({super.key});

  @override
  State<OtpScreenScreen> createState() => _OtpScreenScreenState();
}

class _OtpScreenScreenState extends State<OtpScreenScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _oTpController = TextEditingController();
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);
  Timer? timer;
  final ValueNotifier<bool> enableResend = ValueNotifier<bool>(false);
  final ValueNotifier<int> secondsRemaining = ValueNotifier<int>(30);
  final ValueNotifier<bool> _visible = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Container(
               width: getWidth(context),
        height: getHeight(context),
          decoration: BoxDecoration(
           
            image: DecorationImage(image: AssetImage(ImageConstants.bgImagePng,),fit: BoxFit.cover),
      
        ),
     
        
        child: Form(
          key: _formkey,
          child: Column(mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
             backButtonWidget(),
                       vGap((getHeight(context) / 20 * 1.2) - 30),

             _otpWidget(context)
              ],
            ),
        ),
          ),
      ),
  
        
    );
  }

  Widget backButtonWidget(){
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: InkWell(
      onTap: () {
          Get.back();
        },
        child: CircleAvatar(
          backgroundColor: cPrimeryColor2,
          child: SvgPicture.asset(ImageConstants.arrowBackIconSvg,))),
    );
  }

    Widget _otpWidget(BuildContext context){
    return Container(
width: getWidth(context),
      decoration: BoxDecoration(
        color: cPrimeryColor2,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(32),topRight: Radius.circular(32)),),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: getHeight(context)/3,
                child: Image.asset(ImageConstants.otpIconPng,fit: BoxFit.contain,)),
            ),
       
         Text(CStrings.otpVerification,style: TextStyles.getHeadline28(),),
          vGap(10),
         Text(CStrings.enterTheOtpCode,style: TextStyles.getSubTita16(),),
         vGap(10),     
         vGap(20),
         _otpFeild(context),
         vGap(15),
        
         _verifyOtpBtn(), vGap(20),_resend(),
                    vGap((getHeight(context) / 6 * 1.2) - 30),

          ],
        ),
      ),

    );
  }

 

    Widget _verifyOtpBtn() {
    return ValueListenableBuilder(
        valueListenable: _isLoading,
        builder: (context, value, child) {
          return Center(
            child: CButton(
                             image: DecorationImage(image: AssetImage(ImageConstants.bgImagePng,),fit: BoxFit.cover),
                width: getWidth(context)/1.2,
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();
                          if (_oTpController.text != "" &&
                              _oTpController.text.length == 4) {
                        //  _oTpController.clear();
                                     Get.toNamed(AppRoutes.resetPasswordScreen);
          
                          } else {
                            showErrorMessage(context, "Please enter 4 digit OTP");
                          }
                        }
                },
              
                text: Text(
                        CStrings.verifyOtp,
                        style: TextStyles.getSubTital20(
                            ),
                      )),
          );
        });
  }

  Widget _otpFeild(BuildContext context) {
    return Center(
      child: SizedBox(
        width: getWidth(context) / 1.4,
        child: PinCodeTextField(
        
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
            LengthLimitingTextInputFormatter(4),
          ],
          appContext: context,
          pastedTextStyle: TextStyle(
            color: cBlackColor,
            fontWeight: FontWeight.normal,
          ),
          length: 4,
          obscureText: false,
          cursorHeight: 17,
          blinkWhenObscuring: true,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            borderWidth: 1,
            shape: PinCodeFieldShape.box,
            activeColor: cTextfeildBdrColor,
            selectedColor: cTextfeildBdrColor,
            selectedFillColor: cTextfeildBdrColor,
             activeFillColor: cPrimeryColor2,
            inactiveFillColor: cPrimeryColor2,
            inactiveColor: cTextfeildBdrColor,
            borderRadius: BorderRadius.circular(12),
            fieldHeight: 15.w,
            fieldWidth: 15.w,
           
          ),
          cursorColor: cBlackColor,
          animationDuration: Duration(milliseconds: 300),
          enableActiveFill: true,
          controller: _oTpController,
          keyboardType: TextInputType.number,
      
       
        ),
      ),
    );
  }

  Widget _resend() {
    return ValueListenableBuilder(
        valueListenable: secondsRemaining,
        builder: (context, value, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                      color: cBlackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  children: [
                    TextSpan(
                      text:CStrings.didntReceiveCode,
                      style: TextStyles.getSubTita14(textColor: cGrayColor3,fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              hGap(10),
              Visibility(
                visible: _visible.value,
                child: InkWell(
                  onTap: () async{
                   _oTpController.clear();
                    _visible.value == true;
                    _onTap();
                    _resendCode();
                    timer = Timer.periodic(Duration(seconds: 30), (_) {
                      if (secondsRemaining.value != 0) {
                        secondsRemaining.value--;
                      } else {
                        setState(() {
                          enableResend.value = true;
                        });
                      }
                    });
                  },
                  child: _visible.value == true
                      ? Text(
                          CStrings.resend,
                          style: TextStyles.getSubTita16(textColor: cblueColor)
                        )
                      : Container(),
                ),
              ),
              vGap(10),
              _visible.value == false
                  ? Center(
                      child: Text(
                        'After ${secondsRemaining.value} seconds',
                        style: TextStyle(color: cRedColor, fontSize: 12),
                      ),
                    )
                  : Container(),
            ],
          );
        });
  }

    _resendCode() {
    secondsRemaining.value = 30;
    enableResend.value = false;
  }
    void _onTap() {
    _visible.value = false;
    Timer(Duration(seconds: 30), () {
      _visible.value = true;
    });
  }
    void initState() {
    super.initState();
    _onTap();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining.value != 0) {
        secondsRemaining.value--;
      } else {
        enableResend.value = true;
      }
    });
  }
}