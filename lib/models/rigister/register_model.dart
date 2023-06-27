class Register {
  String? result;
   String? message;
  RegisterData? data;

  Register({this.result, this.data, this.message});

  Register.fromJson(Map<String, dynamic> json) {
    result = json['result'];
     message = json['message'];
    data = json['data'] != null ? new RegisterData.fromJson(json['data']) : null;
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

class RegisterData {
  String? username;
  String? name;
  int? studentId;
  String? pictures;

  RegisterData({this.username, this.name, this.studentId, this.pictures});

  RegisterData.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['name'];
    studentId = json['student_id'];
    pictures = json['pictures'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['name'] = this.name;
    data['student_id'] = this.studentId;
    data['pictures'] = this.pictures;
    return data;
  }
}
