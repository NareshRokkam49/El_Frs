class GetLeaveTypeRes {
  List<LeaveTypeData>? data;
  bool? getLeaveType;
  String? result;
  String? error;

  GetLeaveTypeRes({this.data, this.getLeaveType, this.result, this.error});

  GetLeaveTypeRes.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <LeaveTypeData>[];
      json['data'].forEach((v) {
        data!.add(new LeaveTypeData.fromJson(v));
      });
    }
    getLeaveType = json['GetLeaveType'];
    result = json['result'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['GetLeaveType'] = this.getLeaveType;
    data['result'] = this.result;
    data['error'] = this.error;
    return data;
  }
}

class LeaveTypeData {
  String? id;
  String? leaveType;

  LeaveTypeData({this.id, this.leaveType});

  LeaveTypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leaveType = json['leave_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leave_type'] = this.leaveType;
    return data;
  }
}
