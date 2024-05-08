import 'package:dio/dio.dart';
import 'package:entrolabs_attadance/components/cRefresh_indicater.dart';
import 'package:entrolabs_attadance/components/progress_indicater_widget.dart';
import 'package:entrolabs_attadance/modals/res/work_logStatus_list_res.dart';
import 'package:entrolabs_attadance/modals/res/work_log_history_list_res.dart';
import 'package:entrolabs_attadance/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Response;

import '../../components/cDropDown.dart';
import '../../components/custom_shape.dart';
import '../../constants/cColors.dart';
import '../../constants/cStrings.dart';
import '../../constants/image_constants.dart';
import '../../modals/res/months_list.dart';
import '../../modals/services/api_services.dart';
import '../../resourses/text_styles.dart';
import '../../utils/display_utils.dart';
import '../../utils/local_storage_dart';

class WorkLogScreen extends StatefulWidget {
  WorkLogScreen({super.key});

  @override
  State<WorkLogScreen> createState() => _WorkLogScreenState();
}

class _WorkLogScreenState extends State<WorkLogScreen> {
  List yearsList = [
    "2020",
    "2021",
    "2022",
    '2023',
    '2024',
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

  DateTime _dateTime = DateTime.now();

  WorklogStatusListRes? _statusListRes;
  WorklogHistoryListRes? _historyListRes;
  final ValueNotifier<Month?> _selectmonth = ValueNotifier(null);
  final ValueNotifier<String?> _selectYear = ValueNotifier(null);
  final ValueNotifier<StatusData?> _workStatus = ValueNotifier(null);
  ValueNotifier<bool> _isLoading = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleWidget(),
        centerTitle: true,
        toolbarHeight: 90,
        elevation: 0,
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
            top: 10,
            left: 1,
            right: 1,
            child: chooseCalender(),
          ),
          _statusListRes == null && _historyListRes == null
              ? CProgressIndicaterWidget(
                  color: cblueColor,
                )
              : CRefreshIndicaterWidget(
                  onRefresh: () async {
                    await dataFromWorkLogHistryListApi();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        vGap(80),
                        _workLoglist(),
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
      floatingActionButton: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                ImageConstants.bgImagePng,
              ),
              fit: BoxFit.cover),
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
            onPressed: () {
              Get.toNamed(AppRoutes.createWorkLogScreen)!
                  .then((value) => dataFromWorkLogHistryListApi());
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: const Icon(
              Icons.add,
              color: cWhiteColor,
            )),
      ),
    );
  }

  Widget titleWidget() {
    return Text(CStrings.workLogs, style: TextStyles.getSubTital20());
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

  Widget chooseCalender() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _selectMonthWidget(),
          Spacer(),
          _selectYearWidget(),
          Spacer(),
          _selectAllWidget()
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

                await dataFromWorkLogHistryListApi();
              },
              items: months
                  .map((e) => DropdownMenuItem(
                        value: e.name ?? "",
                        child: Text(
                          e.name ?? "",
                          style:
                              TextStyles.getSubTita12(textColor: cBlackColor),
                        ),
                      ))
                  .toList(),
              hintText: Text(
                _selectmonth.value?.name ?? "month",
                style: TextStyles.getSubTita12(textColor: cBlackColor),
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
                await dataFromWorkLogHistryListApi();
              },
              items: yearsList
                  .map((e) => DropdownMenuItem(
                        value: e.toString(),
                        child: Text(
                          e ?? "",
                          style:
                              TextStyles.getSubTita12(textColor: cBlackColor),
                        ),
                      ))
                  .toList(),
              hintText: Text(
                "${_selectYear.value ?? _dateTime.year}",
                style: TextStyles.getSubTita12(textColor: cBlackColor),
              ),
            ),
          );
        });
  }

  Widget _selectAllWidget() {
    return ValueListenableBuilder(
        valueListenable: _workStatus,
        builder: (context, value, child) {
          return SizedBox(
            width: (getWidth(context) / 3 * 1) - 20,
            child: CDropdownButton(
              borderRadius: BorderRadius.circular(16),
              value: _workStatus.value?.name ?? "",
              boaderColor: cblueColor,
              onChanged: (v) async {
                final statusValue = _statusListRes?.data!
                    .where((element) => element.name == v)
                    .toList();
                _workStatus.value = statusValue!.first;
                await dataFromWorkLogHistryListApi();
              },
              items: _statusListRes?.data!
                  .map((e) => DropdownMenuItem(
                        value: e.name ?? "",
                        child: Text(
                          e.name ?? "",
                          style:
                              TextStyles.getSubTita12(textColor: cBlackColor),
                        ),
                      ))
                  .toList(),
              hintText: Text(
                "Work Status",
                style: TextStyles.getSubTita12(textColor: cBlackColor),
              ),
            ),
          );
        });
  }

  Widget _workLoglist() {
    return _historyListRes?.data == null
        ? Center(
            child: Image.asset(
              ImageConstants.noDataFoundPng,
              height: getHeight(context) / 4,
            ),
          )
        : Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                thickness: 1,
              ),
              itemCount: _historyListRes?.data?.length ?? 0,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                final historyData = _historyListRes?.data![index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vGap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(CStrings.date,
                                maxLines: 1,
                                style: TextStyles.getSubTita13(
                                    textColor: cGrayColor)),
                            Text(historyData?.date ?? "",
                                style: TextStyles.getSubTita13(
                                    textColor: cBlackColor,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(historyData?.status ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyles.getSubTita13(
                                  textColor: historyData!.status == "Completed"
                                      ? cGreenColor
                                      : cRedColor)),
                        ),
                      ],
                    ),
                    vGap(10),
                    Text(CStrings.workType,
                        style: TextStyles.getSubTita13(textColor: cGrayColor)),
                    vGap(5),
                    Text(historyData.workType ?? "",
                        style: TextStyles.getSubTita13(
                            textColor: cBlackColor,
                            fontWeight: FontWeight.bold)),
                    vGap(10),
                    Text(CStrings.relatedTp,
                        style: TextStyles.getSubTita13(textColor: cGrayColor)),
                    vGap(5),
                    Text(
                        "${historyData.workRelated?[0].toUpperCase()}" +
                            "${historyData.workRelated?.substring(1)}",
                        style: TextStyles.getSubTita13(
                            textColor: cBlackColor,
                            fontWeight: FontWeight.bold)),
                    vGap(10),
                    Text(CStrings.project,
                        style: TextStyles.getSubTita13(textColor: cGrayColor)),
                    vGap(5),
                    Text(
                        "${historyData.project?[0].toUpperCase()}" +
                            "${historyData.project!.substring(1)}",
                        style: TextStyles.getSubTita13(
                            textColor: cBlackColor,
                            fontWeight: FontWeight.bold)),
                    vGap(10),
                  ],
                );
              },
            ),
          );
  }

