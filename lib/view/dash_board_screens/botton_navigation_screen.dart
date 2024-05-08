import 'package:entrolabs_attadance/components/cButton.dart';
import 'package:entrolabs_attadance/constants/cColors.dart';
import 'package:entrolabs_attadance/view/dash_board_screens/attandance_screen.dart';
import 'package:entrolabs_attadance/view/dash_board_screens/leaves_screen.dart';
import 'package:entrolabs_attadance/view/dash_board_screens/work_log_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../resourses/text_styles.dart';
import '../../../utils/display_utils.dart';
import '../../constants/cStrings.dart';
import '../../constants/image_constants.dart';
import 'home_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  BottomNavigationScreen({Key? key, this.tabIndexId}) : super(key: key);

  final tabIndexId;
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

int selectedBottomIndex = 0;
List<Widget> _widgetOptions = [
  HomeScreen(),
  AttandanceScreen(),
  LeavesScreen(),
  WorkLogScreen(),
];

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => willpopAlert(context),
        child: _widgetOptions.elementAt(tabIndexs),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: cTextfeildBdrColor,
        selectedItemColor: cBlackColor,
        selectedLabelStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        onTap: _onItemTapped,
        currentIndex: tabIndexs,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 10.sp,
        unselectedFontSize: 10.sp,
        iconSize: 40,
        type: BottomNavigationBarType.fixed,
        backgroundColor: cblueColor2,
        elevation: 0,
        items: [
          _bottomNavigationBarItem(icon: homes(0), label: ''),
          _bottomNavigationBarItem(icon: attandance(1), label: ''),
          _bottomNavigationBarItem(icon: leaves(2), label: ""),
          _bottomNavigationBarItem(icon: workouts(3), label: ''),
        ],
      ),
    );
  }

  _bottomNavigationBarItem({required icon, String? label, Color? labelColor}) {
    return BottomNavigationBarItem(
      icon: icon,
      label: label,
      backgroundColor: labelColor,
    );
  }

  Container homes(int index) => Container(
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: tabIndexs == 0 ? cPrimeryColor2 : Colors.transparent,
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(16), right: Radius.circular(16))),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                child: SvgPicture.asset(
                  ImageConstants.homeIconSvg,
                  colorFilter: ColorFilter.mode(
                      tabIndexs == 0 ? cBlackColor : cTextfeildBdrColor,
                      BlendMode.srcIn),
                  height: tabIndexs == 0 ? 28 : 24,
                ),
              ),
              vGap(3),
              Text(
                CStrings.home,
                style: TextStyles.getSubTita14(
                    fontWeight: FontWeight.w600,
                    textColor:
                        tabIndexs == 0 ? cPrimeryColor2 : cTextfeildBdrColor),
              )
            ],
          ),
        ),
      );

  Container attandance(int index) => Container(
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: tabIndexs == 1 ? cPrimeryColor2 : Colors.transparent,
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(16), right: Radius.circular(16))),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                child: SvgPicture.asset(
                  ImageConstants.attendanceIconSvg,
                  colorFilter: ColorFilter.mode(
                      tabIndexs == 1 ? cBlackColor : cTextfeildBdrColor,
                      BlendMode.srcIn),
                  height: tabIndexs == 1 ? 28 : 24,
                ),
              ),
              vGap(3),
              Text(
                CStrings.attendance,
                style: TextStyles.getSubTita14(
                    fontWeight: FontWeight.w600,
                    textColor:
                        tabIndexs == 1 ? cPrimeryColor2 : cTextfeildBdrColor),
              )
            ],
          ),
        ),
      );
  Container leaves(int index) => Container(
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: tabIndexs == 2 ? cPrimeryColor2 : Colors.transparent,
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(25), right: Radius.circular(25))),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: SvgPicture.asset(
                  ImageConstants.leavesIconSvg,
                  colorFilter: ColorFilter.mode(
                      tabIndexs == 2 ? cBlackColor : cTextfeildBdrColor,
                      BlendMode.srcIn),
                  height: tabIndexs == 2 ? 28 : 24,
                ),
              ),
              vGap(3),
              Text(
                CStrings.leaves,
                style: TextStyles.getSubTita14(
                    fontWeight: FontWeight.w600,
                    textColor:
                        tabIndexs == 2 ? cPrimeryColor2 : cTextfeildBdrColor),
              )
            ],
          ),
        ),
      );
  Container workouts(int index) => Container(
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: tabIndexs == 3 ? cPrimeryColor2 : Colors.transparent,
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(16), right: Radius.circular(16))),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                child: SvgPicture.asset(
                  ImageConstants.workLogIconSvg,
                  colorFilter: ColorFilter.mode(
                      tabIndexs == 3 ? cBlackColor : cTextfeildBdrColor,
                      BlendMode.srcIn),
                  height: tabIndexs == 3 ? 28 : 24,
                ),
              ),
              vGap(3),
              Text(
                CStrings.workLogs,
                style: TextStyles.getSubTita14(
                    fontWeight: FontWeight.w600,
                    textColor:
                        tabIndexs == 3 ? cPrimeryColor2 : cTextfeildBdrColor),
              )
            ],
          ),
        ),
      );
  static willpopAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
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
                    CStrings.exit,
                    style: TextStyles.getHeadline28(
                        fontSize: 20, textColor: cBlackColor),
                  ),
                ),
                vGap(15),
                Text(
                  CStrings.areYouSureWant,
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
                         borderColor: cblueColor,
                     color: cWhiteColor,
                        height: 35,
                        width: getWidth(context) / 4,
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
                      borderColor: cblueColor,
                     color: cWhiteColor,
                      height: 35,
                      width: getWidth(context) / 4,
                      borderRadius: 25,
                      text: Text(
                        CStrings.ok,
                        style: TextStyle(
                            color: cblueColor,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                      onPressed: () {
                        SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                      },
                    ),
                  ],
                ),
              ],
            ));
      },
    );
  }

  void checkBottomIndex() {
    setState(() {
      tabIndexs = widget.tabIndexId != null ? widget.tabIndexId : 0;
    });
  }

  var tabIndexs = 0;
  void _onItemTapped(int index) {
    setState(() {
      tabIndexs = index;
    });
  }

  @override
  void initState() {
    checkBottomIndex();
    super.initState();
  }
}
