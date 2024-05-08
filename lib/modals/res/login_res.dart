class LoginRes {
  List<Null>? data;
  bool? login;
  String? result;
  String? username;
  String? name;
  String? mobile;
  String? email;
  String? userlevel;
  String? designation;
  String? employeeId;
  String? employeeName;
  String? filepath;
  String? companyName;
  String? companyLogo;
  String? companyAddress;
  String? employeeProfile;
  String? checkInTime;
  String? checkInDate;
  String? checkOutDate;
  String? checkOutTime;
  String?error;

  LoginRes(
      {this.data,
      this.login,
      this.result,
      this.username,
      this.name,
      this.mobile,
      this.email,
      this.userlevel,
      this.designation,
      this.employeeId,
      this.employeeName,
      this.filepath,
      this.companyName,
      this.companyLogo,
      this.companyAddress,
      this.employeeProfile,
      this.checkInTime,
      this.checkInDate,
      this.checkOutDate,
      this.checkOutTime,
      this.error,
      });

  LoginRes.fromJson(Map<String, dynamic> json) {
  
    login = json['login'];
    result = json['result'];
    username = json['username'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    userlevel = json['userlevel'];
    designation = json['designation'];
    employeeId = json['employee_id'];
    employeeName = json['employee_name'];
    filepath = json['filepath'];
    companyName = json['company_name'];
    companyLogo = json['company_logo'];
    companyAddress = json['company_address'];
    employeeProfile = json['employee_profile'];
    checkInTime = json['check_in_time'];
    checkInDate = json['check_in_date'];
    checkOutDate = json['check_out_date'];
    checkOutTime = json['check_out_time'];
    error=json["error"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   
    data['login'] = this.login;
    data['result'] = this.result;
    data['username'] = this.username;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['userlevel'] = this.userlevel;
    data['designation'] = this.designation;
    data['employee_id'] = this.employeeId;
    data['employee_name'] = this.employeeName;
    data['filepath'] = this.filepath;
    data['company_name'] = this.companyName;
    data['company_logo'] = this.companyLogo;
    data['company_address'] = this.companyAddress;
    data['employee_profile'] = this.employeeProfile;
    data['check_in_time'] = this.checkInTime;
    data['check_in_date'] = this.checkInDate;
    data['check_out_date'] = this.checkOutDate;
    data['check_out_time'] = this.checkOutTime;
        data['error'] = this.error;

    return data;
  }
}
