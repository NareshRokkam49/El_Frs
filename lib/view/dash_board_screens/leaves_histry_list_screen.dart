import 'package:dio/dio.dart';
import 'package:entrolabs_attadance/constants/cColors.dart';
import 'package:entrolabs_attadance/modals/res/view_leave_history_res.dart';
import 'package:entrolabs_attadance/utils/display_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Response;

import '../../components/cDropDown.dart';
import '../../components/cRefresh_indicater.dart';
import '../../components/custom_shape.dart';
import '../../components/progress_indicater_widget.dart';
import '../../constants/cStrings.dart';
import '../../constants/image_constants.dart';
import '../../modals/res/get_leave_type_res.dart';
import '../../modals/res/months_list.dart';
import '../../modals/services/api_services.dart';
import '../../resourses/text_styles.dart';
import '../../utils/local_storage_dart';

class LeaveHistoryScreen extends StatefulWidget {
  LeaveHistoryScreen({super.key});

  @override
  State<LeaveHistoryScreen> createState() => _LeaveHistoryScreenState();
}

final ValueNotifier<bool> _isLoading = ValueNotifier(false);
final ValueNotifier<LeaveTypeData?> leaveType = ValueNotifier(null);
final ValueNotifier<Month?> _selectmonth = ValueNotifier(null);

GetLeaveTypeRes? _leaveTypeRes;
ViewLeaveHistoryRes? _leaveHistoryRes;
List yearsList = [
  "2020",
  "2021",
  "2022",
  "2023",
  "2024",
];
List<Month> months = [
  Month("1", 'Jan'),
  Month("2", 'Feb'),
  Month("3", 'Mar'),
  Month("4", 'Apr'),
  Month('5', 'May'),
  Month("6", 'June'),
  Month("7", 'July'),
  Month("8", 'Aug'),
  Month("9", 'Sep'),
  Month("10", 'Oct'),
  Month("11", 'Nov'),
  Month('12', 'Dec'),
];

final ValueNotifier<String?> _selectYear = ValueNotifier(null);
DateTime _dateTime = DateTime.now();

