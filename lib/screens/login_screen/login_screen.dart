import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayakawa_new/config/data/perferences.dart';
import 'package:hayakawa_new/config/get_it/get_instances.dart';
import 'package:hayakawa_new/config/request/request.dart';
import 'package:hayakawa_new/cubit/login/login_cubit.dart';
import 'package:hayakawa_new/cubit/login/login_state.dart';
import 'package:hayakawa_new/models/login_model/login_model.dart';
import 'package:hayakawa_new/screens/dashboard_screen/classes/class_screen.dart';
import 'package:hayakawa_new/screens/dashboard_screen/dash_board.dart';
import 'package:hayakawa_new/screens/login_screen/sign_up_page.dart';
import 'package:hayakawa_new/widgets/Error_text/error_text.dart';
import 'package:hayakawa_new/widgets/animation.dart';
import 'package:hayakawa_new/widgets/appIcon.dart';
import 'package:hayakawa_new/widgets/dialogs.dart';
import 'package:hayakawa_new/widgets/style/app_color.dart';
import 'package:hayakawa_new/widgets/style/font_size.dart';
import 'package:hayakawa_new/widgets/style/style_insets.dart';
import 'package:hayakawa_new/widgets/style/style_space.dart';
import 'package:hayakawa_new/widgets/style/text_style.dart';

