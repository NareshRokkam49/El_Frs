class ImageUploadingRes {
  List<Null>? data;
  bool? uploadFile;
  String? filename;
  String? result;
  String? filepath;
  String? error;

  ImageUploadingRes(
      {this.data,
      this.uploadFile,
      this.filename,
      this.result,
      this.filepath,
      this.error});

  ImageUploadingRes.fromJson(Map<String, dynamic> json) {
   
    uploadFile = json['uploadFile'];
    filename = json['filename'];
    result = json['result'];
    filepath = json['filepath'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   
    data['uploadFile'] = this.uploadFile;
    data['filename'] = this.filename;
    data['result'] = this.result;
    data['filepath'] = this.filepath;
    data['error'] = this.error;
    return data;
  }
}
