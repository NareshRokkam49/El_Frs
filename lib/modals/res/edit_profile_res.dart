class EditProfileRes {
  List<Null>? data;
  bool? editProfile;
  String? employeeId;
  String? result;
  String? error;

  EditProfileRes(
      {this.data, this.editProfile, this.employeeId, this.result, this.error});

  EditProfileRes.fromJson(Map<String, dynamic> json) {
   
    editProfile = json['edit_profile'];
    employeeId = json['employee_id'];
    result = json['result'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
  
    data['edit_profile'] = this.editProfile;
    data['employee_id'] = this.employeeId;
    data['result'] = this.result;
    data['error'] = this.error;
    return data;
  }
}
