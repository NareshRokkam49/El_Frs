class WorkReletedListRes {
  List<ReletedData>? data;
  bool? getWorkRelated;
  String? result;
  String? error;

  WorkReletedListRes({this.data, this.getWorkRelated, this.result, this.error});

  WorkReletedListRes.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ReletedData>[];
      json['data'].forEach((v) {
        data!.add(new ReletedData.fromJson(v));
      });
    }
    getWorkRelated = json['getWorkRelated'];
    result = json['result'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['getWorkRelated'] = this.getWorkRelated;
    data['result'] = this.result;
    data['error'] = this.error;
    return data;
  }
}

class ReletedData {
  String? id;
  String? name;
  String? delFlag;

  ReletedData({this.id, this.name, this.delFlag});

  ReletedData.fromJson(Map<String, dynamic> json) {
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
