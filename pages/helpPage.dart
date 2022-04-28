import 'package:flutter/material.dart';
import 'package:price_app/const/text.dart';

class helpPage extends StatelessWidget {
  const helpPage({Key? key}) : super(key: key);

  // Widget mainTitle(data) {
  //   return Text(
  //     data,
  //     style: const TextStyle(fontSize: 25.0),
  //   );
  // }

  // Widget content(data) {
  //   return Text(
  //     data,
  //     style: const TextStyle(fontSize: 10.0),
  //   );
  // }

  // Widget question(data) {
  //   return Text(
  //     "Q: $data",
  //     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          mainTitle("What is the purpose of this app?"),
          content(
              "This app is for viewing details of product including name, price, distributor, material, category from IT-Usaha database."),
          content(
              "User with authority Level 1 can only request to update or remove certain product from database from approval of other user with authority Level 2 or above"),
          content(
              "For changing the authority of current user, please contact the adminstrator."),
          mainTitle("Can I use this app in other device?"),
          content(
              "As long as you have an account un this app, you can use this service at any android device"),
          content("Currently development this app do not include in IOS store"),
          mainTitle(
              "Is it necessary for me to register an account for this app?"),
          content(
              "Yes. User are required to register for this app in order to view,update and remove the database. Since all of this transaction will be recorded in log file."),
          mainTitle("I found issues when using this app. How do I fix it?"),
          boldFirstLetter("Q: ", "I can't login to this app"),
          boldFirstLetter("A: ",
              "Please ensure you are registered in this app by using the registration service provide in this app."),
          boldFirstLetter("Q: ",
              "I've made some changes for some products, but the database do not appear the latest record."),
          boldFirstLetter("A: ",
              "If your account authority is Level 1, you need to wait approval from user with higher authority for making any changes."),
          content(
              "If none of the following above solve your problems using this app, please contact adminstrator for help."),
        ],
      ),
    );
  }
}
