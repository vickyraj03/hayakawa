import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:hayakawa_new/config/network/repository.dart';
import 'package:hayakawa_new/config/network/services.dart';
import 'package:hayakawa_new/cubit/active_class/active_class_cubit.dart';
import 'package:hayakawa_new/cubit/additional_class/additional_class_cubit.dart';
import 'package:hayakawa_new/cubit/complete_class/complete_class_cubit.dart';
import 'package:hayakawa_new/cubit/login/login_cubit.dart';
import 'package:hayakawa_new/cubit/profile/profile_cubit.dart';
import 'package:hayakawa_new/cubit/recorder/recorer_cubit.dart';
import 'package:hayakawa_new/cubit/register/register_cubit.dart';
import 'package:hayakawa_new/screens/dashboard_screen/classes/additional_class.dart';

import '../../cubit/internet/internet_cubit.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Repository>(
      () => Repository(networkService: getItInstance()));

  getItInstance.registerLazySingleton<NetworkService>(() => NetworkService());

  getItInstance.registerLazySingleton<Connectivity>(() => Connectivity());

  getItInstance.registerFactory(() => InternetCubit(connectivity: getItInstance()));

  getItInstance.registerFactory(() => LoginCubit(repository: getItInstance()));
  getItInstance.registerFactory(() => RegisterCubit(repository: getItInstance()));
  getItInstance.registerFactory(() => ActiveClassCubit(repository: getItInstance()));
  getItInstance.registerFactory(() => CompleteCLassCubit(repository: getItInstance()));
  getItInstance.registerFactory(() => ProfileCubit(repository: getItInstance()));
  getItInstance.registerFactory(() => RecorderClassCubit(repository: getItInstance()));
  getItInstance.registerFactory(() => AdditionaClassCubit(repository: getItInstance()));

}
