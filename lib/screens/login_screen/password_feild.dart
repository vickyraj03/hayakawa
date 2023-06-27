import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController passwordController;
  final bool obscureText;
  final String passwordError;
  final VoidCallback togglePassword;
  final FocusNode focusNode;
  PasswordField({
    required this.passwordController,
    required  this.obscureText,
    required  this.passwordError,
    required  this.togglePassword,
    required  this.focusNode
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: new Theme(
            data: new ThemeData(
                primaryColor: Theme.of(context).primaryColor,),
               // textSelectionColor: Theme.of(context).primaryColor),
            child: new TextField(
                focusNode: focusNode,
                autofocus: true,
                controller: passwordController,
                obscureText: true,

                decoration: new InputDecoration(
                   prefixIcon: Icon(Icons.lock, color: Colors.blue,),
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.blue.shade200),
                  filled: true,
                  fillColor: Colors.white,
                  border: new UnderlineInputBorder(
                    borderSide: new BorderSide(
                    color: Colors.blue.shade400
                          ),   ),


                  errorText: passwordError,
                ))));
  }
}
