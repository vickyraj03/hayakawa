
import 'package:flutter/cupertino.dart';



@immutable
abstract class InternetState {}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  final ConnectionType connectionType;

  InternetConnected({required this.connectionType});
}

class InternetDisconnected extends InternetState {}



enum ConnectionType {
  Wifi,
  Mobile,
}
