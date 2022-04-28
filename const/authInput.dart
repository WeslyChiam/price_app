import 'package:flutter/material.dart';

class authInput extends StatefulWidget {
  final bool isItLogin;
  authInput(this.isItLogin);

  @override
  State<authInput> createState() => _authInputState();
}

class _authInputState extends State<authInput> {
  final loginTextController = TextEditingController();

  final regTextController = TextEditingController();

  final passwordTextController = TextEditingController();

  bool _passwordVisible = true;

  void _togglePassword() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget userNameInput() {
    return TextField(
      controller:
          widget.isItLogin == true ? loginTextController : regTextController,
      decoration: InputDecoration(
        prefix: widget.isItLogin == true
            ? const Icon(Icons.login)
            : const Icon(Icons.assignment_ind),
        border: const OutlineInputBorder(),
        labelText: 'E-mail',
        hintText: 'example@mail.com',
      ),
    );
  }

  Widget passwordInput() {
    return TextField(
      controller: passwordTextController,
      decoration: InputDecoration(
        prefix: Icon(Icons.password),
        border: OutlineInputBorder(),
        labelText: 'Password',
        hintText: 'Password',
        suffixIcon: InkWell(
          onTap: _togglePassword,
          child: _passwordVisible
              ? Icon(Icons.visibility)
              : Icon(Icons.visibility_off),
        ),
      ),
    );
  }
}
