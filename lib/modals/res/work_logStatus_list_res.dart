class WorklogStatusListRes {
  List<StatusData>? data;
  bool? getWorkStatus;
  String? result;
  String? error;

  WorklogStatusListRes(
      {this.data, this.getWorkStatus, this.result, this.error});

  WorklogStatusListRes.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <StatusData>[];
      json['data'].forEach((v) {
        data!.add(new StatusData.fromJson(v));
      });
    }
    getWorkStatus = json['getWorkStatus'];
    result = json['result'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['getWorkStatus'] = this.getWorkStatus;
    data['result'] = this.result;
    data['error'] = this.error;
    return data;
  }
}

class StatusData {
  String? id;
  String? name;
  String? delFlag;

  StatusData({this.id, this.name, this.delFlag});

  StatusData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    delFlag = json['del_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['del_flag'] = this.delFlag;
    return data;
  }
}
