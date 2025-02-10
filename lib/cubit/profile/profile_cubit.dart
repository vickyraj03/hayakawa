import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayakawa_new/config/network/repository.dart';

import 'package:hayakawa_new/cubit/profile/profile_state.dart';

class ProfileCubit extends Cubit<ProfileSate> {
  final Repository? repository;

  ProfileCubit({this.repository}) : super(ProfileStateInitial());

  void getProfile(dynamic req) async {
    try {
      emit(ProfileLoading());
      final profileres = await repository!.profilefetch(req);
      emit(ProfileLoaded(profiledata: profileres));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
