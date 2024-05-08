import 'package:entrolabs_attadance/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../components/cButton.dart';
import '../../components/cTextFormFeild.dart';
import '../../components/withOut_star_text_widget.dart';
import '../../constants/cColors.dart';
import '../../constants/cStrings.dart';
import '../../constants/image_constants.dart';
import '../../resourses/text_styles.dart';
import '../../utils/display_utils.dart';

class ForgotPasswordScreen extends StatelessWidget {
   ForgotPasswordScreen({super.key});
      final TextEditingController _userController=TextEditingController();
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
            image: DecorationImage(image: AssetImage(ImageConstants.bgImagePng,),fit: BoxFit.cover),
      
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
          backButtonWidget(),
           vGap((getHeight(context) / 20 * 1.2) - 30),
             _forgotWidget(context)
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
    Widget _forgotWidget(BuildContext context){
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
                child: Image.asset(ImageConstants.forgotPasswordIconPng,fit: BoxFit.contain,)),
            ),
       
         Text(CStrings.forgotPassword,style: TextStyles.getHeadline28(),),
         vGap(10),
                  Text(CStrings.enterRegisteredMobilenumber,style: TextStyles.getSubTita16(),),
vGap(20),
         CWithoutStarTextWidget(text: CStrings.mobileNumberEmail),
         vGap(10),
         userIdWidget(),
      
      vGap(20),

   _forgotBtn(),
           vGap((getHeight(context) / 5 * 1.2) - 30),

          ],
        ),
      ),

    );
  }
   Widget userIdWidget() {
    return CTextFormField(
      controller: _userController,
      KeyboardType: TextInputType.emailAddress,
     
      hintText: CStrings.mobileNumberEmail,
      // validator: (v) {
      //   if (v!.isEmpty) {
      //     return CStrings.pleaseEntermobileNumberEmail;
      //   } 
      //   return null;
      // },
    );
  }
   
   
    Widget _forgotBtn() {
    return ValueListenableBuilder(
        valueListenable: _isLoading,
        builder: (context, value, child) {
          return Center(
            child: CButton(
               image: DecorationImage(image: AssetImage(ImageConstants.bgImagePng,),fit: BoxFit.cover),
                width: getWidth(context)/1.2,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                   Get.toNamed(AppRoutes.otpScreen);
                  }
                },
              
                text: Text(
                        CStrings.getOtp,
                        style: TextStyles.getSubTital20(
                            ),
                      )),
          );
        });
  }
}