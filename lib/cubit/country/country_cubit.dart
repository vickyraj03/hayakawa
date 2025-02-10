import 'package:flutter/material.dart';
import 'package:hayakawa_new/models/country/country_model.dart';

@immutable
abstract class CountryState {}

class CountryStateInitial extends CountryState {}

class CountryLoaded extends CountryState {
  final Country countrydata;

  CountryLoaded({required this.countrydata});
}

class CountryLoading extends CountryState {}

class ErrorState extends CountryState {
  final error;
  ErrorState({this.error});
}
