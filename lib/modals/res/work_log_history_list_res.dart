class WorklogHistoryListRes {
  List<HistoryData>? data;
  bool? getWorkLogHistory;
  String? month;
  String? year;
  String? result;
  String? error;

  WorklogHistoryListRes(
      {this.data,
      this.getWorkLogHistory,
      this.month,
      this.year,
      this.result,
      this.error});

  WorklogHistoryListRes.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <HistoryData>[];
      json['data'].forEach((v) {
        data!.add(new HistoryData.fromJson(v));
      });
    }
    getWorkLogHistory = json['getWorkLogHistory'];
    month = json['month'];
    year = json['Year'];
    result = json['result'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['getWorkLogHistory'] = this.getWorkLogHistory;
    data['month'] = this.month;
    data['Year'] = this.year;
    data['result'] = this.result;
    data['error'] = this.error;
    return data;
  }
}

class HistoryData {
  String? date;
  String? workType;
  String? workRelated;
  String? project;
  String? status;
  String? submittedOn;

  HistoryData(
      {this.date,
      this.workType,
      this.workRelated,
      this.project,
      this.status,
      this.submittedOn});

  HistoryData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    workType = json['work_type'];
    workRelated = json['work_related'];
    project = json['project'];
    status = json['status'];
    submittedOn = json['submitted_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['work_type'] = this.workType;
    data['work_related'] = this.workRelated;
    data['project'] = this.project;
    data['status'] = this.status;
    data['submitted_on'] = this.submittedOn;
    return data;
  }
}
