import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayakawa_new/config/data/perferences.dart';
import 'package:hayakawa_new/config/get_it/get_instances.dart';
import 'package:hayakawa_new/cubit/complete_class/complete_class_cubit.dart';
import 'package:hayakawa_new/cubit/complete_class/complete_class_state.dart';
import 'package:hayakawa_new/widgets/Container/new_Container.dart';
import 'package:hayakawa_new/widgets/Error_text/error_text.dart';
import 'package:hayakawa_new/widgets/style/app_color.dart';
import 'package:hayakawa_new/widgets/style/font_size.dart';
import 'package:hayakawa_new/widgets/style/style_insets.dart';
import 'package:hayakawa_new/widgets/style/style_space.dart';
import 'package:hayakawa_new/widgets/style/text_style.dart';
import 'package:hayakawa_new/models/Classs/complate_class_model.dart';

class CompleteClass extends StatefulWidget {
  const CompleteClass({super.key});

  @override
  State<CompleteClass> createState() => _CompleteClassState();
}

class _CompleteClassState extends State<CompleteClass> {
  late CompleteCLassCubit _completeCLassCubit;

  List<Completeclassresult>? _completeclass;
  @override
  void initState() {
    super.initState();
    _completeCLassCubit = getItInstance<CompleteCLassCubit>();
    _loadCompleteclass();
  }

  _loadCompleteclass() async {
    var map = new Map<String, dynamic>();
    map['studentId'] = Preferences.getUserid();

    _completeCLassCubit.getCompleteClass(map);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompleteCLassCubit, CompleteClassState>(
        bloc: _completeCLassCubit,
        builder: (context, state) {
          if (state is CompleteClassLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ErrorState) {
            return ErrorTxt(
              message: '${state.error}',
              ontap: () => _loadCompleteclass(),
            );
          }

          if (state is CompleteClassLoaded) {
            if(state.completeClass.result == "error") {
              // Future.delayed(Duration.zero, () async {
              //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //     content: Text("${state.completeClass.message}"),
              //   ));
              // });
               return Center(child: textStyle(text: state.completeClass.data1.toString()),);
            }
          else  if (state.completeClass.result == "success") {
              _completeclass = state.completeClass.data!;
              if(_completeclass!.isNotEmpty){
                return _completeClassUI();
              }else{
                return Center(child: textStyle(text: 'Sorry, you don’t have any active batch!'));
              }
              
            } 
          }
          return CircularProgressIndicator();
        },
        listener: (conttext, state) {
          if (state is CompleteClassLoaded) {
            if (state.completeClass.result == "success") {
              _completeclass = state.completeClass.data!;
             
            }
          }
        });
  }

  Widget _completeClassUI() {
    return
    ListView.builder(
      itemCount: _completeclass?.length,
      itemBuilder: (context, index) {
        TblCourse _tablcourse = _completeclass![index].tblCourse!;
        Batch _batch = _completeclass![index].batch!;
        Others _others = _completeclass![index].others!;
        return _completeclass != null || _completeclass!.isEmpty? Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Insets.xs, vertical: Insets.sm),
          child: IntrinsicHeight(
            child: DecoratedContainer(
              clipFCorner: true,
              child: Column(
                children: [
                  DecoratedContainer(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: Insets.xs, vertical: Insets.sm),
                      color: Colors.red[900],
                      //   clipFCorner: true,
                      child: Column(
                        children: [
                          textStyle(
                            text: _tablcourse.courseName!,
                            style: TextStyles.body1
                                .copyWith(color: AppColors.PrimaryColor),
                          ),
                          VSpace.xs,
                          textStyle(
                            text: _batch.batchName!,
                            style: TextStyles.body1
                                .copyWith(color: AppColors.PrimaryColor),
                          ),
                        ],
                      )),
                  VSpace.xs,
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Insets.lg, vertical: Insets.xs),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            flex: 2,
                            child: textStyle(
                              text: 'Course Type',
                              style: TextStyles.subTitle2
                                  .copyWith(fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                           flex: 2,
                            child: textStyle(
                          text: _tablcourse.courseType!,
                          style: TextStyles.body2
                              .copyWith(color: AppColors.kTextThird),
                          textAlign: TextAlign.right,
                        )),
                      ],
                    ),
                  ),
                  VSpace.xs,
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Insets.lg, vertical: Insets.xs),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            flex: 2,
                            child: textStyle(
                              text: 'Program Type',
                              style: TextStyles.subTitle2
                                  .copyWith(fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                           flex: 2,
                            child: textStyle(
                          text: _tablcourse.progType!,
                          style: TextStyles.body2
                              .copyWith(color: AppColors.kTextThird),
                          textAlign: TextAlign.right,
                        )),
                      ],
                    ),
                  ),
                  VSpace.xs,
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Insets.lg, vertical: Insets.xs),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            flex: 2,
                            child: textStyle(
                              text: 'Duration',
                              style: TextStyles.subTitle2
                                  .copyWith(fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                           flex: 2,
                            child: textStyle(
                          text: _tablcourse.courseDuration!,
                          style: TextStyles.body2
                              .copyWith(color: AppColors.kTextThird),
                          textAlign: TextAlign.right,
                        )),
                      ],
                    ),
                  ),
                  VSpace.xs,
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Insets.lg, vertical: Insets.xs),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            flex: 2,
                            child: textStyle(
                              text: 'Starts',
                              style: TextStyles.subTitle2
                                  .copyWith(fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                           flex: 2,
                            child: textStyle(
                          text: _others.startDate.toString(),
                          style: TextStyles.body2
                              .copyWith(color: AppColors.kTextThird),
                          textAlign: TextAlign.right,
                        )),
                      ],
                    ),
                  ),
                  VSpace.xs,
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Insets.lg, vertical: Insets.xs),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            flex: 2,
                            child: textStyle(
                              text: 'Ends',
                              style: TextStyles.subTitle2
                                  .copyWith(fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                           flex: 2,
                            child: textStyle(
                          text: _others.endDate.toString(),
                          style: TextStyles.body2
                              .copyWith(color: AppColors.kTextThird),
                          textAlign: TextAlign.right,
                        )),
                      ],
                    ),
                  ),
                  VSpace.xs,
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Insets.lg, vertical: Insets.xs),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            flex: 2,
                            child: textStyle(
                              text: 'Time',
                              style: TextStyles.subTitle2
                                  .copyWith(fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                           flex: 2,
                            child: textStyle(
                          text: _batch.timing!,
                          style: TextStyles.body2
                              .copyWith(color: AppColors.kTextThird),
                          textAlign: TextAlign.right,
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ):Center(
          child: Padding(
              padding: EdgeInsets.only(bottom: Insets.sm, left: Insets.sm),
              child: textStyle(text: 'No Complete Class', style: TextStyles.h2),
            ),
        );
      },
    );
  }
}
