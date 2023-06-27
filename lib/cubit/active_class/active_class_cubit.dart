import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayakawa_new/config/network/repository.dart';
import 'package:hayakawa_new/cubit/active_class/active_class_state.dart';

class ActiveClassCubit extends Cubit<ActiveClassState> {
  final Repository? repository;

  ActiveClassCubit({this.repository}) : super(ActiveClassStateInitial());

  void getActiveClass(dynamic req) async {
    try {
      emit(ActiveClassLoading());
      final activeclass = await repository!.activeclassfetch(req);
      emit(ActiveClassLoaded(activeClass: activeclass));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  
}
