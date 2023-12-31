import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayakawa_new/config/get_it/get_instances.dart';
import 'package:hayakawa_new/config/request/request.dart';
import 'package:hayakawa_new/cubit/register/register_cubit.dart';
import 'package:hayakawa_new/cubit/register/register_state.dart';
import 'package:hayakawa_new/screens/login_screen/login_screen.dart';
import 'package:hayakawa_new/screens/login_screen/sign_up_page.dart';
import 'package:hayakawa_new/widgets/Error_text/error_text.dart';
import 'package:hayakawa_new/widgets/style/font_size.dart';
import 'package:hayakawa_new/widgets/style/text_style.dart';

import '../../widgets/appIcon.dart';
import '../../widgets/style/app_color.dart';
import '../../widgets/style/style_insets.dart';
import '../../widgets/style/style_space.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late RegisterCubit _registerCubit;
  String msg = '';
  bool _show = false;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  ForPwdReg forPwdReg = new ForPwdReg();

  _getForgotPassword() async {
    _registerCubit
        .getPassword(jsonEncode(ForgotPasswordRequest(forPwdReg.emails)));
  }

  @override
  void initState() {
    _registerCubit = getItInstance<RegisterCubit>();

    // _getRegister();
    // TODO: implement initState
    super.initState();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: registerState());
  }

  Widget registerState() {
    return BlocConsumer<RegisterCubit, RegisterState>(
        bloc: _registerCubit,
        builder: (context, state) {
          if (state is RegisterLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ErrorState) {
            return ErrorTxt(
              message: '${state.error}',
              ontap: () {},
            );
          }

          if (state is forgotPasswordLoaded) {
            if (state.forgotPassword.result == "success") {
              msg = state.forgotPassword.message!;
              _show = true;
            } else {
              Future.delayed(Duration.zero, () async {
                alertDlg(context, state.forgotPassword.message.toString());
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //   content: Text("${state.forgotPassword.message}"),
                // ));
              });
            }
          }
          return forgotPasswordUI();
        },
        listener: (conttext, state) {
          // if (state is forgotPasswordLoaded) {
          //   if (state.forgotPassword.result == "success") {

          //     //  data = state.countrydata.data;
          //   }
          // }
        });
  }

  Widget forgotPasswordUI() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appPrimaryColor,
        centerTitle: true,
        // automaticallyImplyLeading: false,
        //  leading: Icon(Icons.drag_handle),
        title: AppIcon(
          icon: AppIcons.hayakawa_red_white,
          size: Insets.xxl * 2.5,
          color: AppColors.PrimaryColor,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            VSpace.xl,
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
                    child: _show == false
                        ? Column(
                            children: <Widget>[
                              VSpace.xxl,
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                          color:
                                              Color.fromRGBO(223, 8, 19, 0.29),
                                          blurRadius: 20,
                                          offset: Offset(0, 10))
                                    ]),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]!))),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: "Email",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Colors.red,
                                      ),
                                    ),
                                    validator: (val) => val!.isEmpty
                                        ? 'Email is required'
                                        : validateEmail(val),
                                    onSaved: (val) => forPwdReg.emails = val!,
                                  ),
                                ),
                              ),
                              VSpace.lg,
                              GestureDetector(
                                onTap: () {
                                  final FormState? form = _formKey.currentState;
                                  if (!form!.validate()) {
                                    alertDlg(context, 'Enter valid email id');
                                  } else {
                                    form.save();
                                    _getForgotPassword();
                                  }
                                },
                                child: Container(
                                  height: Insets.xxl,
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: AppColors.appPrimaryColor),
                                  child: const Center(
                                    child: Text(
                                      "Request Password",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: <Widget>[
                              VSpace.xxl,
                              Container(
                                  padding: EdgeInsets.all(Insets.lg),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color.fromRGBO(
                                                223, 8, 19, 0.29),
                                            blurRadius: 20,
                                            offset: Offset(0, 10))
                                      ]),
                                  child: textStyle(
                                    text: msg,
                                    style: TextStyles.body1,
                                  )),
                              VSpace.xl,
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return MyWidget();
                                      },
                                    ),
                                    (_) => false,
                                  );
                                },
                                child: Container(
                                  height: Insets.xxl,
                                  margin: EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: AppColors.appPrimaryColor),
                                  child: const Center(
                                    child: Text(
                                      "Retrun to Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ForPwdReg {
  late String emails;
}
