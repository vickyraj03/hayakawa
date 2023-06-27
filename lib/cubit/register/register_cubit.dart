import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayakawa_new/config/network/repository.dart';
import 'package:hayakawa_new/cubit/register/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final Repository? repository;

  RegisterCubit({this.repository}) : super(RegisterStateInitial());

  void getRegister(dynamic req) async {
    try {
      emit(RegisterLoading());
      final registerRes = await repository!.Registerfetch(req);
      emit(RegisterLoaded(register: registerRes));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  void getCountry(dynamic req) async {
    try {
      emit(RegisterLoading());
      final countryres = await repository!.countryfetch(req);
      emit(CountryLoaded(countrydata: countryres));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  void getPassword(String req) async {
    try {
      emit(RegisterLoading());
      final password = await repository!.paswordFetch(req);
      emit(forgotPasswordLoaded(forgotPassword: password));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
