import 'package:flutter/material.dart';
import 'handler.dart';

class SignupForm {
  String password = "";
  String email = "max.mustermann@gmx.de";
}

class Signup extends StatefulWidget {
  Signup({Key? key, required this.form, required this.handler})
      : super(key: key);

  SignupForm form;
  PageHandler handler;

  @override
  createState() => _SignupState(handler: handler);
}

class _SignupState extends State<Signup> {
  _SignupState({
    Key? key,
    required this.handler,
  }) : super();

  PageHandler handler;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          children: [
            Text("Mail: "),
            // Textfield
          ],
        ),
        Row(
          children: [
            TextButton(
              onPressed: () => {},
              child: Text("Submit"),
            ),
            TextButton(
              onPressed: () => {handler.toSubpage(0)},
              child: Text("Cancel"),
            ),
          ],
        ),
      ]),
    );
  }
}
