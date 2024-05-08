class AttandanceHistoryRes {
  List<Data>? data;
  String? month;
  String? year;
  String? result;

  AttandanceHistoryRes({this.data, this.month, this.year, this.result});

  AttandanceHistoryRes.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    month = json['month'];
    year = json['Year'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['month'] = this.month;
    data['Year'] = this.year;
    data['result'] = this.result;
    return data;
  }
}

class Data {
  String? date;
  String? monthDate;
  String? checkIn;
  String? checkOut;
  String? checkInStatus;
  String? checkOutStatus;
  String? durationStatus;
  List<Null>? breakDuration;
  String? duration;
  String? day;
  String? dayType;

  Data(
      {this.date,
      this.monthDate,
      this.checkIn,
      this.checkOut,
      this.checkInStatus,
      this.checkOutStatus,
      this.durationStatus,
      this.breakDuration,
      this.duration,
      this.day,
      this.dayType});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    monthDate = json['month_date'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    checkInStatus = json['check_in_status'];
    checkOutStatus = json['check_out_status'];
    durationStatus = json['duration_status'];
  
    duration = json['duration'];
    day = json['day'];
    dayType = json['day_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['month_date'] = this.monthDate;
    data['check_in'] = this.checkIn;
    data['check_out'] = this.checkOut;
    data['check_in_status'] = this.checkInStatus;
    data['check_out_status'] = this.checkOutStatus;
    data['duration_status'] = this.durationStatus;
   
    data['duration'] = this.duration;
    data['day'] = this.day;
    data['day_type'] = this.dayType;
    return data;
  }
}
