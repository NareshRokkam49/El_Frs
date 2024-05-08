import 'package:dio/dio.dart';
import 'package:entrolabs_attadance/components/cButton.dart';
import 'package:entrolabs_attadance/components/cRefresh_indicater.dart';
import 'package:entrolabs_attadance/components/progress_indicater_widget.dart';
import 'package:entrolabs_attadance/constants/cColors.dart';
import 'package:entrolabs_attadance/modals/res/leaves_list_res.dart';
import 'package:entrolabs_attadance/resourses/text_styles.dart';
import 'package:entrolabs_attadance/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Response;

import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../components/custom_shape.dart';
import '../../constants/image_constants.dart';
import '../../modals/services/api_services.dart';
import '../../utils/display_utils.dart';
import '../../utils/local_storage_dart';

class LeavesScreen extends StatefulWidget {
  @override
  State<LeavesScreen> createState() => _LeavesScreenState();
}

class _LeavesScreenState extends State<LeavesScreen> {
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  LeavesListRes? _leavesListRes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: cWhiteColor,

      appBar: AppBar(
        title: titleWidget(),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageConstants.bgImagePng),
                  fit: BoxFit.cover)),
        ),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          _leavesListRes == null
              ? CProgressIndicaterWidget(color: cblueColor)
              : CRefreshIndicaterWidget(
                onRefresh: () async{
                  await dataFromLeavesList();
                },
                child: ListView.builder(
                    itemCount: _leavesListRes!.data?.length ?? 0,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      final _leaves = _leavesListRes?.data?[index];
                      final leavesHistroy = _leavesListRes?.leaveHistory?[index];
                      return Column(
                        children: [
                          vGap(20),
                          Container(
                            height: getHeight(context),
                            width: getWidth(context),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                children: [
                                  vGap(20),
                                  leavesHistory(context, _leaves!),
                                  vGap(30),
                                  totalLeavesWidget(_leaves),
                                  vGap(20),
                                  leavesApplyBtn(context),
                                  vGap(20),
                                  leavesHistoryWidget(context, leavesHistroy!),
                                  vGap(10),
                                  leavesHistoryBtn(context),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
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

  Widget totalLeavesWidget(LeavesData leavesData) {
    final leaveper = leavesData.leavePercentage!.toDouble();
    return Container(
      padding: EdgeInsets.all(10),
      child: CircularPercentIndicator(
        radius: 90.0,
        animation: true,
        animationDuration: 1200,
        lineWidth: 8.0,
        percent: leaveper / 100,
        center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${leavesData.leaveBalance ?? ""}",
              style: TextStyles.getHeadline32(
                  fontSize: 30.0, textColor: cBlackColor),
            ),
            Text(
              "Leave Balance",
              style: TextStyles.getSubTita15(textColor: cGrayColor),
            ),
          ],
        ),
        circularStrokeCap: CircularStrokeCap.butt,
        backgroundColor: cTextfeildBdrColor,
        progressColor: cblueColor,
      ),
    );
  }

  Widget titleWidget() {
    return Text('Leaves', style: TextStyles.getSubTital20());
  }

  Widget leavesHistory(BuildContext context, LeavesData leaves) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      ImageConstants.bgImagePng,
                    ),
                    fit: BoxFit.cover),
                color: cblueColor,
                borderRadius: BorderRadius.circular(25)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Leaves",
                  style: TextStyles.getSubTita16(
                      fontSize: 18, textColor: cWhiteColor),
                ),
                vGap(10),
                Text(
                  "${leaves.totalLeaves ?? ""}",
                  style: TextStyles.getSubTital20(textColor: cWhiteColor),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      ImageConstants.bgImagePng,
                    ),
                    fit: BoxFit.cover),
                color: cblueColor,
                borderRadius: BorderRadius.circular(25)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Leaves Used",
                  style: TextStyles.getSubTita16(
                      fontSize: 18, textColor: cWhiteColor),
                ),
                vGap(10),
                Text(
                  "${leaves.leaveUsed ?? ""}",
                  style: TextStyles.getSubTital20(textColor: cWhiteColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget leavesHistoryWidget(BuildContext context, LeaveHistory leavesHistroy) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Leave History',
          style: TextStyles.getSubTita15(
              fontWeight: FontWeight.w500, textColor: cBlackColor),
        ),
        vGap(20),
        Row(
          children: [
            Text(
              'Casual Leaves ',
              style: TextStyles.getSubTita15(textColor: cBlackColor),
            ),
            Text(
              "(${leavesHistroy.casualLeave})",
              style: TextStyles.getSubTita15(textColor: cBlackColor),
            )
          ],
        ),
        vGap(20),
        Row(
          children: [
            Text(
              'Sick leaves ',
              style: TextStyles.getSubTita15(textColor: cBlackColor),
            ),
            Text(
              "(${leavesHistroy.sickLeave})",
              style: TextStyles.getSubTita15(textColor: cBlackColor),
            )
          ],
        ),
      ],
    );
  }

  Widget leavesApplyBtn(BuildContext context) {
    return CButton(
        image: DecorationImage(
            image: AssetImage(
              ImageConstants.bgImagePng,
            ),
            fit: BoxFit.cover),
        width: getWidth(context),
        onPressed: () {
          Get.toNamed(AppRoutes.applyLeavesScreen)!
              .then((value) => dataFromLeavesList());
        },
        textColor: cWhiteColor,
        text: Text(
          "Apply Leave",
          style: TextStyles.getSubTita16(
              textColor: cWhiteColor, fontWeight: FontWeight.w700),
        ));
  }

  Widget leavesHistoryBtn(BuildContext context) {
    return CButton(
        image: DecorationImage(
            image: AssetImage(
              ImageConstants.bgImagePng,
            ),
            fit: BoxFit.cover),
        width: getWidth(context),
        onPressed: () {
          Get.toNamed(AppRoutes.leaveHistoryScreen)!
              .then((value) => dataFromLeavesList());
        },
        textColor: cWhiteColor,
        text: Text(
          "View Leave History",
          style: TextStyles.getSubTita16(
              textColor: cWhiteColor, fontWeight: FontWeight.w700),
        ));
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
  //apis calling  ------------------------ --------- --------------------- ------------------------------------

//leave data api
  dataFromLeavesList() async {
    _isLoading.value = true;
    final userName = Preferences.getUserName();
    try {
      final leavePayload = {
        "getLeaveCalculation": true,
        "username": userName ?? ""
      };
      final _header = {
        'Ver': ApiServices.apiVer,
        "ApiKey": ApiServices.apiKey,
      };
      Response leavesResponse = await Dio().post(ApiServices.baseUrl,
          data: leavePayload, options: Options(headers: _header));
      final attandanceResult = LeavesListRes.fromJson(leavesResponse.data);
      _isLoading.value = false;
      setState(() {
        _leavesListRes = attandanceResult;
      });
    } catch (_) {
  showErrorMessage(context, "Error occured!!!");
    }
  }

  @override
  void initState() {
    dataFromLeavesList();
    super.initState();
  }
}
