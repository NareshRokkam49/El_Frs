import 'package:dio/dio.dart';
import 'package:entrolabs_attadance/components/cDropDown.dart';
import 'package:entrolabs_attadance/components/cRefresh_indicater.dart';
import 'package:entrolabs_attadance/components/progress_indicater_widget.dart';
import 'package:entrolabs_attadance/constants/cColors.dart';
import 'package:entrolabs_attadance/constants/cStrings.dart';
import 'package:entrolabs_attadance/constants/image_constants.dart';
import 'package:entrolabs_attadance/modals/res/attandance_history_res.dart';
import 'package:entrolabs_attadance/modals/services/api_services.dart';
import 'package:entrolabs_attadance/resourses/text_styles.dart';
import 'package:entrolabs_attadance/utils/display_utils.dart';
import 'package:entrolabs_attadance/utils/local_storage_dart';
import 'package:flutter/material.dart';
import '../../components/custom_shape.dart';
import '../../modals/res/months_list.dart';

class AttandanceScreen extends StatefulWidget {
  AttandanceScreen({super.key});

  @override
  State<AttandanceScreen> createState() => _AttandanceScreenState();
}

class _AttandanceScreenState extends State<AttandanceScreen> {
  final ValueNotifier<Month?> _selectmonth = ValueNotifier(null);
  AttandanceHistoryRes? _historyRes;
  final ValueNotifier<String?> _selectYear = ValueNotifier(null);
  final ValueNotifier<bool?> _isLoading = ValueNotifier(false);
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleWidget(),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100,
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
            child:  chooseCalender(),),

          _historyRes==null?CProgressIndicaterWidget(color: cblueColor,):
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(     mainAxisAlignment: MainAxisAlignment.start,
              children: [
               vGap(80),
                _attandanceList(),
              ],
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

  

  Widget titleWidget() {
    return Text(
      CStrings.attendance,
      style: TextStyles.getSubTital20(),
    );
  }

  Widget _attandanceList() {
    return _historyRes?.data==null
                    ? Center(
                      child: Image.asset(
                        ImageConstants.noDataFoundPng,
                        height: getHeight(context) / 3,
                      ),
                    )
                    :
     Expanded(
       child: CRefreshIndicaterWidget(
         onRefresh: () async{
          await dataFromAttandanceHistoryList();
         },
         child: ListView.separated(
           separatorBuilder: (context, index) => Divider(
             thickness: 1,
           ),
           itemCount: _historyRes?.data?.length ?? 0,
           shrinkWrap: true,
           primary: false,
           itemBuilder: (context, index) {
             final attandace = _historyRes?.data?[index];
        
             return Column(
               children: [
                vGap(10),
                 attandace?.dayType == "Holiday"
                     ? Container(
                         height: 45,
                         width: getWidth(context),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(16),
                           image: DecorationImage(
                               image: AssetImage(ImageConstants.btnBgPng)),
                         ),
                         child: Center(
                             child: Text(
                           'Weekend: ${attandace?.monthDate ?? ""}',
                           style: TextStyles.getSubTita13(
                               fontSize: 13,
                               fontWeight: FontWeight.w500,
                               textColor: cBlackColor),
                         )),
                       ):
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     Flexible(
                       flex: 1,
                       child: Container(
                         padding: EdgeInsets.symmetric(
                             vertical: 10, horizontal: 20),
                         decoration: BoxDecoration(
                             image: DecorationImage(
                                 image: AssetImage(
                                   ImageConstants.bgImagePng,
                                 ),
                                 fit: BoxFit.cover),
                             color: cblueColor,
                             borderRadius: BorderRadius.circular(16)),
                         child: Text(attandace?.monthDate??"",
                             maxLines: 1,
                             overflow: TextOverflow.ellipsis,
                             style: TextStyles.getSubTita13(
                                 textColor: cWhiteColor)),
                       ),
                     ),
                     Column(
                       children: [
                         Text(CStrings.clockIn,
                             style: TextStyles.getSubTita13(textColor: cGrayColor)),
                         vGap(5),
                         Text(attandace?.checkIn ?? "",
                             style: TextStyles.getSubTita13(
                                 textColor: attandace?.checkInStatus == "1"
                                     ? cBlackColor
                                     : attandace?.checkInStatus == "2"
                                         ? cOrangeColor
                                         : cRedColor,
                                 fontWeight: FontWeight.w500)),
                       ],
                     ),
                     Column(
                       children: [
                         Text(CStrings.clockOut,
                             style: TextStyles.getSubTita13(textColor: cGrayColor)),
                         vGap(5),
                         Text(attandace?.checkOut ?? "",
                             style: TextStyles.getSubTita13(
                                 textColor: attandace?.checkInStatus == "1"
                                     ? cBlackColor
                                     : attandace?.checkInStatus == "2"
                                         ? cOrangeColor
                                         : cRedColor,
                                 fontWeight: FontWeight.w500)),
                       ],
                     ),
                     Column(
                       children: [
                         Text("Working overs",
                             style: TextStyles.getSubTita13(textColor: cGrayColor)),
                         vGap(5),
                         Text(attandace?.duration ?? "",
                             style: TextStyles.getSubTita13(
                                 textColor: attandace?.checkInStatus == "1"
                                     ? cBlackColor
                                     : attandace?.checkInStatus == "2"
                                         ? cOrangeColor
                                         : cRedColor,
                                 fontWeight: FontWeight.w500)),
                       ],
                     ),
                   ],
                 ),
                
                 vGap(20),
               ],
             );
           },
         ),
       ),
     );
  }

  Widget chooseCalender() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _selectMonthWidget(),
          hGap(10),
          _selectYearWidget(),
        ],
      ),
    );
  }

  Widget _selectMonthWidget() {
    return ValueListenableBuilder(
        valueListenable: _selectmonth,
        builder: (context, value, child) {
          return SizedBox(
            width: (getWidth(context) / 2.5 * 1) - 20,
            child: CDropdownButton(
              borderRadius: BorderRadius.circular(16),
              value: _selectmonth.value?.name ?? "",
              boaderColor: cblueColor,
              onChanged: (v) async {
                final monthValue =
                    months.where((element) => element.name == v).toList();
                _selectmonth.value = monthValue.first;

                await dataFromAttandanceHistoryList();
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
            width: (getWidth(context) / 2.5 * 1) - 20,
            child: CDropdownButton(
              borderRadius: BorderRadius.circular(16),
              value: _selectYear.value ?? "",
              boaderColor: cblueColor,
              onChanged: (v) async {
                final yearValue =
                    yearsList.where((element) => element == v).toList();
                _selectYear.value = yearValue.first;
                dataFromAttandanceHistoryList();
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
                _selectYear.value ?? "${_dateTime.year}",
                style: TextStyles.getSubTita12(textColor: cBlackColor),
              ),
            ),
          );
        });
  }

   @override
  void setState(VoidCallback fn) {
    if (mounted) {
          super.setState(fn);

    }
  }
//apis calling  ------------------------ --------- --------------------- ------------------------------------

//attandanceHistory Api
  dataFromAttandanceHistoryList() async {
    _isLoading.value = true;
    final userName = Preferences.getUserName();
    String yearString = _dateTime.year.toString();
    try {
      final attandacePayload = {
        "attendanceHistory": true,
        "username": userName ?? "",
        "month": _selectmonth.value == null
            ? _dateTime.month
            : _selectmonth.value?.id,
        "year": _selectYear.value ?? yearString,
      };
     
      final _header = {
        'Ver': ApiServices.apiVer,
        "ApiKey": ApiServices.apiKey,
      };

      Response attandanceResponse = await Dio().post(ApiServices.baseUrl,
          data: attandacePayload, options: Options(headers: _header));
      final attandanceResult =
          AttandanceHistoryRes.fromJson(attandanceResponse.data);
      _isLoading.value = false;
      setState(() {
        _historyRes = attandanceResult;
      });
    } catch (_) {
      showErrorMessage(context, "Error occured!!!");
    }
  }

  @override
  void initState() {
    dataFromAttandanceHistoryList();
    _selectmonth.value = months[DateTime.now().month - 1];
    super.initState();
  }
}
