class EmployeeDetailsRes {
  List<EmployeeData>? data;
  bool? employeeDetails;
  String? result;
 String?error;

  EmployeeDetailsRes({this.data, this.employeeDetails, this.result,this.error});

  EmployeeDetailsRes.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <EmployeeData>[];
      json['data'].forEach((v) {
        data!.add(new EmployeeData.fromJson(v));
      });
    }
    employeeDetails = json['EmployeeDetails'];
    result = json['result'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['EmployeeDetails'] = this.employeeDetails;
    data['result'] = this.result;
        data['error'] = this.error;

    return data;
  }
}

class EmployeeData {
  int? attendanceStatus;
  String? checkinStatus;
  String? checkoutStatus;
  int? breakStatus;
  String? checkindate;
  String? checkintime;
  String? checkoutdate;
  String? checkouttime;
  String? effectiveHours;
  String? notificationCnt;
  List<BreakDuration>? breakDuration;
  String? employeeId;
  String? name;
  String? mobile;
  String? designation;
  String? email;
  String? latitude;
  String? longitude;
  String? filepath;
  String? profileImage;

  EmployeeData(
      {this.attendanceStatus,
      this.checkinStatus,
      this.checkoutStatus,
      this.breakStatus,
      this.checkindate,
      this.checkintime,
      this.checkoutdate,
      this.checkouttime,
      this.effectiveHours,
      this.notificationCnt,
      this.breakDuration,
      this.employeeId,
      this.name,
      this.mobile,
      this.designation,
      this.email,
      this.latitude,
      this.longitude,
      this.filepath,
      this.profileImage});

  EmployeeData.fromJson(Map<String, dynamic> json) {
    attendanceStatus = json['attendance_status'];
    checkinStatus = json['checkin_status'];
    checkoutStatus = json['checkout_status'];
    breakStatus = json['break_status'];
    checkindate = json['checkindate'];
    checkintime = json['checkintime'];
    checkoutdate = json['checkoutdate'];
    checkouttime = json['checkouttime'];
    effectiveHours = json['effective_hours'];
    notificationCnt = json['notification_cnt'];
    if (json['break_duration'] != null) {
      breakDuration = <BreakDuration>[];
      json['break_duration'].forEach((v) {
        breakDuration!.add(new BreakDuration.fromJson(v));
      });
    }
    employeeId = json['employee_id'];
    name = json['name'];
    mobile = json['mobile'];
    designation = json['designation'];
    email = json['email'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    filepath = json['filepath'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attendance_status'] = this.attendanceStatus;
    data['checkin_status'] = this.checkinStatus;
    data['checkout_status'] = this.checkoutStatus;
    data['break_status'] = this.breakStatus;
    data['checkindate'] = this.checkindate;
    data['checkintime'] = this.checkintime;
    data['checkoutdate'] = this.checkoutdate;
    data['checkouttime'] = this.checkouttime;
    data['effective_hours'] = this.effectiveHours;
    data['notification_cnt'] = this.notificationCnt;
    if (this.breakDuration != null) {
      data['break_duration'] =
          this.breakDuration!.map((v) => v.toJson()).toList();
    }
    data['employee_id'] = this.employeeId;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['designation'] = this.designation;
    data['email'] = this.email;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['filepath'] = this.filepath;
    data['profile_image'] = this.profileImage;
    return data;
  }
}

class BreakDuration {
  String? breakStart;
  String? breakResume;
  String? breakDuration;

  BreakDuration({this.breakStart, this.breakResume, this.breakDuration});

  BreakDuration.fromJson(Map<String, dynamic> json) {
    breakStart = json['break_start'];
    breakResume = json['break_resume'];
    breakDuration = json['break_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['break_start'] = this.breakStart;
    data['break_resume'] = this.breakResume;
    data['break_duration'] = this.breakDuration;
    return data;
  }
}
