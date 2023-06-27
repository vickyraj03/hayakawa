import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController emailController;
  final String emailError;
  final FocusNode focusNode;
  EmailField({required this.emailController,required this.emailError,required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: new Theme(
            data: new ThemeData(
                primaryColor: Theme.of(context).primaryColorDark,),
              //  textSelectionColor: Theme.of(context).accentColor),
            child: new TextField(
                autofocus: true,
                focusNode: focusNode,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: new InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade400)),
                    prefixIcon: Icon(Icons.account_circle, color: Colors.blue,),
                    hintText: "Email / Mobile No",
                    hintStyle: TextStyle(color: Colors.blue.shade200),
                    filled: true,
                    fillColor: Colors.white,

                    errorText: emailError))));
  }
}
