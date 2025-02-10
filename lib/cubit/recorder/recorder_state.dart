import 'package:flutter/material.dart';
import 'package:hayakawa_new/models/recorder/recorder_class_model.dart';
import 'package:hayakawa_new/models/recorder/recorder_model.dart';
import 'package:hayakawa_new/models/recorder/video_model.dart';

@immutable
abstract class RecorderState {}

class RecorderStateInitial extends RecorderState {}




class BatchLoaded extends RecorderState {
  final recorderModel batch;

  BatchLoaded({required this.batch});
}

class ClassLoaded extends RecorderState {
  final recorderClassModel classData;

  ClassLoaded({required this.classData});
}

class VideoLoaded extends RecorderState {
  final VideoModel videoData;

  VideoLoaded({required this.videoData});
}

class RecorderLoading extends RecorderState {}



class ErrorState extends RecorderState {
  final error;
  ErrorState({this.error});
}
