class recorderClassModel {
  String? result;
  RecorderClass? data;

  recorderClassModel({this.result, this.data});

  recorderClassModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    data = json['data'] != null ?  RecorderClass.fromJson(json['data']) : null;
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

class RecorderClass {
   String? teacherName;
  List<ClassList>? classList;

  RecorderClass({this.classList});

  RecorderClass.fromJson(Map<String, dynamic> json) {
      teacherName = json['teacher_name'];
    if (json['class_list'] != null) {
      classList = <ClassList>[];
      json['class_list'].forEach((v) {
        classList!.add(new ClassList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teacher_name'] = this.teacherName;
    if (this.classList != null) {
      data['class_list'] = this.classList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClassList {
  String? id;
  String? className;

  ClassList({this.id, this.className});

  ClassList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    className = json['class_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['class_name'] = this.className;
    return data;
  }
}
