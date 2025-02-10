import 'package:flutter/material.dart';
import 'package:hayakawa_new/models/Classs/complate_class_model.dart';


@immutable
abstract class CompleteClassState {}

class CompleteClassStateInitial extends CompleteClassState {}




class CompleteClassLoaded extends CompleteClassState {
  final CompleteClassModel completeClass;

  CompleteClassLoaded({required this.completeClass});
}


class CompleteClassLoading extends CompleteClassState {}


class ErrorState extends CompleteClassState {
  final error;
  ErrorState({this.error});
}
