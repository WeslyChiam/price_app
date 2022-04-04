import 'package:flutter/material.dart';
import 'package:price_app/const/color.dart';
import 'package:price_app/const/text.dart';
import 'package:price_app/pages/mainPage.dart';
import 'package:price_app/pages/regPage.dart';

class loginPage extends StatefulWidget {
  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 150.0,
              width: 190.0,
              padding: const EdgeInsets.only(
                top: 40.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
              ),
              child: const Center(
                child: Text('Place Logo Here'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: defaultText('WELCOME', 20.0, true, false, true),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: loginTextController,
                decoration: const InputDecoration(
                  prefix: Icon(Icons.login),
                  border: OutlineInputBorder(),
                  labelText: 'E-mail',
                  hintText: 'example@mail.com',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                obscureText: _passwordVisible,
                controller: passwordTextController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Password',
                  suffixIcon: InkWell(
                    onTap: _togglePassword,
                    child: _passwordVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
              ),
            ),
            Container(
              height: 50.0,
              width: 250.0,
              decoration: BoxDecoration(
                color: blue,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => mainPage(),
                      ),
                      (route) => false);
                },
                child: defaultText('LOGIN', 25.0, false, false, false),
              ),
            ),
            Container(
              height: 50.0,
              width: 250.0,
              decoration: BoxDecoration(
                color: blue,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => regPage(),
                      ),
                      (route) => false);
                },
                child: defaultText(
                    'New Member? | Register Now', 15.0, false, false, false),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Forgot Password',
                style: TextStyle(
                  color: blue,
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _togglePassword() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }
}
