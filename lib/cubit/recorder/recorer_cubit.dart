import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayakawa_new/config/network/repository.dart';
import 'package:hayakawa_new/cubit/recorder/recorder_state.dart';

class RecorderClassCubit extends Cubit<RecorderState> {
  final Repository? repository;

  RecorderClassCubit({this.repository}) : super(RecorderStateInitial());

  void getBatchs(dynamic req) async {
    try {
      emit(RecorderLoading());
      final batchess = await repository!.batchfetch(req);
      emit(BatchLoaded(batch: batchess));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }


  void getClass(dynamic req) async {
    try {
      emit(RecorderLoading());
      final classs = await repository!.classfetch(req);
      emit(ClassLoaded(classData: classs));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }


  void getVideo(dynamic req) async {
    try {
      emit(RecorderLoading());
      final videodata = await repository!.videofetch(req);
      emit(VideoLoaded(videoData: videodata));
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }
}
