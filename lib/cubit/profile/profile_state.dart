import 'package:flutter/material.dart';
import 'package:hayakawa_new/models/login_model/login_model.dart';
import 'package:hayakawa_new/models/profile/profile_model.dart';

@immutable
abstract class ProfileSate  {}

class ProfileStateInitial extends ProfileSate {}

class ProfileLoaded extends ProfileSate {
  final profileModel profiledata;

  ProfileLoaded({required this.profiledata});
}

class ProfileLoading extends ProfileSate{

}


class ErrorState extends ProfileSate{
  final error;
  ErrorState({this.error});
}