import 'package:flutter/material.dart';
import 'package:price_app/const/color.dart';
import 'package:price_app/const/text.dart';
import 'package:price_app/pages/loginPage.dart';
import 'package:price_app/pages/mainPage.dart';

class regPage extends StatefulWidget {
  @override
  State<regPage> createState() => _regPageState();
}

class _regPageState extends State<regPage> {
  final regTextController = TextEditingController();
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
              padding: const EdgeInsets.only(top: 40.0),
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
                controller: regTextController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-mail',
                    hintText: 'example@mail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: passwordTextController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  prefix: const Icon(Icons.password),
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
                child: defaultText('REGISTER', 25.0, false, false, false),
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
                        builder: (context) => loginPage(),
                      ),
                      (route) => false);
                },
                child: defaultText(
                    'Already member? | Login', 15.0, false, false, false),
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
