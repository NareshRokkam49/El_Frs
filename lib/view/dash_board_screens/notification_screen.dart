import 'package:dio/dio.dart';
import 'package:entrolabs_attadance/constants/cColors.dart';
import 'package:entrolabs_attadance/constants/image_constants.dart';
import 'package:entrolabs_attadance/modals/res/get_notification_list.dart';
import 'package:entrolabs_attadance/resourses/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Response;
import '../../../../utils/display_utils.dart';
import '../../components/cRefresh_indicater.dart';
import '../../components/progress_indicater_widget.dart';
import '../../modals/res/update_notification_status_res.dart';
import '../../modals/services/api_services.dart';
import '../../utils/local_storage_dart';

class NotificationsScreen extends StatefulWidget {
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  GetNotificationListRes? _notificationListRes;
  final userName=Preferences.getUserName();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          leading: backButtonWidget(),
          elevation: 0,
          title: titleWidget(),
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
          child: _notificationListRes == null
              ? CProgressIndicaterWidget(
                  color: cblueColor,
                )
              : Column(
                  children: [
                    vGap(150),
                    Expanded(
                      child: Container(
                        width: getWidth(context),
                        decoration: BoxDecoration(
                          color: cPrimeryColor2,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _notificationList(),
                              vGap(10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ));
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
      'Notifications',
      style: TextStyles.getSubTita16(
          fontWeight: FontWeight.w500, textColor: cWhiteColor),
    );
  }

  Widget _notificationList() {
    return _notificationListRes?.data==null
        ? Column(
            children: [
              vGap(100),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  ImageConstants.noDataFoundPng,
                  height: getHeight(context) / 4,
                ),
              ),
            ],
          )
        : Expanded(
            child: CRefreshIndicaterWidget(
              onRefresh: () async {
                await getTheDataFromNotificationApi();
              },
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  thickness: 1,
                ),
                itemCount: _notificationListRes?.data?.length ?? 0,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  final notiData = _notificationListRes?.data![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () async {
                        await dataFromTheUpdateNotificationStatusApi(
                            notiData.id ?? "");
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                ImageConstants.notificationbellIconSvg,
                                colorFilter: ColorFilter.mode(
                                    notiData!.status == "0"
                                        ? cBlackColor
                                        : cGrayColor,
                                    BlendMode.srcIn),
                              ),
                              hGap(10),
                              Expanded(
                                child: Text(
                                  notiData.title == ""
                                      ? ""
                                      : "${notiData.title?[0].toUpperCase()}" +
                                          notiData.title!.substring(1),
                                  style: TextStyle(
                                      color: notiData.status == "0"
                                          ? cBlackColor
                                          : cGrayColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          vGap(10),
                          Text(
                            notiData.message == ""
                                ? ""
                                : "${notiData.message?[0].toUpperCase()}" +
                                    notiData.message!.substring(1),
                            style: TextStyles.getSubTita14(
                                textColor: notiData.status == "0"
                                    ? cBlackColor
                                    : cGrayColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                notiData.timestamp ?? "",
                                style: TextStyles.getSubTita14(
                                    textColor: notiData.status == "0"
                                        ? cBlackColor
                                        : cGrayColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              )),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
          super.setState(fn);

    }
  }

  //apis calling --------------------------- -------------------- --------------

  getTheDataFromNotificationApi() async {
    _isLoading.value = true;
    try {
      final notPayload = {
        "getNotifications": true,
        "username":userName??"" ,
        "id": ""
      };
      final _header = {
        'Ver': ApiServices.apiVer,
        "ApiKey": ApiServices.apiKey,
      };
      Response notResponse = await Dio().get(ApiServices.baseUrl,
          data: notPayload, options: Options(headers: _header));
      final notResult = GetNotificationListRes.fromJson(notResponse.data);
      _isLoading.value = false;

      setState(() {
        _notificationListRes = notResult;
      });

      if (notResult.result == "success" &&
          (notResponse.statusCode == 200 || notResponse.statusCode == 201)) {}
    } catch (e) {
            showErrorMessage(context, "Error occured");

    }
  }

  dataFromTheUpdateNotificationStatusApi(status) async {
    _isLoading.value = true;
    try {
      final statusPayload = {
        "updateNotificationStatus": true,
        "username": userName??"",
        "id": status ?? ""
      };
       final _header = {
        'Ver': ApiServices.apiVer,
        "ApiKey": ApiServices.apiKey,
      };
      Response statusResponse = await Dio().get(ApiServices.baseUrl,
          data: statusPayload, options: Options(headers: _header));
      final statusResult =
          UpdateNotificationStatusRes.fromJson(statusResponse.data);
      _isLoading.value = false;

      if (statusResult.result == "success" &&
          (statusResponse.statusCode == 200 ||
              statusResponse.statusCode == 201)) {
        getTheDataFromNotificationApi();
      }
    } catch (e) {
  showErrorMessage(context, "Error occured!!!");

    }
  }

  @override
  void initState() {
    getTheDataFromNotificationApi();
    super.initState();
  }
}
