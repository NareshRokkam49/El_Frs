import 'package:dio/dio.dart';
import 'package:entrolabs_attadance/components/is_loading_widget.dart';
import 'package:entrolabs_attadance/components/progress_indicater_widget.dart';
import 'package:entrolabs_attadance/modals/res/apply_leave_res.dart';
import 'package:entrolabs_attadance/modals/res/get_leave_type_res.dart';
import 'package:entrolabs_attadance/utils/local_storage_dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Response;
import 'package:intl/intl.dart';
import '../../components/cButton.dart';
import '../../components/cDropDown.dart';
import '../../components/cTextFormFeild.dart';
import '../../components/custom_shape.dart';
import '../../constants/cColors.dart';
import '../../constants/cStrings.dart';
import '../../constants/image_constants.dart';
import '../../modals/services/api_services.dart';
import '../../resourses/text_styles.dart';
import '../../utils/display_utils.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ApplyLeavesScreen extends StatefulWidget {
  @override
  State<ApplyLeavesScreen> createState() => _ApplyLeavesScreenState();
}

class _ApplyLeavesScreenState extends State<ApplyLeavesScreen> {
  final ValueNotifier<LeaveTypeData?> leaveType = ValueNotifier(null);
  final pickDateComtroller = TextEditingController();
  final reasoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
    final ValueNotifier<bool> _isLoading2 = ValueNotifier(false);

  GetLeaveTypeRes? _leaveTypeRes;
  String  startDate=DateFormat('dd-MM-yyyy').format(DateTime.now());
  String endDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        startDate = '${DateFormat('dd-MM-yyyy').format(args.value.startDate)} ';

