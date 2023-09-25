import 'package:hayakawa_new/config/common/api_data.dart';
import 'package:hayakawa_new/config/network/services.dart';
import 'package:hayakawa_new/models/Classs/active_class_model.dart';
import 'package:hayakawa_new/models/additional_class/additional_class_model.dart';
import 'package:hayakawa_new/models/country/country_model.dart';
import 'package:hayakawa_new/models/login_model/login_model.dart';
import 'package:hayakawa_new/models/profile/profile_model.dart';
import 'package:hayakawa_new/models/recorder/recorder_class_model.dart';
import 'package:hayakawa_new/models/recorder/recorder_model.dart';
import 'package:hayakawa_new/models/recorder/video_model.dart';
import 'package:hayakawa_new/models/rigister/register_model.dart';

import '../../models/Classs/complate_class_model.dart';
import '../../models/password_model/password_model.dart';

class Repository {
  final NetworkService? networkService;

  Repository({this.networkService});

  Future<dynamic> loginfetch(dynamic map) async {
    final loginresponse =
        await networkService!.postFromdata(login_endpoint, map);
    Login loginres = Login.fromJson(loginresponse);
    return loginres;
  }

  Future<dynamic> Registerfetch(dynamic map) async {
    final register = await networkService!.post(registrer_endpont, map);
    Register registerres = Register.fromJson(register);
    return registerres;
  }

  Future<dynamic> countryfetch(dynamic map) async {
    final countryresponse =
        await networkService!.postFromdata(masters_endpoint, map);
    Country countryres = Country.fromJson(countryresponse);
    return countryres;
  }

  Future<dynamic> paswordFetch(String req) async {
    final forgotresponse = await networkService!.post(forgotpass_endpoint, req);
    ForgotPassword forgotPassword = ForgotPassword.fromJson(forgotresponse);
    return forgotPassword;
  }

  Future<dynamic> activeclassfetch(dynamic map) async {
    final activeclassres =
        await networkService!.postFromdata(activeclass_endpoint, map);
    ActiveClass activeclass = ActiveClass.fromJson(activeclassres);
    return activeclass;
  }

  Future<dynamic> completeclassfetch(dynamic map) async {
    final completeclassres =
        await networkService!.postFromdata(completeclass_endpoint, map);
    CompleteClassModel completeclass =
        CompleteClassModel.fromJson(completeclassres);
    return completeclass;
  }

  Future<dynamic> profilefetch(dynamic map) async {
    final profiledata =
        await networkService!.postFromdata(profile_endpoint, map);
    profileModel profileres = profileModel.fromJson(profiledata);
    return profileres;
  }

  Future<dynamic> batchfetch(dynamic map) async {
    final batchdata = await networkService!.post(batches_endpoint, map);
    recorderModel batchres = recorderModel.fromJson(batchdata);
    return batchres;
  }

  Future<dynamic> classfetch(dynamic map) async {
    final classdata = await networkService!.post(class_endpoint, map);
    recorderClassModel classres = recorderClassModel.fromJson(classdata);
    return classres;
  }

  Future<dynamic> videofetch(dynamic map) async {
    final videodata = await networkService!.post(video_endpoint, map);
    VideoModel videores = VideoModel.fromJson(videodata);
    return videores;
  }

  Future<dynamic> additionalfetch(dynamic map) async {
    final additionaldata =
        await networkService!.post(additional_video_endpoint, map);
    AdditionalClass additionalres = AdditionalClass.fromJson(additionaldata);
    return additionalres;
  }

  Future<dynamic> additionaclassfetch(dynamic map) async {
    final additionaldata =
        await networkService!.post(additional_class_endpoint, map);
    AdditonalClass1 additionalclassres =
        AdditonalClass1.fromJson(additionaldata);
    return additionalclassres;
  }

  Future<dynamic> additionavideofetch(dynamic map) async {
    final additionaldata =
        await networkService!.post(additional_class_video_endpoint, map);
    AdditonalClassVideo additionalclassvideores =
        AdditonalClassVideo.fromJson(additionaldata);
    return additionalclassvideores;
  }
}
