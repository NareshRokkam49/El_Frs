import 'package:dio/dio.dart';
import 'package:entrolabs_attadance/components/is_loading_widget.dart';
import 'package:entrolabs_attadance/components/progress_indicater_widget.dart';
import 'package:entrolabs_attadance/modals/res/get_product_list_res.dart';
import 'package:entrolabs_attadance/modals/res/work_logStatus_list_res.dart';
import 'package:entrolabs_attadance/modals/res/work_related_list_res.dart';
import 'package:entrolabs_attadance/modals/res/work_type_list_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Response;
import 'package:intl/intl.dart';

import '../../components/cButton.dart';
import '../../components/cDropDown.dart';
import '../../components/cTextFormFeild.dart';
import '../../components/custom_shape.dart';
import '../../components/withOut_star_text_widget.dart';
import '../../constants/cColors.dart';
import '../../constants/cStrings.dart';
import '../../constants/image_constants.dart';
import '../../modals/res/create_work_log_res.dart';
import '../../modals/services/api_services.dart';
import '../../resourses/text_styles.dart';
import '../../utils/display_utils.dart';
import '../../utils/local_storage_dart';

class CreateWorkLogScreen extends StatefulWidget {
  CreateWorkLogScreen({super.key});

  @override
  State<CreateWorkLogScreen> createState() => _CreateWorkLogScreenState();
}

class _CreateWorkLogScreenState extends State<CreateWorkLogScreen> {
  final TextEditingController _detailsController = TextEditingController();
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  final ValueNotifier<bool> _isLoading2 = ValueNotifier(false);
  final ValueNotifier<StatusData?> _workstatus = ValueNotifier(null);
  final ValueNotifier<ProductData?> _project = ValueNotifier(null);
  final ValueNotifier<TypeData?> _workType = ValueNotifier(null);
  final ValueNotifier<bool> _ischecked = ValueNotifier(true);
  final ValueNotifier<List<String>> selectedList = ValueNotifier([]);
  final ValueNotifier<List<String>> nameList = ValueNotifier([]);