import 'forgot_password.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //SharedPreferences sharedPreferences;
  bool _load = false;

  final bool _isError = false;
  bool _obscureText = true;
  bool _isLoading = false;
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  String errorText = "", emailError = "", passwordError = "";
  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();
  Data? logindata;

  late LoginCubit _loginCubit;

  _valid() {
    bool valid = true;
    if (passwordController.text.trim().isEmpty) {
      valid = false;
      passwordError = "Password can't be blank!";
    } else if (passwordController.text.trim().length < 3) {
      valid = false;
      passwordError = "Password is invalid!";
    }

    if (emailController.text.trim().isEmpty) {
      valid = false;
      emailError = "Email / Mobile No can't be blank!";
    }
    // if (!emailController.text.trim().contains("@")) {
    //  // if (!emailController.text.contains(EmailValidator.regex)) {
    //     valid = false;
    //     emailError = "Enter valid EmailID!";
    //  // }
    // } else
    if (!emailController.text.toString().contains("@")) {
      String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
      // String patttern =r'(?:[+0]9)?[0-9]{10}$';
      RegExp regExp = new RegExp(patttern);
      if (emailController.text.trim().length == 0) {
        valid = false;
        emailError = "Email / Mobile No can't be blank!";
      } else if (!regExp.hasMatch(emailController.text.trim())) {
        valid = false;
        emailError = 'Please Enter Valid Email / Mobile No';
      } else {
        emailError = "";
      }
    }
    return valid;
  }
  
   showErrorDialog(BuildContext context,
      {String? message, String? dtitle, String? lableOk}) {
    // set up the AlertDialog
    final BaseStyledDialog alert = BaseStyledDialog(
      title: dtitle ?? 'OTP Validation',
      content: '\n$message',
      action: lableOk ?? 'Ok',
    );
    /*   CupertinoAlertDialog(
      title: const Text('Verification Code Resend'),
      content: Text('\n$message'),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );*/
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  @override
  void initState() {
    super.initState();
    _loginCubit = getItInstance<LoginCubit>();
    //  _fetchSessionAndNavigate();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    // _getLogin();
    setState(() {
      emailController.text = "";
      passwordController.text = "";
    });
  }

  _getLogin() async {
    var map = new Map<String, dynamic>();
    map['email'] = emailController.text;
    map['password'] = passwordController.text;
    map['type'] = 'login';
    _loginCubit.getLogin(map);
  }

  _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildLoginState());
  }


  Widget buildLoginState() {
    return BlocConsumer<LoginCubit, LoginState>(
        bloc: _loginCubit,
        builder: (context, state) {
          if (state is LoginLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ErrorState) {
            return ErrorTxt(
              message: '${state.error}',
              ontap: () => _getLogin(),
            );
          }

          if (state is LoginLoaded) {
            if (state.logindata.result == "success") {
              logindata = state.logindata.data;
              Preferences.setUserValidate(true);
              Preferences.setUserid(logindata!.studentId!);
            
              // Preferences.setUserName(logindata!.name!);
              // Preferences.setUserEmail(logindata!.username!);
              Future.delayed(Duration.zero, () async {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ClassesScreen(
                        //loginData: logindata!,
                      );
                    },
                  ),
                  (_) => false,
                );
              });
            } else {
                Future.delayed(Duration.zero, () async {
                   showErrorDialog(context,
                lableOk:  'Ok',
                dtitle: 'Login',
                message: "${state.logindata.message}");
                });
              // Future.delayed(Duration.zero, () async {
              //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //     content: Text("${state.logindata.message}"),
              //   ));
              // });
            }
          }
          return buildLoginUI();
        },
        listener: (conttext, state) {});
  }

  Widget buildLoginUI() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [Colors.red[900]!, Colors.red[800]!, Colors.red[400]!])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          VSpace.xl,
          Center(
            child: AppIcon(
              icon: AppIcons.hayakawa,
              size: Insets.xxl * 4,
              color: AppColors.PrimaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Insets.xl, vertical: Insets.med),
            child: Column(
              children: const <Widget>[
                Center(
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Welcome Back",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
              ],
            ),
          ),
          VSpace.med,
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(Insets.xl),
                  child: Column(
                    children: <Widget>[
                      VSpace.xl,
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(223, 8, 19, 0.29),
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              //   padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[200]!))),
                              child: EmailField(
                                emailController: emailController,
                                emailError: emailError,
                                focusNode: nodeOne,
                              ),
                            ),
                            Container(
                              //  padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[200]!))),
                              child: PasswordField(
                                passwordController: passwordController,
                                obscureText: _obscureText,
                                passwordError: passwordError,
                                togglePassword: _togglePassword,
                                focusNode: nodeTwo,
                              ),
                            ),
                          ],
                        ),
                      ),
                      VSpace.lg,
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()),
                            );
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.blue),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      VSpace(Insets.xl),
                      GestureDetector(
                        onTap: () {
                          //_getLogin();
                          setState(() {
                            if (_valid()) {
                              _getLogin();
                            } else {
                              _valid();
                            }
                          });
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.red[900]),
                          child: const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      VSpace.lg,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     FittedBox(
                      //       child: textStyle(
                      //           text: '${"Didn't have an account? "}',
                      //           style: TextStyles.subTitle2),
                      //     ),
                      //     GestureDetector(
                      //       onTap: () {
                      //         Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => SignUp()),
                      //         );
                      //       },
                      //       child: textStyle(
                      //           text: '${'Sign Up'}',
                      //           style: TextStyles.subTitle2.copyWith(
                      //               fontWeight: FontWeight.bold,
                      //               color: Colors.blue)),
                      //     ),
                      //   ],
                      // ),
                      // Container(
                      //   height: 50,
                      //   margin: EdgeInsets.symmetric(horizontal: 50),
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(50),
                      //       color: Colors.red[900]),
                      //   child: const Center(
                      //     child: Text(
                      //       "Login",
                      //       style: TextStyle(
                      //           color: Colors.white,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //   ),
                      // ),
                      // // FadeAnimation(1.7, Text("Continue with social media", style: TextStyle(color: Colors.grey),)),
                      // SizedBox(height: 30,),
                      // Row(
                      //   children: <Widget>[
                      //     Expanded(
                      //       child: FadeAnimation(1.8, Container(
                      //         height: 50,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(50),
                      //           color: Colors.blue
                      //         ),
                      //         child: Center(
                      //           child: Text("Facebook", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      //         ),
                      //       )),
                      //     ),
                      //     SizedBox(width: 30,),
                      //     Expanded(
                      //       child: FadeAnimation(1.9, Container(
                      //         height: 50,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(50),
                      //           color: Colors.black
                      //         ),
                      //         child: Center(
                      //           child: Text("Github", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      //         ),
                      //       )),
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController passwordController;
  final bool obscureText;
  final String passwordError;
  final VoidCallback togglePassword;
  final FocusNode focusNode;
  PasswordField(
      {required this.passwordController,
      required this.obscureText,
      required this.passwordError,
      required this.togglePassword,
      required this.focusNode});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return new Theme(
        data: new ThemeData(
          primaryColor: Theme.of(context).primaryColor,
        ),
        // textSelectionColor: Theme.of(context).primaryColor),
        child: new TextField(
            focusNode: widget.focusNode,
            autofocus: true,
            controller: widget.passwordController,
            obscureText: true,
            decoration: new InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.red,
              ),
              hintText: "Password",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              errorText: widget.passwordError,
            )));
  }
}

class EmailField extends StatelessWidget {
  final TextEditingController emailController;
  final String emailError;
  final FocusNode focusNode;
  EmailField(
      {required this.emailController,
      required this.emailError,
      required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return new Theme(
        data: new ThemeData(
          primaryColor: Theme.of(context).primaryColorDark,
        ),
        //  textSelectionColor: Theme.of(context).accentColor),
        child: new TextField(
            autofocus: true,
            focusNode: focusNode,
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            decoration: new InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.red,
                ),
                hintText: "Email / Mobile No",
                errorText: emailError)));
  }
}
