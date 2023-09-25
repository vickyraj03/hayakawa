// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayakawa_new/config/data/perferences.dart';
import 'package:hayakawa_new/config/get_it/get_instances.dart';
import 'package:hayakawa_new/cubit/profile/profile_cubit.dart';
import 'package:hayakawa_new/cubit/profile/profile_state.dart';
import 'package:hayakawa_new/models/profile/profile_model.dart';
import 'package:hayakawa_new/screens/dashboard_screen/classes/active_class.dart';
import 'package:hayakawa_new/screens/dashboard_screen/classes/complete_class.dart';
import 'package:hayakawa_new/screens/dashboard_screen/dash_board.dart';
import 'package:hayakawa_new/widgets/Container/new_Container.dart';
import 'package:hayakawa_new/widgets/Error_text/error_text.dart';
import 'package:hayakawa_new/widgets/appIcon.dart';
import 'package:hayakawa_new/widgets/image/image.dart';
import 'package:hayakawa_new/widgets/network_Connecet.dart';
import 'package:hayakawa_new/widgets/style/app_color.dart';
import 'package:hayakawa_new/widgets/style/font_size.dart';
import 'package:hayakawa_new/widgets/style/style_insets.dart';
import 'package:hayakawa_new/widgets/style/style_space.dart';
import 'package:hayakawa_new/widgets/style/text_style.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({super.key});

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  bool isActive = true;
  bool isComplete = false;

  late ProfileCubit _profile;

  Profiledata? profileData;

  @override
  void initState() {
    super.initState();
    _profile = getItInstance<ProfileCubit>();
    _loadProfile();
  }

  _loadProfile() async {
    var map = new Map<String, dynamic>();
    map['studentId'] = Preferences.getUserid();

    _profile.getProfile(map);
  }

  @override
  Widget build(BuildContext context) {
    return InternetConnectivity(
      ontapRetry: () => _loadProfile(),
      child: BlocConsumer<ProfileCubit, ProfileSate>(
          bloc: _profile,
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ErrorState) {
              return ErrorTxt(
                message: '${state.error}',
                ontap: () => _loadProfile(),
              );
            }

            if (state is ProfileLoaded) {
              if (state.profiledata.result == "success") {
                profileData = state.profiledata.data!;
                //  _activeClassResult = state.activeClass.data!;
              } else {
                Future.delayed(Duration.zero, () async {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(""),
                  ));
                });
              }
            }
            return _class();
          },
          listener: (conttext, state) {}),
    );
  }

  Widget _class() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appPrimaryColor,
        centerTitle: true,
        title: AppIcon(
          icon: AppIcons.hayakawa_red_white,
          size: Insets.xxl * 2.5,
          color: AppColors.PrimaryColor,
        ),
      ),
      drawer: Drawer(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: AppColors.appPrimaryColor),
                    accountName: Text(
                      profileData!.name!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    accountEmail: Text(
                      profileData!
                          .email!, // Preferences.getUserEmail().toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    currentAccountPicture: Cachednetworkimage(
                      imgurl: profileData!.pictures,
                    )),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: textStyle(
                    text: 'Logout',
                    style: TextStyles.body1,
                  ),
                  onTap: () {
                    alertDlg(context, 'Do you want to Logout?');
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Insets.lg),
            child: textStyle(
              text: 'v3.0',
              style: TextStyles.body1,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VSpace(Insets.lg),
          Padding(
            padding: EdgeInsets.only(bottom: Insets.sm, left: Insets.sm),
            child: textStyle(text: 'Class', style: TextStyles.h2),
          ),
          VSpace.med,
          Padding(
            padding: EdgeInsets.only(left: Insets.sm),
            child: Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => setState(() {
                    isActive = true;
                    isComplete = false;
                  }),
                  child: DecoratedContainer(
                    padding: EdgeInsets.symmetric(
                        horizontal: Insets.xl, vertical: Insets.sm),
                    clipFCorner: true,
                    tabDecoration: isActive == true ? true : false,
                    fullcontainer: isComplete == false ? true : false,
                    child: textStyle(
                      text: 'Active',
                      style: isActive == true
                          ? TextStyles.body3w
                              .copyWith(color: AppColors.PrimaryColor)
                          : TextStyles.body3,
                    ),
                  ),
                ),
                HSpace.lg,
                GestureDetector(
                  onTap: () => setState(() {
                    isComplete = true;
                    isActive = false;
                  }),
                  child: DecoratedContainer(
                    clipFCorner: true,
                    tabDecoration: isComplete == true ? true : false,
                    fullcontainer: isActive == false ? true : false,
                    padding: EdgeInsets.symmetric(
                        horizontal: Insets.xl, vertical: Insets.sm),
                    child: textStyle(
                        text: 'Complete',
                        style: isComplete == false
                            ? TextStyles.body3
                            : TextStyles.body3w.copyWith(
                                color: AppColors.PrimaryColor,
                              )),
                  ),
                ),
              ],
            ),
          ),
          VSpace.med,
          Visibility(
              visible: isActive,
              child: Expanded(
                  child: Padding(
                padding: EdgeInsets.all(Insets.sm),
                child: ActiveClass(),
              ))),
          Visibility(
              visible: isComplete,
              child: Expanded(
                  child: Padding(
                padding: EdgeInsets.all(Insets.sm),
                child: CompleteClass(),
              ))),
        ],
      ),
    );
  }
}
