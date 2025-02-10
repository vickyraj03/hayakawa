import 'package:flutter/material.dart';

import '../../widgets/style/app_color.dart';
import '../../widgets/style/style_insets.dart';

typedef onBackPressedCall = void Function(BuildContext menuContext);
typedef onLanguageChange = void Function(BuildContext menuContext);

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  onBackPressedCall onbackPressedCall;
  onLanguageChange onlanguageChange;
  BuildContext? ctx;
  bool visibleBackIcon;
  String pageId;
  bool visibleLanguage;
  Color bg;
  CustomAppBar(
      {required this.onbackPressedCall,
      required this.onlanguageChange,
      required this.ctx,
      required this.visibleBackIcon,
      this.pageId = '',
      this.visibleLanguage = true,
      this.bg = AppColors.PrimaryColor});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => new Size.fromHeight(Insets.xxl + 20);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String? appName, packageName, version, buildNumber;
  Widget kBackBtn = Icon(
    Icons.arrow_back_ios,
  );
  BorderRadius kBackButtonShape1 = BorderRadius.only(
    bottomLeft: Radius.circular(Insets.xxl),
    bottomRight: Radius.circular(Insets.xxl),
  );

  bool positive = false;

  @override
  void initState() {
    super.initState();
    // getAppVersion();
    // _localeCubit = getItInstance<LocaleCubit>();
    // PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
    //   appName = packageInfo.appName;
    //   packageName = packageInfo.packageName;
    //   buildNumber = packageInfo.buildNumber;
    //   setState(() {
    //     version = packageInfo.version;
    //     debugPrint('geymtversion$version');
    //     Preferences.getLanguage() == 'ar-EG'
    //         ? positive = false
    //         : positive = true;
    //   });
    // });
  }

  @override
  void didUpdateWidget(CustomAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    //   Preferences.getLanguage() == 'ar-EG' ? positive = false : positive = true;
  }

  onPressed() {
    //  InheritedWrapperState wrapper = InheritedWrapper.of(context);
    //   wrapper.incrementCounter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.appPrimaryColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 0,
          elevation: 0.2,
          backgroundColor: AppColors.appPrimaryColor,
        ), //AppBar
        body: Material(
          elevation: 2,
          borderRadius: kBackButtonShape1,
          color: AppColors.appPrimaryColor,
          child: Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 0.5,
                      spreadRadius: 0.0,
                      offset: Offset(0, 0))
                ],
                borderRadius: kBackButtonShape1,
              ),
              child: Container()),
        ),
      ),
      debugShowCheckedModeBanner: false,
    ); //Scaffold
  }
}
