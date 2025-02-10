import 'package:flutter/cupertino.dart';
import 'package:hayakawa_new/widgets/style/text_style.dart';


class BaseStyledDialog extends StatelessWidget {
  final String  title;
  final  String content;
  final  String action;
  const BaseStyledDialog({Key? key,  this.title='',  this.content='', this.action=''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CupertinoAlertDialog(
      title: textStyle( text: title,textAlign: TextAlign.center,), //const Text('Verification Code Resend'),
      content: textStyle(text:content,textAlign: TextAlign.center), //Text('\n$message'),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: textStyle(text:action,textAlign: TextAlign.center),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )

      ],
    );
  }
}
