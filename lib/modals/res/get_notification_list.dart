class GetNotificationListRes {
  List<Data>? data;
  bool? getNotifications;
  String? result;
  int? totalCnt;

  GetNotificationListRes(
      {this.data, this.getNotifications, this.result, this.totalCnt});

  GetNotificationListRes.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    getNotifications = json['getNotifications'];
    result = json['result'];
    totalCnt = json['total_cnt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['getNotifications'] = this.getNotifications;
    data['result'] = this.result;
    data['total_cnt'] = this.totalCnt;
    return data;
  }
}

class Data {
  String? id;
  String? employeeId;
  String? title;
  String? message;
  String? status;
  String? timestamp;

  Data(
      {this.id,
      this.employeeId,
      this.title,
      this.message,
      this.status,
      this.timestamp});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    title = json['title'];
    message = json['message'];
    status = json['status'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_id'] = this.employeeId;
    data['title'] = this.title;
    data['message'] = this.message;
    data['status'] = this.status;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
