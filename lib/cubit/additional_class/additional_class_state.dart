import 'package:flutter/material.dart';
import 'package:hayakawa_new/models/additional_class/additional_class_model.dart';
import 'package:hayakawa_new/models/country/country_model.dart';
import 'package:hayakawa_new/models/recorder/recorder_class_model.dart';
import 'package:hayakawa_new/models/recorder/recorder_model.dart';
import 'package:hayakawa_new/models/recorder/video_model.dart';
import 'package:hayakawa_new/models/rigister/register_model.dart';

import '../../models/Classs/active_class_model.dart';
import '../../models/password_model/password_model.dart';


@immutable
abstract class AdditionalState {}

class AdditionalStateInitial extends AdditionalState {}




class AdditionalLoaded extends AdditionalState {
  final AdditionalClass additionalClass;

  AdditionalLoaded({required this.additionalClass});
}


class AdditionalClassLoaded extends AdditionalState {
  final AdditonalClass1 additionalClass;

  AdditionalClassLoaded({required this.additionalClass});
}

class AdditionaVideoLoaded extends AdditionalState {
  final AdditonalClassVideo videoModel;

  AdditionaVideoLoaded({required this.videoModel});
}


class AdditionalLoading extends AdditionalState {}



class ErrorState extends AdditionalState {
  final error;
  ErrorState({this.error});
}