  WorklogStatusListRes? _statusListRes;
  WorkReletedListRes? _reletedListRes;
  WorkTypeListRes? _workTypeListRes;
  GetProductListRes? _getProductListRes;
  DateTime todayDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  List<String> ids = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cPrimeryColor2,
      appBar: AppBar(
        elevation: 0,
        title: titleWidget(),
        centerTitle: true,
        toolbarHeight: 90,
        leading: backButtonWidget(),
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
          _workTypeListRes == null && _reletedListRes == null
                    ? CProgressIndicaterWidget(
                        color: cblueColor
                      )
                    :
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child:  Container(
                width: getWidth(context),
                decoration: BoxDecoration(
                    color: cPrimeryColor2,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child:
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      vGap(20),
                      _dateText(),
                      vGap(5),
                      _dateWidget(),
                      vGap(10),
                      _workTypeText(),
                      vGap(5),
                      _workTypeWidget(),
                      vGap(5),
                      _reletedToText(),
                      vGap(5),
                      _relatedListWidget(selectedList.value),
                      vGap(10),
                      _projectText(),
                      vGap(5),
                      _projectWidget(),
                      vGap(10),
                      _workStatusText(),
                      vGap(5),
                      _workStatusWidget(),
                      vGap(10),
                      _detailText(),
                      vGap(5),
                      _detailsWidget(),
                      vGap(25),
                      CreateWorkLogBtn(context),
                      vGap((getHeight(context) / 10 * 1.5) - 20),
                    ],
                  ),
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

  Widget _relatedListWidget(List<String> value) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return _reletedInfoAlort(context);
            });
      },
      child: ValueListenableBuilder(
          valueListenable: _ischecked,
          builder: (context, value, child) {
            List<String> modifiedList = selectedList.value.map((item) {
              return item.replaceAll(RegExp(r'[0-9]'), '');
            }).toList();

            modifiedList.removeWhere((element) => element.isEmpty);
            final clipData = modifiedList.join(",");
            return Container(
              width: getWidth(context),
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: cGrayColor),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        clipData.isEmpty ? "Related To" : clipData.toString(),
                      ),
                    ),
                    SvgPicture.asset(ImageConstants.arrowDownIconSvg)
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget _reletedInfoAlort(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Container(
          width: getWidth(context),
          height: getHeight(context) / 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Related to",
                style: TextStyles.getSubTital20(textColor: cBlackColor),
              ),
              ValueListenableBuilder(
                  valueListenable: _ischecked,
                  builder: (context, value, child) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: _reletedListRes?.data?.length ?? 0,
                        itemBuilder: (context, int index) {
                          final relatedId = _reletedListRes?.data![index];
                          List filterList = selectedList.value
                              .where((element) => element == relatedId!.id)
                              .toList();

                          return Column(
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                        checkColor: cWhiteColor,
                                        fillColor: MaterialStateProperty.all(
                                            cblueColor),
                                        value: filterList.length == 0
                                            ? false
                                            : true,
                                        onChanged: (v) {
                                          var list = selectedList.value;
                                          _ischecked.value = !_ischecked.value;

                                          if (v == true) {
                                            list.add(relatedId?.name ?? "");
                                            list.add(relatedId?.id ?? "");
                                            selectedList.value = list;
                                          } else {
                                            list.remove(relatedId?.name ?? "");
                                            list.remove(relatedId?.id ?? "");
                                            selectedList.value = list;
                                          }
                                        }),
                                    Text(relatedId?.name ?? "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyles.getSubTita16(
                                            textColor: cBlackColor)),
                                  ]),
                            ],
                          );
                        },
                      ),
                    );
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CButton(
                      onPressed: () {
                        Get.back();
                      },
                      height: 45,
                      width: getWidth(context) / 3,
                      image: DecorationImage(
                          image: AssetImage(ImageConstants.bgImagePng),
                          fit: BoxFit.cover),
                      text: Text(
                        "Ok",
                        style: TextStyles.getSubTita16(textColor: cWhiteColor),
                      )),
                  CButton(
                      onPressed: () {
                        setState(() {
                          selectedList.value.clear();
                        });

                        Get.back();
                      },
                      height: 45,
                      width: getWidth(context) / 3,
                      image: DecorationImage(
                          image: AssetImage(ImageConstants.bgImagePng),
                          fit: BoxFit.cover),
                      text: Text(
                        "Cancel",
                        style: TextStyles.getSubTita16(textColor: cWhiteColor),
                      )),
                ],
              )
            ],
          ),
        ));
  }

  Widget titleWidget() {
    return Text(
      'Create Work Log',
      style: TextStyles.getSubTital20(
          textColor: cWhiteColor, fontWeight: FontWeight.w500),
    );
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

  Widget CreateWorkLogBtn(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _isLoading2,
        builder: (context, value, child) {
          return Align(
            alignment: Alignment.center,
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
                      "Submit",
                      style: TextStyles.getSubTital20(),
                    ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (_workType.value == null) {
                    showErrorMessage(context, "Please select work type");
                  } else if (selectedList.value.isEmpty) {
                    showErrorMessage(context, "Please select releted to");
                  } else if (_project.value == null) {
                    showErrorMessage(context, "Please select product");
                  } else if (_workstatus.value == null) {
                    showErrorMessage(context, "Please select work status");
                  } else if (_detailsController.text == "") {
                    showErrorMessage(context, "Please select work details");
                  } else {
                 
                   await dataFromCreateWorkLog();
                  }
                }
              },
            ),
          );
        });
  }

  Widget _dateText() {
    return CWithoutStarTextWidget(text: CStrings.date);
  }

  Widget _reletedToText() {
    return CWithoutStarTextWidget(text: "Releted to");
  }

  Widget _workTypeText() {
    return CWithoutStarTextWidget(text: 'Worktype');
  }

  Widget _projectText() {
    return CWithoutStarTextWidget(text: 'Project');
  }

  Widget _workStatusText() {
    return CWithoutStarTextWidget(text: 'Work Status');
  }

  Widget _detailText() {
    return CWithoutStarTextWidget(text: 'Details');
  }

  Widget _detailsWidget() {
    return CTextFormField(
      contentPadding: EdgeInsets.only(left: 10, top: 10),
      maxLines: 4,
      controller: _detailsController,
      KeyboardType: TextInputType.emailAddress,
      hintText: 'Details',
    );
  }

  Widget _workStatusWidget() {
    return ValueListenableBuilder(
        valueListenable: _workstatus,
        builder: (context, value, child) {
          return CDropdownButton(
            borderRadius: BorderRadius.circular(8),
            value: _workstatus.value?.name ?? "",
            boaderColor: cGrayColor,
            onChanged: (v) async {
              final monthValue = _statusListRes!.data!
                  .where((element) => element.name == v)
                  .toList();
              _workstatus.value = monthValue.first;
            },
            items: _statusListRes?.data!
                .map((e) => DropdownMenuItem(
                      value: e.name ?? "",
                      child: Text(
                        e.name ?? "",
                        style: TextStyles.getSubTita12(textColor: cBlackColor),
                      ),
                    ))
                .toList(),
            hintText: Text(
              "Work status",
              style: TextStyles.getSubTita12(textColor: cBlackColor),
            ),
          );
        });
  }

  Widget _projectWidget() {
    return ValueListenableBuilder(
        valueListenable: _project,
        builder: (context, value, child) {
          return CDropdownButton(
            borderRadius: BorderRadius.circular(8),
            value: _project.value?.pname ?? "",
            boaderColor: cGrayColor,
            onChanged: (v) async {
              final productValue = _getProductListRes?.data!
                  .where((element) => element.pname == v)
                  .toList();
              _project.value = productValue?.first;
              workStatusReset();
              await dataFromWorkStatusList();
            },
            items: _getProductListRes?.data!
                .map((e) => DropdownMenuItem(
                      value: e.pname ?? "",
                      child: Text(
                        e.pname ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.getSubTita12(textColor: cBlackColor),
                      ),
                    ))
                .toList(),
            hintText: Text(
              "Projects",
              style: TextStyles.getSubTita12(textColor: cBlackColor),
            ),
          );
        });
  }

  Widget _dateWidget() {
    String formattedDate = DateFormat('dd MMM yyyy').format(todayDate);

    return Container(
      decoration: BoxDecoration(
          color: cTextfeildBdrColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: cGrayColor)),
      height: 50,
      width: getWidth(context),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(formattedDate),
          )),
    );
  }

  Widget _workTypeWidget() {
    return ValueListenableBuilder(
        valueListenable: _workType,
        builder: (context, value, child) {
          return CDropdownButton(
            borderRadius: BorderRadius.circular(8),
            value: _workType.value?.workType ?? "",
            boaderColor: cGrayColor,
            onChanged: (v) async {
              final workValue = _workTypeListRes?.data!
                  .where((element) => element.workType == v)
                  .toList();
              _workType.value = workValue!.first;
              productReset();
              workStatusReset();
              await dataFromProductListList();
            },
            items: _workTypeListRes?.data!
                .map((e) => DropdownMenuItem(
                      value: e.workType ?? "",
                      child: Text(
                        e.workType ?? "",
                        style: TextStyles.getSubTita12(textColor: cBlackColor),
                      ),
                    ))
                .toList(),
            hintText: Text(
              "Work Type",
              style: TextStyles.getSubTita12(textColor: cBlackColor),
            ),
          );
        });
  }

  void productReset() async {
    _project.value = null;
  }

  void workStatusReset() async {
    _workstatus.value = null;
  }
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
          super.setState(fn);

    }
  }
  //apis calling ------------------- ------------------ --------------------- ---------------

