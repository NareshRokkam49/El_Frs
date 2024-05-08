class LeavesListRes {
  List<LeavesData>? data;
  bool? getLeaveCalculation;
  List<LeaveHistory>? leaveHistory;
  String? result;
  String? error;

  LeavesListRes(
      {this.data,
      this.getLeaveCalculation,
      this.leaveHistory,
      this.result,
      this.error});

  LeavesListRes.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <LeavesData>[];
      json['data'].forEach((v) {
        data!.add(new LeavesData.fromJson(v));
      });
    }
    getLeaveCalculation = json['getLeaveCalculation'];
    if (json['leave_history'] != null) {
      leaveHistory = <LeaveHistory>[];
      json['leave_history'].forEach((v) {
        leaveHistory!.add(new LeaveHistory.fromJson(v));
      });
    }
    result = json['result'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['getLeaveCalculation'] = this.getLeaveCalculation;
    if (this.leaveHistory != null) {
      data['leave_history'] =
          this.leaveHistory!.map((v) => v.toJson()).toList();
    }
    data['result'] = this.result;
    data['error'] = this.error;
    return data;
  }
}

class LeavesData {
  int? totalLeaves;
  int? leaveUsed;
  int? leaveBalance;
  int? leavePercentage;
  int? unpaidLeave;

  LeavesData(
      {this.totalLeaves,
      this.leaveUsed,
      this.leaveBalance,
      this.leavePercentage,
      this.unpaidLeave});

  LeavesData.fromJson(Map<String, dynamic> json) {
    totalLeaves = json['total_leaves'];
    leaveUsed = json['leave_used'];
    leaveBalance = json['leave_balance'];
    leavePercentage = json['leave_percentage'];
    unpaidLeave = json['unpaid_leave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_leaves'] = this.totalLeaves;
    data['leave_used'] = this.leaveUsed;
    data['leave_balance'] = this.leaveBalance;
    data['leave_percentage'] = this.leavePercentage;
    data['unpaid_leave'] = this.unpaidLeave;
    return data;
  }
}

class LeaveHistory {
  int? casualLeave;
  int? sickLeave;

  LeaveHistory({this.casualLeave, this.sickLeave});

  LeaveHistory.fromJson(Map<String, dynamic> json) {
    casualLeave = json['casual_leave'];
    sickLeave = json['sick_leave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['casual_leave'] = this.casualLeave;
    data['sick_leave'] = this.sickLeave;
    return data;
  }
}
