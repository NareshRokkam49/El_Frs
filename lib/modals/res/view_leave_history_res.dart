class ViewLeaveHistoryRes {
  List<HistoryData>? data;
  bool? getLeaveHistory;
  String? result;

  ViewLeaveHistoryRes({this.data, this.getLeaveHistory, this.result});

  ViewLeaveHistoryRes.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <HistoryData>[];
      json['data'].forEach((v) {
        data!.add(new HistoryData.fromJson(v));
      });
    }
    getLeaveHistory = json['getLeaveHistory'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['getLeaveHistory'] = this.getLeaveHistory;
    data['result'] = this.result;
    return data;
  }
}

class HistoryData {
  String? id;
  String? fromDate;
  String? toDate;
  String? appliedDuration;
  String? typeOfLeave;
  String? leaveReason;
  String? remarks;
  String? status;

  HistoryData(
      {this.id,
      this.fromDate,
      this.toDate,
      this.appliedDuration,
      this.typeOfLeave,
      this.leaveReason,
      this.remarks,
      this.status});

  HistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    appliedDuration = json['applied_duration'];
    typeOfLeave = json['type_of_leave'];
    leaveReason = json['leave_reason'];
    remarks = json['remarks'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['applied_duration'] = this.appliedDuration;
    data['type_of_leave'] = this.typeOfLeave;
    data['leave_reason'] = this.leaveReason;
    data['remarks'] = this.remarks;
    data['status'] = this.status;
    return data;
  }
}
