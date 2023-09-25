import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayakawa_new/config/data/perferences.dart';
import 'package:hayakawa_new/config/get_it/get_instances.dart';
import 'package:hayakawa_new/config/request/request.dart';
import 'package:hayakawa_new/cubit/register/register_cubit.dart';
import 'package:hayakawa_new/cubit/register/register_state.dart';
import 'package:hayakawa_new/screens/dashboard_screen/dash_board.dart';
import 'package:hayakawa_new/widgets/Error_text/error_text.dart';
import 'package:hayakawa_new/models/rigister/register_model.dart';
import 'package:hayakawa_new/widgets/appIcon.dart';
import 'package:hayakawa_new/widgets/style/app_color.dart';
import 'package:hayakawa_new/widgets/style/style_insets.dart';
import 'package:hayakawa_new/widgets/style/style_space.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late RegisterCubit _registerCubit;

  List? data;
  RegisterData? registerData;
  bool _terms = false;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  UserReg userReg = new UserReg();

//"testttttt1324", "testmoble@mail.com", "1234567899645787", "India"
  _getRegister() async {
    _registerCubit.getRegister(jsonEncode(RegisterRequest(
        userReg.name, userReg.emails, userReg.mobile, userReg.country)));
  }

  _getCountry() async {
    var map = new Map<String, dynamic>();
    map['type'] = 'country';
    _registerCubit.getCountry(map);
  }

  @override
  void initState() {
    _registerCubit = getItInstance<RegisterCubit>();
    _getCountry();
    // _getRegister();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appPrimaryColor!,
          elevation: 0,
          centerTitle: true,
          title: AppIcon(
            icon: AppIcons.hayakawa_red_white,
            size: Insets.xxl * 2.5,
            color: AppColors.PrimaryColor,
          ),
        ),
        body: registerState());
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

          if (state is RegisterLoaded) {
            if (state.register.result == "success") {
              registerData = state.register.data;
              Preferences.setUserValidate(true);
              Preferences.setUserid(registerData!.studentId.toString());
              // Preferences.setUserName(registerData!.name!);
              // Preferences.setUserEmail(registerData!.username!);
              Future.delayed(Duration.zero, () async {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return DashboardScreen();
                    },
                  ),
                  (_) => false,
                );
              });
            } else {
              Future.delayed(Duration.zero, () async {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("${state.register.message}"),
                ));
              });
            }
          }
          return registerUI();
        },
        listener: (conttext, state) {
          if (state is CountryLoaded) {
            if (state.countrydata.result == "success") {
              data = state.countrydata.data?.countries;
            }
          }
        });
  }

  Widget registerUI() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: Insets.lg),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              child: SingleChildScrollView(
                //  physics: NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Insets.xl),
                  child: Column(
                    children: <Widget>[
                      VSpace.xxl,
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
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]!))),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Student Name",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.red,
                                    ),
                                  ),
                                  validator: (val) => val!.isEmpty
                                      ? 'Student Name is required'
                                      : null,
                                  onSaved: (val) => userReg.name = val!,
                                )),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[200]!))),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Email address",
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
                                onSaved: (val) => userReg.emails = val!,
                              ),
                              // child: const TextField(
                              //   decoration: InputDecoration(
                              //       prefixIcon: Icon(
                              //         Icons.email,
                              //         color: Colors.red,
                              //       ),
                              //       hintText: "Email address",
                              //       hintStyle: TextStyle(color: Colors.grey),
                              //       border: InputBorder.none),
                              // ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[200]!))),
                              child: TextFormField(
                                //  style: TextStyle(color: Colors.blue),
                                //  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                                decoration: InputDecoration(
                                  hintText: "WhatsApp Contact Number",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.phone_iphone,
                                    color: Colors.red,
                                  ),
                                ),
                                validator: (val) => val!.isEmpty
                                    ? 'Contact No is required'
                                    : null,
                                onSaved: (val) => userReg.mobile = val!,
                              ),
                              // child: const TextField(
                              //   decoration: InputDecoration(
                              //       prefixIcon: Icon(
                              //         Icons.phone_iphone,
                              //         color: Colors.red,
                              //       ),
                              //       hintText: "WhatsApp Contact Number",
                              //       hintStyle: TextStyle(color: Colors.grey),
                              //       border: InputBorder.none),
                              // ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Insets.xl, vertical: Insets.med),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[200]!))),
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  hintText: "Select Country",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  enabledBorder: InputBorder.none,
                                ),

                                validator: (val) {
                                  if (val != null) {
                                    return null;
                                  } else {
                                    return 'Country is required';
                                  }
                                },

                                items: data?.map((item) {
                                  return new DropdownMenuItem(
                                    child: Text(
                                      item.name!,
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold),
                                      softWrap: true,
                                    ),
                                    value: item.name.toString(),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    print("##############$value");
                                    userReg.country = value;
                                    print("##############$value");
                                  });
                                },
                                // onSaved: (val) => newAlumni._mySelection = val,
                                //   value: newAlumni._mySelection,
                              ),
                            ),
                          ],
                        ),
                      ),
                      VSpace.lg,
                      Container(
                        padding: EdgeInsets.all(Insets.lg),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(223, 8, 19, 0.29),
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                        child: Center(
                          // child: new SingleChildScrollView(
                          //child: new HtmlView(data: "A textbook of advanced Japanese grammar, covering the important grammar points necessary for the advanced level Japanese learners. This book has been designed with those students in mind who aspire to think in Japanese and hope to express their feelings in near perfect Japanese."),
                          child: TextFormField(
                              textAlign: TextAlign.justify,
                              // scrollPhysics: NeverScrollableScrollPhysics(),
                              maxLines: 6,
                              readOnly: true,
                              enableInteractiveSelection: false,
                              focusNode: FocusNode(),
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Terms & Conditions"),
                              initialValue:
                                  """1. Change of address/email id/telephone, should be communicated to us without fail.
    
  2. Students who absent themselves for 3 consecutive classes without prior permission of the teacher are liable to be removed from the class.
    
  3. Course fees once paid will not be refunded or adjusted under any circumstances.
    
  4. The authorities reserve the right of admission.
    
  5. Upon joining any course in Hayakawa Japanese Language School, students are required to attend / participate in programmes, seminars etc. conducted by the school, when invited to do so as a part of the curriculum. Students who willfully stay away from these functions without valid reason are liable to have their admissions cancelled.
    
  6. All photographs, videos of events, material submitted by the students for the in house magazine, and in various contests/events arranged from time to time are the property of Hayakawa Japanese Language School and Hayakawa Japanese Language school & Cultural Center reserves the right to use such material in their website, posters, brochures, advertisements, press releases, social media etc., for promotional purpose.
    
  I have carefully read and unconditionally accept the terms and conditions 1 to 6 listed above. I declare that I am not a student of any other Japanese Language School."""),
                          // ),
                        ),
                      ),
                      VSpace.lg,
                      CheckboxListTile(
                        value: _terms,
                        onChanged: (bool? value) =>
                            setState(() => _terms = value!),
                        title: const Text(
                          'I Agree to the Terms & Conditions.',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                          softWrap: true,
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        subtitle: !_terms
                            ? const Text(
                                'Required',
                                style: TextStyle(color: Colors.red),
                              )
                            : null,
                        //secondary: new Icon(Icons.archive),
                        activeColor: Colors.red,
                      ),
                      VSpace.med,
                      GestureDetector(
                        onTap: () {
                          final FormState? form = _formKey.currentState;

                          if (!form!.validate()) {
                            alertDlg(context,
                                'Form is not valid!  Please review and correct');
                          } else {
                            if (!_terms) {
                              alertDlg(
                                  context, 'Terms and Condition is Required!');
                            } else {
                              form.save();
                              _getRegister();
                            }
                          }
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => DashboardScreen()),
                          // );
                        },
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColors.appPrimaryColor),
                          child: const Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      VSpace.med,
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

String? validateEmail(String value) {
  RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
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
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Insets.lg, vertical: Insets.lg),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(Consts.padding),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    //  offset: const Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'assets/png/Hayakawa.png',
                    width: Insets.xxl * 2,
                    height: Insets.xxl * 2,
                  ),
                  VSpace(Insets.lg + Insets.med),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  VSpace(Insets.med),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              AppColors.appPrimaryColor // Background color
                          ),
                      onPressed: () {
                        // Navigator.of(context);
                        Navigator.of(context).pop(); // To close the dialog
                      },
                      child: Text('OK'),
                    ),
                  ),
                ],
              ),
            ),
          );
          return alertDialog;
        });

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 100.0;
}

class UserReg {
  String? name;
  String? mobile;
  String? emails;
  String? country;
}
