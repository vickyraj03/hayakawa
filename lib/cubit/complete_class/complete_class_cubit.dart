import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayakawa_new/config/network/repository.dart';

import 'package:hayakawa_new/cubit/complete_class/complete_class_state.dart';



class CompleteCLassCubit extends Cubit<CompleteClassState> {
  final Repository? repository;

  CompleteCLassCubit({this.repository}) : super(CompleteClassStateInitial());

  void getCompleteClass(dynamic req) async {
    try {
      emit(CompleteClassLoading());
      final completeclass = await repository!.completeclassfetch(req);
      emit(CompleteClassLoaded(completeClass: completeclass));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}