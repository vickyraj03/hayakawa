import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayakawa_new/config/network/repository.dart';

import 'package:hayakawa_new/cubit/additional_class/additional_class_state.dart';

class AdditionaClassCubit extends Cubit<AdditionalState> {
  final Repository? repository;

  AdditionaClassCubit({this.repository}) : super(AdditionalStateInitial());

  void getAdditonalClass(dynamic req) async {
    try {
      emit(AdditionalLoading());
      final additionalclass = await repository!.additionalfetch(req);
      emit(AdditionalLoaded(additionalClass: additionalclass));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  void getAdditonalClass1(dynamic req) async {
    try {
      emit(AdditionalLoading());
      final additionalclass = await repository!.additionaclassfetch(req);
      emit(AdditionalClassLoaded(additionalClass: additionalclass));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

   void getVideo(dynamic req) async {
    try {
      emit(AdditionalLoading());
      final videodata = await repository!.additionavideofetch(req);
      emit(AdditionaVideoLoaded(videoModel: videodata));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
