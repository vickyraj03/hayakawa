

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hayakawa_new/config/get_it/get_instances.dart';
// import 'package:hayakawa_new/cubit/internet/internet_cubit.dart';
// import 'package:hayakawa_new/cubit/internet/internet_state.dart';
// import 'package:hayakawa_new/widgets/Error_text/error_text.dart';

// typedef onTapRetry = void Function();

// class InternetConnectivity extends StatelessWidget {
//   Widget child;
//   onTapRetry ontapRetry;

//   InternetConnectivity({required this.child,required this.ontapRetry});

//   @override
//   Widget build(BuildContext context) {

//     InternetCubit _internetCubit = getItInstance<InternetCubit>();
//       return  BlocConsumer<InternetCubit, InternetState>(
//         bloc: _internetCubit,
//         builder: (context, state) {
//           if (state is InternetConnected) {
//             return child;
//           } else if (state is InternetDisconnected) {
//             return ErrorTxt(
//               message: "Cannot connect to internet.\n\n Tap to retry.",
//               ontap:()=>ontapRetry,
//             );
//           }
//           return child;
//         },
//         listener: (context, state) {
//           if (state is InternetConnected) {
//             debugPrint('state is InternetConnected Listener');
//             // widget.localecallback(dashTranslation!);
//           }
//           if (state is InternetDisconnected) {
//             debugPrint('state is InternetDisconnected Listener');
//           }
//         });



//   }
// }
