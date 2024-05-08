class UpdateNotificationStatusRes {
  List<Null>? data;
  bool? updateNotificationStatus;
  String? result;

  UpdateNotificationStatusRes(
      {this.data, this.updateNotificationStatus, this.result});

  UpdateNotificationStatusRes.fromJson(Map<String, dynamic> json) {
   
    updateNotificationStatus = json['updateNotificationStatus'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   
    data['updateNotificationStatus'] = this.updateNotificationStatus;
    data['result'] = this.result;
    return data;
  }
}
