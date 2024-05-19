import 'package:flutter/material.dart';
import 'handler.dart';

class LoginForm {
  String password = "";
  String email = "max.mustermann@gmx.de";
}

class Login extends StatefulWidget {
  Login({Key? key, required this.form, required this.handler})
      : super(key: key);

  LoginForm form;
  PageHandler handler;

  @override
  createState() => _LoginState(handler: handler);
}

class _LoginState extends State<Login> {
  _LoginState({
    Key? key,
    required this.handler,
  }) : super();

  PageHandler handler;
  final TextEditingController _emailc = TextEditingController();
  final TextEditingController _passwordc = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailc.dispose();
    _passwordc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login"),
              Row(
                children: [
                  SizedBox(
                    width: 170,
                    height: 60,
                    child: TextField(
                      controller: _emailc,
                      decoration: InputDecoration(labelText: "email"),
                      // onChanged: (s) => { setState(() => widget.form.email = s) },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 170,
                    height: 60,
                    child: TextField(
                      obscureText: true,
                      controller: _passwordc,
                      decoration: InputDecoration(labelText: "password"),
                      onChanged: (s) =>
                          {setState(() => widget.form.password = s)},
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () => {
                            handler.loginUser(
                                widget.form.email, widget.form.password)
                          },
                      child: Text("login")),
                  Container(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() => handler.toSubpage(1)),
                    child: Text("signup"),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