//apis calling ------------------- ------------------ --------------------- ---------------

  //work status list
  dataFromWorkStatusList() async {
    _isLoading.value = true;
    final userName = Preferences.getUserName();
    try {
      final statusPayload = {"getWorkStatus": true, "username": userName};
      final _header = {
        'Ver': ApiServices.apiVer,
        "ApiKey": ApiServices.apiKey,
      };
      Response statusResponse = await Dio().post(ApiServices.baseUrl,
          data: statusPayload, options: Options(headers: _header));
      final typeResult = WorklogStatusListRes.fromJson(statusResponse.data);
      _isLoading.value = false;
      setState(() {
        _statusListRes = typeResult;
      });
    } catch (e) {
      showErrorMessage(context, "Error occured!!!");
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    dataFromWorkStatusList();
    dataFromWorkLogHistryListApi();
    _selectmonth.value = months[DateTime.now().month - 1];
    super.initState();
  }

// apis calling
//worklog histroy
  dataFromWorkLogHistryListApi() async {
    _isLoading.value = true;
    String yearString = _dateTime.year.toString();
    final userName = Preferences.getUserName();

    try {
      final histPayload = {
        "getWorkLogHistory": true,
        "username": userName ?? "",
        "month": _selectmonth.value == null
            ? _dateTime.month
            : _selectmonth.value?.id,
        "year": _selectYear.value == null ? yearString : _selectYear.value,
        "work_status": _workStatus.value == null ? "0" : _workStatus.value?.id
      };

      final _header = {
        'Ver': ApiServices.apiVer,
        "ApiKey": ApiServices.apiKey,
      };
      Response histResponse = await Dio().post(ApiServices.baseUrl,
          data: histPayload, options: Options(headers: _header));
      final histResult = WorklogHistoryListRes.fromJson(histResponse.data);
      _isLoading.value = false;
      setState(() {
        _historyListRes = histResult;
      });
    } on Exception catch (_) {
      showErrorMessage(context, "Error occured!!!");

      // showServerMessage(
      //     context, "An error occured HTTP 500 internal server error");
    }
  }
}
