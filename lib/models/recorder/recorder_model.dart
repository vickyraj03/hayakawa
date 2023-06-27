class recorderModel {
  String? result;
  RecorderData? data;

  recorderModel({this.result, this.data});

  recorderModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    data = json['data'] != null ?  RecorderData.fromJson(json['data']) : null;
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

class RecorderData {
  String? courseName;
  String? teacherName;
  List<BatchList>? batchList;

  RecorderData({this.courseName, this.teacherName, this.batchList});

  RecorderData.fromJson(Map<String, dynamic> json) {
    courseName = json['course_name'];
    teacherName = json['teacher_name'];
    if (json['batch_list'] != null) {
      batchList = <BatchList>[];
      json['batch_list'].forEach((v) {
        batchList!.add(new BatchList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_name'] = this.courseName;
    data['teacher_name'] = this.teacherName;
    if (this.batchList != null) {
      data['batch_list'] = this.batchList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BatchList {
  String? batchId;
  String? batchName;

  BatchList({this.batchId, this.batchName});

  BatchList.fromJson(Map<String, dynamic> json) {
    batchId = json['batch_id'];
    batchName = json['batch_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batch_id'] = this.batchId;
    data['batch_name'] = this.batchName;
    return data;
  }
}
