class AdditionalClass {
  String? result;
  Data? data;

  AdditionalClass({this.result, this.data});

  AdditionalClass.fromJson(Map<String, dynamic> json) {
    result = json['result'];
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
  int? purchasedStatus;
  String? originalPrice;
  String? offerPrice;
  String? courseName;
  List<BatchList>? batchList;

  Data({this.purchasedStatus, this.courseName, this.originalPrice,this.offerPrice,this.batchList});

  Data.fromJson(Map<String, dynamic> json) {
    purchasedStatus = json['purchased_status'];
    courseName = json['course_name'];
    offerPrice = json['offer_price'];
    originalPrice = json['orginal_price'];
    if (json['batch_list'] != null) {
      batchList = <BatchList>[];
      json['batch_list'].forEach((v) {
        batchList!.add(new BatchList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['purchased_status'] = this.purchasedStatus;
    data['course_name'] = this.courseName;
     data['offer_price'] = this.offerPrice;
      data['orginal_price'] = this.originalPrice;
    if (this.batchList != null) {
      data['batch_list'] = this.batchList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BatchList {
  String? batchId;
  String? batchName;
  BatchList({this.batchId});

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




class AdditonalClass1 {
  String? result;
  AdditonalClass1Result? cassresult;

  AdditonalClass1({this.result,this.cassresult});

  AdditonalClass1.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    cassresult = json['data'] != null ? new AdditonalClass1Result.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.cassresult != null) {
      data['data'] = this.cassresult!.toJson();
    }
    return data;
  }
}

class AdditonalClass1Result {
  String? teacherName;
  List<ClassList>? classList;

  AdditonalClass1Result({this.classList});

  AdditonalClass1Result.fromJson(Map<String, dynamic> json) {
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



class AdditonalClassVideo {
  String? result;
  Video? data;

  AdditonalClassVideo({this.result, this.data});

  AdditonalClassVideo.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    data = json['data'] != null ? new Video.fromJson(json['data']) : null;
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

class Video {
  String? videoUrl;

  Video({this.videoUrl});

  Video.fromJson(Map<String, dynamic> json) {
    videoUrl = json['video_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video_url'] = this.videoUrl;
    return data;
  }
}
