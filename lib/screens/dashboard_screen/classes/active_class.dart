

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayakawa_new/config/data/perferences.dart';
import 'package:hayakawa_new/config/get_it/get_instances.dart';
import 'package:hayakawa_new/cubit/active_class/active_class_cubit.dart';
import 'package:hayakawa_new/cubit/active_class/active_class_state.dart';
import 'package:hayakawa_new/models/Classs/active_class_model.dart';
import 'package:hayakawa_new/screens/dashboard_screen/classes/active_class__details.dart';
import 'package:hayakawa_new/widgets/Container/new_Container.dart';
import 'package:hayakawa_new/widgets/Error_text/error_text.dart';
import 'package:hayakawa_new/widgets/style/app_color.dart';
import 'package:hayakawa_new/widgets/style/font_size.dart';
import 'package:hayakawa_new/widgets/style/style_insets.dart';
import 'package:hayakawa_new/widgets/style/style_space.dart';
import 'package:hayakawa_new/widgets/style/text_style.dart';

class ActiveClass extends StatefulWidget {
  const ActiveClass({super.key});

  @override
  State<ActiveClass> createState() => _ActiveClassState();
}

class _ActiveClassState extends State<ActiveClass> {
  late ActiveClassCubit _activeClassCubit;

  List<ActiveClassResult>? _activeClassResult;

  @override
  void initState() {
    super.initState();
    _activeClassCubit = getItInstance<ActiveClassCubit>();
    _loadActiveclass();
  }

  _loadActiveclass() async {
    var map = new Map<String, dynamic>();
    map['studentId'] = Preferences.getUserid();

    _activeClassCubit.getActiveClass(map);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActiveClassCubit, ActiveClassState>(
        bloc: _activeClassCubit,
        builder: (context, state) {
          if (state is ActiveClassLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ErrorState) {
            return ErrorTxt(
              message: '${state.error}',
              ontap: () => _loadActiveclass(),
            );
          }

          if (state is ActiveClassLoaded) {
            if (state.activeClass.result == "success") {
              _activeClassResult = state.activeClass.data!;
              if(_activeClassResult!.isNotEmpty){
                return ActiveClassUI();
              }else{
                return Center(child: Text(state.activeClass.data1.toString()));
              }
            }
            
            if (state.activeClass.result == "error") {
              
                return Center(child: Text(state.activeClass.data1.toString()));
              
            } else {
              Future.delayed(Duration.zero, () async {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("${state.activeClass.message}"),
                ));
              });
            }
          }
          return CircularProgressIndicator();
        },
        listener: (conttext, state) {
          if (state is ActiveClassLoaded) {
          if (state.activeClass.result == "success") {
              _activeClassResult = state.activeClass.data!;
             
            }
          }
        });
  }

  Widget ActiveClassUI() {
    return ListView.builder(
      itemCount: _activeClassResult?.length,
      itemBuilder: (context, index) {
        TblCourse _tablcourse = _activeClassResult![index].tblCourse!;
        Batch _batch = _activeClassResult![index].batch!;
        Others _others = _activeClassResult![index].others!;
        return  _activeClassResult != null? GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ActiveClassDetails(activeClassResult: _activeClassResult![index],);
                          },
                        ));
          },
          child: Padding(
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
                        color: Colors.red,
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
          ),
        ): Center(
          child: Padding(
              padding: EdgeInsets.only(bottom: Insets.sm, left: Insets.sm),
              child: textStyle(text: 'No Active Class', style: TextStyles.h2),
            ),
        );
      },
    );
  }
}