        endDate =
            ' ${DateFormat('dd-MM-yyyy').format(args.value.endDate ?? args.value.startDate)}';
      }
    });
  }

  Future<void> _showDatePickerDialog(BuildContext context) async {
    // DateTime selectedDate = DateTime.now();
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: cPrimeryColor2,
          title: Text('Select a Date'),
          content: Container(
            color: cPrimeryColor2,
            width: getWidth(context),
            height: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SfDateRangePicker(
                  onSelectionChanged: _onSelectionChanged,
                  selectionMode: DateRangePickerSelectionMode.range,
                  enablePastDates: false,
                  initialSelectedRange: PickerDateRange(
                    DateTime.now().subtract(const Duration()),
                    DateTime.now().add(const Duration()),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Cancel',
                  style: TextStyles.getSubTita16(textColor: cblueColor),
                )),
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'OK',
                  style: TextStyles.getSubTita16(textColor: cblueColor),
                ))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhiteColor,

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
          _leaveTypeRes == null
          ? CProgressIndicaterWidget(
              color: cblueColor,
            )
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  height: getHeight(context),
                  width: getWidth(context),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          ImageConstants.bgImagePng,
                        ),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                   
                      Container(
                        height: getHeight(context) / 1.15,
                        decoration: BoxDecoration(
                            color: cPrimeryColor2,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32))),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                vGap(20),
                                selectDateWidget(context),
                                vGap(20),
                                leaveTypeDropdown(),
                                vGap(20),
                                reasoneWidget(),
                                vGap(20),
                                applyLeavesBtnWidget(context),
                                vGap(3)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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

  Column reasoneWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(CStrings.reason,
            style: TextStyles.getSubTita16(
                textColor: cBlackColor, fontWeight: FontWeight.w600)),
        vGap(5),
        CTextFormField(
          contentPadding: EdgeInsets.only(left: 10),
          maxLines: 3,
          hintText: CStrings.reason,
          controller: reasoneController,
        )
      ],
    );
  }

  Widget leaveTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(CStrings.leaveType,
            style: TextStyles.getSubTita16(
                textColor: cBlackColor, fontWeight: FontWeight.w600)),
        vGap(5),
        _applyLeaveWidget()
      ],
    );
  }





  Widget _applyLeaveWidget() {
    return ValueListenableBuilder(
        valueListenable: leaveType,
        builder: (context, value, child) {
          return CDropdownButton(
            value: leaveType.value?.leaveType ?? "",
            boaderColor: cGrayColor,
            onChanged: (v) async {
              final slotValue = _leaveTypeRes?.data!
                  .where((element) => element.leaveType == v)
                  .toList();
              leaveType.value = slotValue!.first;
            },
            items: _leaveTypeRes?.data!
                .map((e) => DropdownMenuItem(
                    value: e.leaveType ?? "",
                    child: Text(
                      e.leaveType ?? "",
                      style: TextStyles.getSubTita16(textColor: cBlackColor),
                    )))
                .toList(),
            hintText: Text(
              "Select Leave",
              style: TextStyles.getSubTita16(textColor: cBlackColor),
            ),
          );
        });
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
      CStrings.applyLeaves,
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: cWhiteColor),
    );
  }

  Widget selectDateWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Select Date",
            style: TextStyles.getSubTital20(
                textColor: cBlackColor, fontWeight: FontWeight.w600)),
        vGap(10),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("From Date",
                      style: TextStyles.getSubTita16(
                          textColor: cBlackColor, fontWeight: FontWeight.w600)),
                  vGap(4),
                  SizedBox(
                      height: 50,
                      child: CTextFormField(
                        onTap: () {
                          _showDatePickerDialog(context);
                        },
                        hintText: startDate == '' ? 'Select' : startDate,
                        hintstyle:
                            TextStyles.getSubTita16(textColor: cBlackColor),
                        controller: pickDateComtroller,
                        readOnly: true,
                        suffixIcon:
                            Icon(Icons.calendar_today, color: cBlackColor),
                      )),
                ],
              ),
            ),
            hGap(20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("To Date",
                      style: TextStyles.getSubTita16(
                          textColor: cBlackColor, fontWeight: FontWeight.w600)),
                  vGap(4),
                  SizedBox(
                    height: 50,
                    child: CTextFormField(
                      onTap: () {
                        _showDatePickerDialog(context);
                      },
                      hintText: endDate == '' ? 'Select' : endDate,
                      hintstyle:
                          TextStyles.getSubTita16(textColor: cBlackColor),
                      controller: pickDateComtroller,
                      readOnly: true,
                      suffixIcon:
                          Icon(Icons.calendar_today, color: cBlackColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget applyLeavesBtnWidget(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _isLoading2,
        builder: (context, value, child) {
          return SizedBox(
            child: CButton(
              image: DecorationImage(
                  image: AssetImage(
                    ImageConstants.bgImagePng,
                  ),
                  fit: BoxFit.cover),
              width: getWidth(context) / 1.2,
              text: _isLoading2.value
                  ? IsLoadingWidget()
                  : Text(
                      CStrings.applyLeaves,
                      style: TextStyles.getSubTital20(),
                    ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (startDate == "" && endDate == "") {
                    showErrorMessage(
                        context, "Please select start date or end Date");
                  } else if (leaveType.value == null) {
                    showErrorMessage(context, "Please select type of leave");
                  } else if (reasoneController == "") {
                    showErrorMessage(context, "Please enter reason");
                  } else {
                    await dataFromApplyLeaveApi();
                  }
                }
              },
            ),
          );
        });
  }
  //apis calling  ------------------------ --------- --------------------- ------------------------------------

//leave type api
  dataFromLeavesTypeList() async {
    final userName=Preferences.getUserName();
    _isLoading.value = true;
    try {
      final leavePayload = {
        "GetLeaveType": true,
        "username": userName??"",
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
      showServerMessage(context, e.toString());
    }
  }

//apply leave api
  dataFromApplyLeaveApi() async {
        final userName=Preferences.getUserName();

    _isLoading2.value = true;
    try {
      final applyPayload = {
        "leave_request": true,
        "username": userName??"",
        "from_date": startDate.trim(),
        "to_date": endDate.trim(),
        "leave_type": leaveType.value?.id,
        "leave_reason": reasoneController.text
      };
       final _header = {
        'Ver': ApiServices.apiVer,
        "ApiKey": ApiServices.apiKey,
      };
      Response applyResponse = await Dio().post(ApiServices.baseUrl,
          data: applyPayload, options: Options(headers: _header));
      final applyResult = ApplyLeaveRes.fromJson(applyResponse.data);
      _isLoading2.value = false;

      if (applyResult.result == "success" && (applyResponse.statusCode == 200 ||
          applyResponse.statusCode == 201)) {
        Get.back();
        showSuccessMessage(context, "Leave applied successfully");
        setState(() {
          startDate = "";
          endDate = "";
          leaveType.value = null;
          reasoneController.clear();
        });
      } else {
        showErrorMessage(context, applyResult.error ?? "");
      }
    } catch (e) {
      showServerMessage(context, e.toString());
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
    dataFromLeavesTypeList();
    super.initState();
  }
}
