class CompleteClassModel {
  String? result;
  String? message;
  List<Completeclassresult>? data;
  String? data1;

  CompleteClassModel({this.result, this.message, this.data});

  CompleteClassModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['data'] != "Batch is not available") {
      data = <Completeclassresult>[];
      json['data'].forEach((v) {
        data!.add(new Completeclassresult.fromJson(v));
      });
    }else{
      data1 = json['data'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Completeclassresult {
  JlptStatus? jlptStatus;
  CourseHistory? courseHistory;
  TblCourse? tblCourse;
  Others? others;
  Batch? batch;

  Completeclassresult(
      {this.jlptStatus,
      this.courseHistory,
      this.tblCourse,
      this.others,
      this.batch});

  Completeclassresult.fromJson(Map<String, dynamic> json) {
    jlptStatus = json['jlpt_status'] != null
        ? new JlptStatus.fromJson(json['jlpt_status'])
        : null;
    courseHistory = json['course_history'] != null
        ? new CourseHistory.fromJson(json['course_history'])
        : null;
    tblCourse = json['tbl_course'] != null
        ? new TblCourse.fromJson(json['tbl_course'])
        : null;
    others =
        json['others'] != null ? new Others.fromJson(json['others']) : null;
    batch = json['batch'] != null ? new Batch.fromJson(json['batch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jlptStatus != null) {
      data['jlpt_status'] = this.jlptStatus!.toJson();
    }
    if (this.courseHistory != null) {
      data['course_history'] = this.courseHistory!.toJson();
    }
    if (this.tblCourse != null) {
      data['tbl_course'] = this.tblCourse!.toJson();
    }
    if (this.others != null) {
      data['others'] = this.others!.toJson();
    }
    if (this.batch != null) {
      data['batch'] = this.batch!.toJson();
    }
    return data;
  }
}

class JlptStatus {
  String? testYearId;
  String? applicationDate;
  String? examDate;
  String? jlptStatus;

  JlptStatus(
      {this.testYearId, this.applicationDate, this.examDate, this.jlptStatus});

  JlptStatus.fromJson(Map<String, dynamic> json) {
    testYearId = json['test_year_id'];
    applicationDate = json['application_date'];
    examDate = json['exam_date'];
    jlptStatus = json['jlpt_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['test_year_id'] = this.testYearId;
    data['application_date'] = this.applicationDate;
    data['exam_date'] = this.examDate;
    data['jlpt_status'] = this.jlptStatus;
    return data;
  }
}

class CourseHistory {
  String? crhId;
  String? courseId;
  String? batchId;

  CourseHistory({this.crhId, this.courseId, this.batchId});

  CourseHistory.fromJson(Map<String, dynamic> json) {
    crhId = json['crh_id'];
    courseId = json['course_id'];
    batchId = json['batch_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['crh_id'] = this.crhId;
    data['course_id'] = this.courseId;
    data['batch_id'] = this.batchId;
    return data;
  }
}

class TblCourse {
  String? courseName;
  String? jlptlevel;
  String? videoLink;
  String? videoStatus;
  String? courseType;
  String? progType;
  String? courseDuration;

  TblCourse(
      {this.courseName,
      this.jlptlevel,
      this.videoLink,
      this.videoStatus,
      this.courseType,
      this.progType,
      this.courseDuration});

  TblCourse.fromJson(Map<String, dynamic> json) {
    courseName = json['course_name'];
    jlptlevel = json['jlptlevel'];
    videoLink = json['video_link'];
    videoStatus = json['video_status'];
    courseType = json['course_type'];
    progType = json['prog_type'];
    courseDuration = json['course_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_name'] = this.courseName;
    data['jlptlevel'] = this.jlptlevel;
    data['video_link'] = this.videoLink;
    data['video_status'] = this.videoStatus;
    data['course_type'] = this.courseType;
    data['prog_type'] = this.progType;
    data['course_duration'] = this.courseDuration;
    return data;
  }
}

class Others {
  String? jlptyearStatus;
  String? mocktestStatus;
  int? expiredYear;
  String? courseName;
  String? startDate;
  String? endDate;
  String? reactivestatus;
  String? rejoinstatus;
  String? expiredDate;
  String? jlptLink;

  Others(
      {this.jlptyearStatus,
      this.mocktestStatus,
      this.expiredYear,
      this.courseName,
      this.startDate,
      this.endDate,
      this.reactivestatus,
      this.rejoinstatus,
      this.expiredDate,
      this.jlptLink});

  Others.fromJson(Map<String, dynamic> json) {
    jlptyearStatus = json['jlptyear_status'];
    mocktestStatus = json['mocktest_status'];
    expiredYear = json['expiredYear'];
    courseName = json['courseName'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    reactivestatus = json['reactivestatus'];
    rejoinstatus = json['rejoinstatus'];
    expiredDate = json['expiredDate'];
    jlptLink = json['jlpt_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jlptyear_status'] = this.jlptyearStatus;
    data['mocktest_status'] = this.mocktestStatus;
    data['expiredYear'] = this.expiredYear;
    data['courseName'] = this.courseName;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['reactivestatus'] = this.reactivestatus;
    data['rejoinstatus'] = this.rejoinstatus;
    data['expiredDate'] = this.expiredDate;
    data['jlpt_link'] = this.jlptLink;
    return data;
  }
}

class Batch {
  String? id;
  String? franId;
  String? teacherId;
  String? courseId;
  String? batchName;
  String? batchDetails;
  String? jlptlevel;
  String? date;
  String? month;
  String? year;
  String? edate;
  String? emonth;
  String? eyear;
  String? startDate;
  String? endDate;
  String? timing;
  String? batchOffer;
  String? batchSchedule;
  String? seats;
  String? status;
  String? modifiedDate;
  String? createdDate;
  String? batchScheduleUrl;

  Batch(
      {this.id,
      this.franId,
      this.teacherId,
      this.courseId,
      this.batchName,
      this.batchDetails,
      this.jlptlevel,
      this.date,
      this.month,
      this.year,
      this.edate,
      this.emonth,
      this.eyear,
      this.startDate,
      this.endDate,
      this.timing,
      this.batchOffer,
      this.batchSchedule,
      this.seats,
      this.status,
      this.modifiedDate,
      this.createdDate,
      this.batchScheduleUrl});

  Batch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    franId = json['fran_id'];
    teacherId = json['teacher_id'];
    courseId = json['course_id'];
    batchName = json['batch_name'];
    batchDetails = json['batch_details'];
    jlptlevel = json['jlptlevel'];
    date = json['date'];
    month = json['month'];
    year = json['year'];
    edate = json['edate'];
    emonth = json['emonth'];
    eyear = json['eyear'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    timing = json['timing'];
    batchOffer = json['batch_offer'];
    batchSchedule = json['batch_schedule'];
    seats = json['seats'];
    status = json['status'];
    modifiedDate = json['modified_date'];
    createdDate = json['created_date'];
    batchScheduleUrl = json['batch_schedule_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fran_id'] = this.franId;
    data['teacher_id'] = this.teacherId;
    data['course_id'] = this.courseId;
    data['batch_name'] = this.batchName;
    data['batch_details'] = this.batchDetails;
    data['jlptlevel'] = this.jlptlevel;
    data['date'] = this.date;
    data['month'] = this.month;
    data['year'] = this.year;
    data['edate'] = this.edate;
    data['emonth'] = this.emonth;
    data['eyear'] = this.eyear;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['timing'] = this.timing;
    data['batch_offer'] = this.batchOffer;
    data['batch_schedule'] = this.batchSchedule;
    data['seats'] = this.seats;
    data['status'] = this.status;
    data['modified_date'] = this.modifiedDate;
    data['created_date'] = this.createdDate;
    data['batch_schedule_url'] = this.batchScheduleUrl;
    return data;
  }
}
