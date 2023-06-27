class LoginRequest {
  String email;
  String password;
  LoginRequest(this.email, this.password);
  Map<String, dynamic> toJson() =>
      {'email': email, 'password': password, 'type': 'login'};
}

class RegisterRequest {
  String? name;
  String? email;
  String? mobile;
  String? country;
  RegisterRequest(this.name, this.email, this.mobile, this.country);
  Map<String, dynamic> toJson() =>
      {"name": name, "emails": email, "mobile": mobile, "country": country};
}

class ForgotPasswordRequest {
  String email;

  ForgotPasswordRequest(this.email);
  Map<String, dynamic> toJson() => {
        "email": email,
      };
}


class BatchRequest {
  String studentId;
  String crh_id;
  String jlptlevel;

  BatchRequest(this.studentId,this.crh_id,this.jlptlevel);
  Map<String, dynamic> toJson() => {
      "studentId" : studentId,//"38950412",
      "crh_id" : crh_id,//"29653",
      "jlptlevel" : jlptlevel//"C1"
      };
}



class ClassRequest {
 String batchId;

  ClassRequest(this.batchId);
  Map<String, dynamic> toJson() => {
     "batch_id" : batchId//"491"
      };
}


class VideoRequest {
 String classId;

  VideoRequest(this.classId);
  Map<String, dynamic> toJson() => {
     "class_id" : classId//"491"
      };
}


class AdditionalRequest {
 String studentId;
  String crh_id;
  String jlptlevel;
  AdditionalRequest(this.studentId,this.crh_id,this.jlptlevel);
  Map<String, dynamic> toJson() => {
     
    "studentId" : studentId,//"38953663",
    "jlptlevel" : jlptlevel,//"C1",
    "crh_id" : crh_id//"25562"
      };
}

class AdditionalClassRequest {
 String batchId;
  
  AdditionalClassRequest(this.batchId);
  Map<String, dynamic> toJson() => {
     
    "batch_id" : batchId,//"38953663",
 
      };
}


class AdditionalVideoRequest {
 String classId;
  
  AdditionalVideoRequest(this.classId);
  Map<String, dynamic> toJson() => {
     
    "studentId" : classId,//"38953663",
 
      };
}