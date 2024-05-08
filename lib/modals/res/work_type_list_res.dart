class WorkTypeListRes {
  List<TypeData>? data;
  bool? getWorkType;
  String? result;
  String? error;

  WorkTypeListRes({this.data, this.getWorkType, this.result, this.error});

  WorkTypeListRes.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TypeData>[];
      json['data'].forEach((v) {
        data!.add(new TypeData.fromJson(v));
      });
    }
    getWorkType = json['getWorkType'];
    result = json['result'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['getWorkType'] = this.getWorkType;
    data['result'] = this.result;
    data['error'] = this.error;
    return data;
  }
}

class TypeData {
  String? id;
  String? workType;
  String? delFlag;

  TypeData({this.id, this.workType, this.delFlag});

  TypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workType = json['work_type'];
    delFlag = json['del_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['work_type'] = this.workType;
    data['del_flag'] = this.delFlag;
    return data;
  }
}
