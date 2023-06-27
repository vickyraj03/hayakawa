import 'package:flutter/material.dart';
import 'package:hayakawa_new/models/login_model/login_model.dart';

@immutable
abstract class LoginState {}

class LoginStateInitial extends LoginState {}

class LoginLoaded extends LoginState {
  final Login logindata;

  LoginLoaded({required this.logindata});
}

class LoginLoading extends LoginState{

}


class ErrorState extends LoginState{
  final error;
  ErrorState({this.error});
}