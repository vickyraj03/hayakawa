class Login {
  String? result;
  String? message;
  Data? data;

  Login({this.result, this.data, this.message});

  Login.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? username;
  String? name;
  String? mobile;
  String? studentId;
  String? pictures;

  Data({this.username, this.name, this.mobile, this.studentId, this.pictures});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['name'];
    mobile = json['mobile'];
    studentId = json['student_id'];
    pictures = json['pictures'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['student_id'] = this.studentId;
    data['pictures'] = this.pictures;
    return data;
  }
}
