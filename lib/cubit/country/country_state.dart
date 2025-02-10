import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayakawa_new/config/network/repository.dart';
import 'package:hayakawa_new/cubit/country/country_cubit.dart';


class CountryCubit extends Cubit<CountryState> {
  final Repository? repository;

  CountryCubit({this.repository}) : super(CountryStateInitial());

  void getLogin(dynamic req) async {
    try {
      emit(CountryLoading());
      final countryres = await repository!.countryfetch(req);
      emit(CountryLoaded(countrydata: countryres));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