class _LeaveHistoryScreenState extends State<LeaveHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: backButtonWidget(),
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
                    
                    Positioned(
                      top: 20,
                      left: 1,
                      right: 1,
                      child: chooseCalender()),
          (_leaveTypeRes == null && _leaveHistoryRes == null)
              ? CProgressIndicaterWidget(color: cBlueColor)
              : CRefreshIndicaterWidget(
                onRefresh: () async{
                await dataFromLeavesHistryApi();  
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                     
                      vGap(70),
                      _leavesHistory(),
                    ],
                  ),
                ),
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

  Widget titleWidget() {
    return Text(
      'Leave History',
      style: TextStyles.getSubTital20(),
    );
  }

  Widget chooseCalender() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _selectMonthWidget(),
         hGap(10),
          _selectYearWidget(),
          hGap(10),
          _applyLeaveWidget()
        ],
      ),
    );
  }

  Widget _selectMonthWidget() {
    return ValueListenableBuilder(
        valueListenable: _selectmonth,
        builder: (context, value, child) {
          return SizedBox(
            width: (getWidth(context) / 3 * 1) - 20,
            child: CDropdownButton(
              borderRadius: BorderRadius.circular(16),
              value: _selectmonth.value?.name ?? "",
              boaderColor: cblueColor,
              onChanged: (v) async {
                final monthValue =
                    months.where((element) => element.name == v).toList();
                _selectmonth.value = monthValue.first;

                await dataFromLeavesHistryApi();
              },
              items: months
                  .map((e) => DropdownMenuItem(
                        value: e.name ?? "",
                        child: Text(
                          e.name ?? "",
                          style:
                              TextStyles.getSubTita13(textColor: cBlackColor),
                        ),
                      ))
                  .toList(),
              hintText: Text(
                _selectmonth.value?.name ?? "month",
                style: TextStyles.getSubTita13(textColor: cBlackColor),
              ),
            ),
          );
        });
  }

  Widget _selectYearWidget() {
    return ValueListenableBuilder(
        valueListenable: _selectYear,
        builder: (context, value, child) {
          return SizedBox(
            width: (getWidth(context) / 3 * 1) - 20,
            child: CDropdownButton(
              borderRadius: BorderRadius.circular(16),
              value: _selectYear.value ?? "",
              boaderColor: cblueColor,
              onChanged: (v) async {
                final yearValue =
                    yearsList.where((element) => element == v).toList();
                _selectYear.value = yearValue.first;
                dataFromLeavesHistryApi();
              },
              items: yearsList
                  .map((e) => DropdownMenuItem(
                        value: e.toString(),
                        child: Text(
                          e ?? "",
                          style:
                              TextStyles.getSubTita13(textColor: cBlackColor),
                        ),
                      ))
                  .toList(),
              hintText: Text(
                "${_selectYear.value ?? _dateTime.year}",
                style: TextStyles.getSubTita13(textColor: cBlackColor),
              ),
            ),
          );
        });
  }

  Widget _applyLeaveWidget() {
    return ValueListenableBuilder(
        valueListenable: leaveType,
        builder: (context, value, child) {
          return SizedBox(
            width: (getWidth(context) / 3 * 1) - 20,
            child: CDropdownButton(
              borderRadius: BorderRadius.circular(16),
              value: leaveType.value?.leaveType ?? "",
              boaderColor: cBlueColor,
              onChanged: (v) async {
                final slotValue = _leaveTypeRes?.data!
                    .where((element) => element.leaveType == v)
                    .toList();
                leaveType.value = slotValue!.first;
                await dataFromLeavesHistryApi();
              },
              items: _leaveTypeRes?.data!
                  .map((e) => DropdownMenuItem(
                      value: e.leaveType ?? "",
                      child: Text(
                        e.leaveType ?? "",
                        style: TextStyles.getSubTita13(textColor: cBlackColor),
                      )))
                  .toList(),
              hintText: Text(
                "All",
                style: TextStyles.getSubTita13(textColor: cBlackColor),
              ),
            ),
          );
        });
  }

  Widget _leavesHistory() {
    return _leaveHistoryRes?.data == null
        ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              vGap(100),
              Center(
                child: Image.asset(
                  ImageConstants.noDataFoundPng,
                  height: getHeight(context) / 4,
                ),
              ),
            ],
          )
        : Expanded(
          child:  ListView.builder(
                itemCount: _leaveHistoryRes?.data?.length ?? 0,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  final histData = _leaveHistoryRes?.data?[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      vGap(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(CStrings.appliedDuration,
                                  maxLines: 1,
                                  style: TextStyles.getSubTita13(
                                      textColor: cGrayColor)),
                                vGap(3),
                              Text(histData!.appliedDuration ?? "",
                                  style: TextStyles.getSubTita13(
                                      textColor: cBlackColor,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          hGap(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(CStrings.typeOfLeave,
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.getSubTita13(
                                      textColor: cGrayColor)),
                                vGap(3),
                              Text(histData.typeOfLeave ?? "",
                                  style: TextStyles.getSubTita13(
                                      textColor: cBlackColor,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          hGap(10),
                          Expanded(
                            child: Text(histData.status ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.end,
                                style: TextStyles.getSubTita13(
                                    textColor: histData.status == "Approved"
                                        ? cGreenColor
                                        : cRedColor)),
                          ),
                        ],
                      ),
                         vGap(10),
                      Text(CStrings.reason,
                          style: TextStyles.getSubTita13(textColor: cGrayColor)),
                       vGap(3),
                      Text(
                          "${histData.leaveReason?[0].toUpperCase()}" +
                              '${histData.leaveReason?.substring(1)}',
                          style: TextStyles.getSubTita13(
                              textColor: cBlackColor,
                              fontWeight: FontWeight.bold)),
                      vGap(10),
                      Text("Admin Remarks",
                          style: TextStyles.getSubTita13(textColor: cGrayColor)),
                    vGap(3),
                      Text(
                          histData.remarks == ""
                              ? "--:--"
                              : '${histData.remarks?[0].toUpperCase()}' +
                                  '${histData.leaveReason?.substring(1)}',
                          style: TextStyles.getSubTita13(
                              textColor: cBlackColor,
                              fontWeight: FontWeight.bold)),
                      vGap(5),
                      Divider(),
                      vGap(5),
                    ],
                  );
                },
              ),
            
        );
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

//apis calling -------------------------------------- ------------------- -----------------
//leave type api
  dataFromLeavesTypeList() async {
    final userName = Preferences.getUserName();
    _isLoading.value = true;
    try {
      final leavePayload = {
        "GetLeaveType": true,
        "username": userName ?? "",
      };
      final _header = {
        'Ver': ApiServices.apiVer,
        "ApiKey": ApiServices.apiKey,
      };
      Response typeResponse = await Dio().post(ApiServices.baseUrl,
          data: leavePayload, options: Options(headers: _header));
      final typeResult = GetLeaveTypeRes.fromJson(typeResponse.data);
      _isLoading.value = false;
      setState(() {
        _leaveTypeRes = typeResult;
      });
    } catch (e) {
  showErrorMessage(context, "Error occured!!!");
    }
  }

  dataFromLeavesHistryApi() async {
    final userName = Preferences.getUserName();
    _isLoading.value = true;
    try {
      final histPayload = {
        "getLeaveHistory": true,
        "username": userName ?? "",
        "month": _selectmonth.value == null
            ? _dateTime.month
            : _selectmonth.value?.id,
        "year": _selectYear.value == null ? _dateTime.year : _selectYear.value,
        "leave_type": leaveType.value == null ? 0 : leaveType.value?.id
      };
      final _header = {
        'Ver': ApiServices.apiVer,
        "ApiKey": ApiServices.apiKey,
      };
      Response histResponse = await Dio().post(ApiServices.baseUrl,
          data: histPayload, options: Options(headers: _header));
      final histResult = ViewLeaveHistoryRes.fromJson(histResponse.data);
      _isLoading.value = false;
      setState(() {
        _leaveHistoryRes = histResult;
      });
    } catch (_) {
  showErrorMessage(context, "Error occured!!!");
    }
  }

  @override
  void initState() {
    dataFromLeavesTypeList();
    dataFromLeavesHistryApi();

    // Set the initial selection to the current month
    _selectmonth.value = months[DateTime.now().month - 1];
    super.initState();
  }
}
