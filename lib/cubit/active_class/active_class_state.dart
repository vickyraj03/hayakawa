import 'package:flutter/material.dart';
import '../../models/Classs/active_class_model.dart';


@immutable
abstract class ActiveClassState {}

class ActiveClassStateInitial extends ActiveClassState {}




class ActiveClassLoaded extends ActiveClassState {
  final ActiveClass activeClass;

  ActiveClassLoaded({required this.activeClass});
}


class ActiveClassLoading extends ActiveClassState {}



class ErrorState extends ActiveClassState {
  final error;
  ErrorState({this.error});
}
