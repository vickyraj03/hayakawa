import 'package:flutter/material.dart';
import 'package:hayakawa_new/models/country/country_model.dart';
import 'package:hayakawa_new/models/rigister/register_model.dart';

import '../../models/Classs/active_class_model.dart';
import '../../models/password_model/password_model.dart';


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
