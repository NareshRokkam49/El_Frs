
import 'package:flutter/material.dart';
import '../../components/cButton.dart';
import '../../constants/cColors.dart';
import '../../constants/cStrings.dart';
import '../../constants/image_constants.dart';
import '../../resourses/text_styles.dart';
import '../../utils/display_utils.dart';

class TypeOfLoginScreen extends StatelessWidget {
   TypeOfLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Container(
        
          decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.topLeft,
          tileMode: TileMode.mirror,
          colors: [
            Color(0xff041DFF),
             Color(0xff5A74FD), 
      
          ],
        ),
        ),
        child: Column(
            children: [
           
           vGap(100),
           _typeLogiNWigget(context)
            ],
          ),
          ),
      ),
  
        
    );
  }


    Widget _typeLogiNWigget(BuildContext context){
    return Container(
width: getWidth(context),
height: getHeight(context),
      decoration: BoxDecoration(
        color: cPrimeryColor2,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(32),topRight: Radius.circular(32)),),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          

         Text(CStrings.letsGetStarted,style: TextStyles.getSubTital24(),),
                  Text(CStrings.howDoYouWantLogin,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.getSubTita16(),),

         vGap(40),
     

   _manegerBtn(context),
    vGap(24),
          _employeeWidget(context),

          ],
        ),
      ),

    );
  }

   Widget _employeeWidget(BuildContext context) {
  return  CButton(
    borderRadius: 24,
    color: cblueColor2,
             height: getHeight(context)/5,
              width: getWidth(context),
              onPressed: () async {
             
              },
            
              text: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(ImageConstants.empoyeeIconPng,scale: 3,),
                   vGap(20),  Text(
                          CStrings.employee,
                          style: TextStyles.getSubTital20(
                              ),
                        ),
                ],
              ));
  }
    Widget _manegerBtn(BuildContext context) {
    return  CButton(
          borderRadius: 24,

      color: cblueColor2,
             height: getHeight(context)/5,
              width: getWidth(context),
              onPressed: () async {
             
              },
            
              text: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(ImageConstants.managerIconPng,scale: 3,),
                  vGap(20),
                  Text(
                          CStrings.manager,
                          style: TextStyles.getSubTital20(
                              ),
                        ),
                ],
              ));
      
  }
}