//work status
  dataFromWorkStatusList() async {
    _isLoading.value = true;
    final userName = Preferences.getUserName();

    try {
      final statusPayload = {
        "getWorkStatus": true,
        "username": userName ?? "",
      };
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
    } catch (_) {
      showErrorMessage(context, "Error occured!!!");
    }
  }

//work releted
  dataFromWorkReletedList() async {
    _isLoading.value = true;
    final userName = Preferences.getUserName();

    try {
      final reletedPayload = {
        "getWorkRelated": true,
        "username": userName ?? "",
      };
      final _header = {
        'Ver': ApiServices.apiVer,
        "ApiKey": ApiServices.apiKey,
      };
      Response reletedResponse = await Dio().post(ApiServices.baseUrl,
          data: reletedPayload, options: Options(headers: _header));
      final reletedResult = WorkReletedListRes.fromJson(reletedResponse.data);
      _isLoading.value = false;
      setState(() {
        _reletedListRes = reletedResult;
      });
    } catch (_) {
      showErrorMessage(context, "Error occured!!!");
    }
  }

//work type
  dataFromWorkTypeList() async {
    _isLoading.value = true;
    final userName = Preferences.getUserName();

    try {
      final typePayload = {"getWorkType": true, "username": userName ?? ""};
      final _header = {
        'Ver': ApiServices.apiVer,
        "ApiKey": ApiServices.apiKey,
      };
      Response typeResponse = await Dio().post(ApiServices.baseUrl,
          data: typePayload, options: Options(headers: _header));
      final typeResult = WorkTypeListRes.fromJson(typeResponse.data);
      _isLoading.value = false;
      setState(() {
        _workTypeListRes = typeResult;
      });
    } catch (_) {
      showErrorMessage(context, "Error occured!!!");
    }
  }

