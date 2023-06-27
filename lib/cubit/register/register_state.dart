import 'package:flutter/material.dart';
import 'package:hayakawa_new/models/country/country_model.dart';
import 'package:hayakawa_new/models/rigister/register_model.dart';

import '../../models/password_model/password_model.dart';


@immutable
abstract class RegisterState {}

class RegisterStateInitial extends RegisterState {}

class RegisterLoaded extends RegisterState {
  final Register register;

  RegisterLoaded({required this.register});
}

class CountryLoaded extends RegisterState {
  final Country countrydata;

  CountryLoaded({required this.countrydata});
}

class forgotPasswordLoaded extends RegisterState {
  final ForgotPassword forgotPassword;

  forgotPasswordLoaded({required this.forgotPassword});
}

class RegisterLoading extends RegisterState {}

class ErrorState extends RegisterState {
  final error;
  ErrorState({this.error});
}
