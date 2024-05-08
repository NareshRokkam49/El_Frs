class GetProductListRes {
  List<ProductData>? data;
  bool? getProjects;
  String? result;
  String? error;

  GetProductListRes({this.data, this.getProjects, this.result, this.error});

  GetProductListRes.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProductData>[];
      json['data'].forEach((v) {
        data!.add(new ProductData.fromJson(v));
      });
    }
    getProjects = json['getProjects'];
    result = json['result'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['getProjects'] = this.getProjects;
    data['result'] = this.result;
    data['error'] = this.error;
    return data;
  }
}

class ProductData {
  String? id;
  String? pname;
  String? delFlag;

  ProductData({this.id, this.pname, this.delFlag});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pname = json['pname'];
    delFlag = json['del_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pname'] = this.pname;
    data['del_flag'] = this.delFlag;
    return data;
  }
}
