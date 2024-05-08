class CreateWorklogRes {
  List<Data>? data;
  bool? insertWorkLog;
  String? result;
  String? error;

  CreateWorklogRes({this.data, this.insertWorkLog, this.result, this.error});

  CreateWorklogRes.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    insertWorkLog = json['insertWorkLog'];
    result = json['result'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['insertWorkLog'] = this.insertWorkLog;
    data['result'] = this.result;
    data['error'] = this.error;
    return data;
  }
}

class Data {
  String? employeeId;

  Data({this.employeeId});

  Data.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this.employeeId;
    return data;
  }
}
