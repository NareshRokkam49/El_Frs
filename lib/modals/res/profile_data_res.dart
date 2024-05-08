class ProfileDataRes {
  bool? profileData;
  String? result;
  String? name;
  String? employeeId;
  String? userlevel;
  String? designation;
  String? mobile;
  String? email;
  String? employeeProfile;
  String? employeeProfilePath;
  String? error;

  ProfileDataRes(
      {this.profileData,
      this.result,
      this.name,
      this.employeeId,
      this.userlevel,
      this.designation,
      this.mobile,
      this.email,
      this.employeeProfile,
      this.employeeProfilePath,
      this.error
      });

  ProfileDataRes.fromJson(Map<String, dynamic> json) {
    profileData = json['profileData'];
    result = json['result'];
    name = json['name'];
    employeeId = json['employee_id'];
    userlevel = json['userlevel'];
    designation = json['designation'];
    mobile = json['mobile'];
    email = json['email'];
    employeeProfile = json['employee_profile'];
    employeeProfilePath = json['employee_profile_path'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profileData'] = this.profileData;
    data['result'] = this.result;
    data['name'] = this.name;
    data['employee_id'] = this.employeeId;
    data['userlevel'] = this.userlevel;
    data['designation'] = this.designation;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['employee_profile'] = this.employeeProfile;
    data['employee_profile_path'] = this.employeeProfilePath;
        data['error'] = this.error;

    return data;
  }
}
