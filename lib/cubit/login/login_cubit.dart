import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayakawa_new/config/network/repository.dart';
import 'package:hayakawa_new/cubit/login/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Repository? repository;

  LoginCubit({this.repository}) : super(LoginStateInitial());

  void getLogin(dynamic req) async {
    try {
      emit(LoginLoading());
      final loginres = await repository!.loginfetch(req);
      emit(LoginLoaded(logindata: loginres));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
