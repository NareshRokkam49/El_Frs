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

class ResetPasswordScreen extends StatelessWidget {
   ResetPasswordScreen({super.key});
      final TextEditingController _setController=TextEditingController();
            final TextEditingController _confirmController=TextEditingController();

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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: getHeight(context)/3,
                child: Image.asset(ImageConstants.resetIconPng,fit: BoxFit.contain,)),
            ),
       
         Text(CStrings.resetPassword,style: TextStyles.getHeadline28(),),
         vGap(20),
         CWithoutStarTextWidget(text: CStrings.setNewPassword),
         vGap(10),
         newPasswordWidget(),
        CWithoutStarTextWidget(text: CStrings.confirmPassword),
         vGap(10),
         confirmWidget(),
      vGap(20),

   _resetBtn(),
                          vGap((getHeight(context) / 5 * 1) - 30),


          ],
        ),
      ),

    );
  }
   Widget newPasswordWidget() {
    return CTextFormField(
      controller: _setController,
      KeyboardType: TextInputType.emailAddress,
     
      hintText: CStrings.characterCapitalLetter,
      // validator: (v) {
      //   if (v!.isEmpty) {
      //     return CStrings.pleaseEnterNewPassword;
      //   } 
      //   return null;
      // },
    );
  }
    Widget confirmWidget() {
    return CTextFormField(
      controller: _confirmController,
      KeyboardType: TextInputType.emailAddress,
     
      hintText: CStrings.characterCapitalLetter,
      // validator: (v) {
      //   if (v!.isEmpty) {
      //     return CStrings.pleaseEnterconfirmPassword;
      //   } 
      //   return null;
      // },
    );
  }
   
    Widget _resetBtn() {
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
                   Get.offAndToNamed(AppRoutes.loginScreen);
                  }
                },
              
                text: Text(
                        CStrings.resetPassword,
                        style: TextStyles.getSubTital20(
                            ),
                      )),
          );
        });
  }
}