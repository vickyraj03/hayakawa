import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hayakawa_new/config/data/perferences.dart';
import 'package:hayakawa_new/config/get_it/get_instances.dart';
import 'package:hayakawa_new/cubit/profile/profile_cubit.dart';
import 'package:hayakawa_new/cubit/profile/profile_state.dart';
import 'package:hayakawa_new/models/dashboard_model/dashboard_model.dart';
import 'package:hayakawa_new/models/login_model/login_model.dart';
import 'package:hayakawa_new/models/profile/profile_model.dart';
import 'package:hayakawa_new/screens/app_bar/app_bar.dart';
import 'package:hayakawa_new/screens/dashboard_screen/classes/class_screen.dart';
import 'package:hayakawa_new/screens/login_screen/login_screen.dart';
import 'package:hayakawa_new/screens/login_screen/sign_up_page.dart';
import 'package:hayakawa_new/widgets/Container/new_Container.dart';
import 'package:hayakawa_new/widgets/Error_text/error_text.dart';
import 'package:hayakawa_new/widgets/image/image.dart';
import 'package:hayakawa_new/widgets/style/font_size.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/appIcon.dart';
import '../../widgets/style/app_color.dart';
import '../../widgets/style/style_insets.dart';
import '../../widgets/style/style_space.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class DashboardScreen extends StatefulWidget {
  Data? loginData;
  DashboardScreen({super.key, this.loginData});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Iconspojo> listsdash = [];
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
    listsdash.clear();
    listsdash.add(Iconspojo('COURSES', 'assets/svg/Course.svg', 1, 'CR'));
    listsdash.add(Iconspojo('CLASSES', 'assets/svg/Class.svg', 2, 'CL'));
    listsdash.add(Iconspojo('BOOKS', 'assets/svg/Books.svg', 3, 'BK'));
    listsdash.add(Iconspojo('EXAMS', 'assets/svg/Exam.svg', 4, 'EX'));
    listsdash.add(Iconspojo('JOBS', 'assets/svg/Job.svg', 5, 'JB'));
    listsdash.add(Iconspojo('EVENTS', 'assets/svg/Event.svg', 6, 'EN'));
    listsdash.add(Iconspojo('NEWS', 'assets/svg/News.svg', 7, 'NW'));
    listsdash.add(Iconspojo('ORDERS', 'assets/svg/Order.svg', 8, 'OR'));
    listsdash.add(Iconspojo('STUDIES', 'assets/svg/Study.svg', 9, 'ST'));

    return BlocConsumer<ProfileCubit, ProfileSate>(
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
          return dashboardUI();
        },
        listener: (conttext, state) {});
  }

  Widget dashboardUI() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        // automaticallyImplyLeading: false,
        //  leading: Icon(Icons.drag_handle),
        title: AppIcon(
          icon: AppIcons.hayakawa_red_white,
          size: Insets.xxl * 2.5,
          color: AppColors.PrimaryColor,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.red),
              accountName: Text(
                profileData!.name!, // Preferences.getUserName().toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                profileData!.email!, // Preferences.getUserEmail().toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: Cachednetworkimage(imgurl: profileData!.pictures,)
    //           currentAccountPicture: CachedNetworkImage(
    //     imageUrl: "http://via.placeholder.com/350x150",
    //     placeholder: (context, url) => CircularProgressIndicator(),
    //     errorWidget: (context, url, error) => Icon(Icons.error),
    //  ),
            //   currentAccountPicture: ProfilePicture(
            //  //   img: profileData!.photos!,
            //     name: profileData!.name!, //Preferences.getUserName().toString(),
            //     radius: Insets.xl * 2,
            //     fontsize: 21,
            //     random: false,
            //   ),
                          ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Page 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.train,
              ),
              title: const Text('Page 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: AppIcon(icon: AppIcons.Hayakawa_new_logo),
              title: const Text('Logout'),
              onTap:  ()  {
                      alertDlg(
                                  context, 'Do you want to Logout? ?');
                    },
            ),
          ],
        ),
      ),
      body: Padding(
        padding:
            EdgeInsets.only(left: Insets.xs, top: Insets.xl, right: Insets.xs),
        child: GridView.builder(
          itemCount: listsdash.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 0, mainAxisSpacing: 0),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  Iconspojo icpojo = listsdash[index];
                  icpojo.iconId == "CL"
                      ? Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ClassesScreen();
                          },
                        ))
                      : "";
                },
                child: CardItemlatest1(listsdash[index]));
          },
        ),
      ),
    );
  }
}

Widget CardItemlatest1(Iconspojo item) {
  return ColorFiltered(
    colorFilter: item.activeIcon == 1
        ? ColorFilter.mode(Colors.white10.withOpacity(0.0), BlendMode.color)
        : ColorFilter.mode(Colors.white10.withOpacity(0.0), BlendMode.color),
    //: ColorFilter.mode(Colors.white24.withOpacity(0.2), BlendMode.modulate),
    child: Column(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child:SvgPicture.asset(
      item.image,
      width: Insets.xxl,
      height: Insets.xxl,
      color:Colors.red,
    )
          
          // child: Image.asset(
          //   item.image,
          //   fit: BoxFit.contain,
          //   height: Insets.xxl,
          //   width: Insets.xxl,
          //   //  color: AppColors.PrimaryColor,
          //   //SizeConfig.screenHeight! * 0.08,
          // ),
        ),
        SizedBox(
          height: 1,
        ),
        Flexible(
          child: Text(
            item.name,
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyles.subTitle5.copyWith(
                fontSize: FontSizes.s14,
                fontWeight: FontWeight.bold,
                color: AppColors.kTextPrimary),
          ),
        )
      ],
    ),
  );

  
}

Future<void> alertDlg(BuildContext context, String message) async =>
    //Product add to cart

    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          var alertDialog = Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Consts.padding),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: Consts.avatarRadius + Consts.padding,
                    bottom: Consts.padding,
                    left: Consts.padding,
                    right: Consts.padding,
                  ),
                  margin: EdgeInsets.only(top: Consts.avatarRadius),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(Consts.padding),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: const Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // To make the card compact
                    children: <Widget>[
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 24.0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed:  () async {
                      final pref = await SharedPreferences.getInstance();
                      await pref.clear();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return MyWidget();
                          },
                        ),
                        (_) => false,
                      );
                    },
                          child: Text('OK'),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: 45,
                    left: 10,
                    right: 10,
                    child: Material(
                      elevation: 0.0,
                      shape: CircleBorder(),
                      clipBehavior: Clip.hardEdge,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Ink.image(
                          image: AssetImage(
                            'assets/img/logo.png',
                          ),
                          fit: BoxFit.contain,
                          // width: 90.0,
                          height: 90.0,
                        ),
                      ),
                    )),
              ],
            ),
          );
          return alertDialog;
        });
