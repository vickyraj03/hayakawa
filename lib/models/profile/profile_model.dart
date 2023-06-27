class profileModel {
  String? result;
  Profiledata? data;

  profileModel({this.result, this.data});

  profileModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    data = json['data'] != null ?  Profiledata.fromJson(json['data']) : null;
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

class Profiledata {
  String? id;
  String? franId;
  String? enrollNo;
  String? progType;
  String? testLevel;
  String? testSite;
  String? name;
  String? familyName;
  String? sex;
  String? year;
  String? month;
  String? date;
  String? nationality;
  String? nativeLanguage;
  String? street;
  String? city;
  String? country;
  String? postalCode;
  String? telephoneCode;
  String? telephone;
  String? mobileCode;
  String? mobile;
  String? fax;
  String? email;
  String? skypeId;
  String? occupation;
  String? institution;
  String? numberOfHours;
  String? reason;
  String? education;
  String? referenceFrom;
  String? japaneseProficiency;
  String? imagetype;
  String? pictures;
  String? photos;
  String? jlptCertificatePath;
  String? technicalSheetPath;
  String? resumePath;
  String? otherLanguage;
  String? kwnAbtus;
  String? spReason;
  String? stat;
  String? paymentOption;
  String? networkSite;
  String? upgradeRequest;
  String? logdate;
  String? staffId;
  String? completedDate;
  String? modifiedDate;
  String? otherQualification;
  String? createdDate;
  String? reqName;
  String? reqFamilyName;
  String? reqDob;
  String? reqPictures;
  String? reqDate;
  String? dobIdProof;
  String? source;
  String? nlSpecify;

  Profiledata(
      {this.id,
      this.franId,
      this.enrollNo,
      this.progType,
      this.testLevel,
      this.testSite,
      this.name,
      this.familyName,
      this.sex,
      this.year,
      this.month,
      this.date,
      this.nationality,
      this.nativeLanguage,
      this.street,
      this.city,
      this.country,
      this.postalCode,
      this.telephoneCode,
      this.telephone,
      this.mobileCode,
      this.mobile,
      this.fax,
      this.email,
      this.skypeId,
      this.occupation,
      this.institution,
      this.numberOfHours,
      this.reason,
      this.education,
      this.referenceFrom,
      this.japaneseProficiency,
      this.imagetype,
      this.pictures,
      this.photos,
      this.jlptCertificatePath,
      this.technicalSheetPath,
      this.resumePath,
      this.otherLanguage,
      this.kwnAbtus,
      this.spReason,
      this.stat,
      this.paymentOption,
      this.networkSite,
      this.upgradeRequest,
      this.logdate,
      this.staffId,
      this.completedDate,
      this.modifiedDate,
      this.otherQualification,
      this.createdDate,
      this.reqName,
      this.reqFamilyName,
      this.reqDob,
      this.reqPictures,
      this.reqDate,
      this.dobIdProof,
      this.source,
      this.nlSpecify});

  Profiledata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    franId = json['fran_id'];
    enrollNo = json['enroll_no'];
    progType = json['prog_type'];
    testLevel = json['test_level'];
    testSite = json['test_site'];
    name = json['name'];
    familyName = json['family_name'];
    sex = json['sex'];
    year = json['year'];
    month = json['month'];
    date = json['date'];
    nationality = json['nationality'];
    nativeLanguage = json['native_language'];
    street = json['street'];
    city = json['city'];
    country = json['country'];
    postalCode = json['postal_code'];
    telephoneCode = json['telephone_code'];
    telephone = json['telephone'];
    mobileCode = json['mobile_code'];
    mobile = json['mobile'];
    fax = json['fax'];
    email = json['email'];
    skypeId = json['skype_id'];
    occupation = json['occupation'];
    institution = json['institution'];
    numberOfHours = json['number_of_hours'];
    reason = json['reason'];
    education = json['education'];
    referenceFrom = json['reference_from'];
    japaneseProficiency = json['japanese_proficiency'];
    imagetype = json['imagetype'];
    pictures = json['pictures'];
    photos = json['photos'];
    jlptCertificatePath = json['jlpt_certificate_path'];
    technicalSheetPath = json['technical_sheet_path'];
    resumePath = json['resume_path'];
    otherLanguage = json['other_language'];
    kwnAbtus = json['kwn_abtus'];
    spReason = json['sp_reason'];
    stat = json['stat'];
    paymentOption = json['payment_option'];
    networkSite = json['network_site'];
    upgradeRequest = json['upgrade_request'];
    logdate = json['logdate'];
    staffId = json['staff_id'];
    completedDate = json['completed_date'];
    modifiedDate = json['modified_date'];
    otherQualification = json['other_qualification'];
    createdDate = json['created_date'];
    reqName = json['req_name'];
    reqFamilyName = json['req_family_name'];
    reqDob = json['req_dob'];
    reqPictures = json['req_pictures'];
    reqDate = json['req_date'];
    dobIdProof = json['dob_id_proof'];
    source = json['source'];
    nlSpecify = json['nl_specify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fran_id'] = this.franId;
    data['enroll_no'] = this.enrollNo;
    data['prog_type'] = this.progType;
    data['test_level'] = this.testLevel;
    data['test_site'] = this.testSite;
    data['name'] = this.name;
    data['family_name'] = this.familyName;
    data['sex'] = this.sex;
    data['year'] = this.year;
    data['month'] = this.month;
    data['date'] = this.date;
    data['nationality'] = this.nationality;
    data['native_language'] = this.nativeLanguage;
    data['street'] = this.street;
    data['city'] = this.city;
    data['country'] = this.country;
    data['postal_code'] = this.postalCode;
    data['telephone_code'] = this.telephoneCode;
    data['telephone'] = this.telephone;
    data['mobile_code'] = this.mobileCode;
    data['mobile'] = this.mobile;
    data['fax'] = this.fax;
    data['email'] = this.email;
    data['skype_id'] = this.skypeId;
    data['occupation'] = this.occupation;
    data['institution'] = this.institution;
    data['number_of_hours'] = this.numberOfHours;
    data['reason'] = this.reason;
    data['education'] = this.education;
    data['reference_from'] = this.referenceFrom;
    data['japanese_proficiency'] = this.japaneseProficiency;
    data['imagetype'] = this.imagetype;
    data['pictures'] = this.pictures;
    data['photos'] = this.photos;
    data['jlpt_certificate_path'] = this.jlptCertificatePath;
    data['technical_sheet_path'] = this.technicalSheetPath;
    data['resume_path'] = this.resumePath;
    data['other_language'] = this.otherLanguage;
    data['kwn_abtus'] = this.kwnAbtus;
    data['sp_reason'] = this.spReason;
    data['stat'] = this.stat;
    data['payment_option'] = this.paymentOption;
    data['network_site'] = this.networkSite;
    data['upgrade_request'] = this.upgradeRequest;
    data['logdate'] = this.logdate;
    data['staff_id'] = this.staffId;
    data['completed_date'] = this.completedDate;
    data['modified_date'] = this.modifiedDate;
    data['other_qualification'] = this.otherQualification;
    data['created_date'] = this.createdDate;
    data['req_name'] = this.reqName;
    data['req_family_name'] = this.reqFamilyName;
    data['req_dob'] = this.reqDob;
    data['req_pictures'] = this.reqPictures;
    data['req_date'] = this.reqDate;
    data['dob_id_proof'] = this.dobIdProof;
    data['source'] = this.source;
    data['nl_specify'] = this.nlSpecify;
    return data;
  }
}