//get product list
  dataFromProductListList() async {
    _isLoading.value = true;
    final userName = Preferences.getUserName();

    try {
      final productPayload = {"getProjects": true, "username": userName ?? ""};
      final _header = {
        'Ver': ApiServices.apiVer,
        "ApiKey": ApiServices.apiKey,
      };
      Response productResponse = await Dio().post(ApiServices.baseUrl,
          data: productPayload, options: Options(headers: _header));
      final productResult = GetProductListRes.fromJson(productResponse.data);
      _isLoading.value = false;
      setState(() {
        _getProductListRes = productResult;
      });
    } catch (_) {
      showErrorMessage(context, "Error occured!!!");
    }
  }

  @override
  void initState() {
    dataFromWorkReletedList();
    dataFromWorkTypeList();
    super.initState();
  }


//insert worklog
  dataFromCreateWorkLog() async {
    selectedList.value.forEach((item) {
      // Use regular expression to find and extract numeric values
      RegExp exp = RegExp(r'\b\d+\b');
      Iterable<RegExpMatch> matches = exp.allMatches(item);
      // Add each matched ID to the 'ids' list
      ids.addAll(matches.map((match) => match.group(0)!));

    });
         String result = ids.join(", ");

    _isLoading2.value = true;
    String formattedDate = DateFormat('yyyy-MM-dd').format(todayDate);
    final userName = Preferences.getUserName();

    try {
      final createPayload = {
        "insertWorkLog": true,
        "username": userName ?? "",
        "date": formattedDate,
        "work_type": _workType.value?.id ?? "",
        "work_related": result,
        "project": _project.value?.id ?? "",
        "work_details": _detailsController.text,
        "work_status": _workstatus.value?.id ?? "",
      };
      final _header = {
        'Ver': ApiServices.apiVer,
        "ApiKey": ApiServices.apiKey,
      };
      Response reletedResponse = await Dio().post(ApiServices.baseUrl,
          data: createPayload, options: Options(headers: _header));
      final reletedResult = CreateWorklogRes.fromJson(reletedResponse.data);
      _isLoading2.value = false;
      if (reletedResult.result == "success" &&
          (reletedResponse.statusCode == 200 ||
              reletedResponse.statusCode == 201)) {
        Get.back();
      } else {
        showErrorMessage(context, reletedResult.error ?? "");
      }
    } catch (_) {

      showErrorMessage(context, "Error occured!!!");
    }
  }
}
