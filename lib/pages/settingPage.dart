import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:price_app/const/color.dart';
import 'package:price_app/pages/chgEmail.dart';
import 'package:price_app/pages/chgName.dart';
import 'package:price_app/pages/chgPassword.dart';

class settingPage extends StatefulWidget {
  @override
  State<settingPage> createState() => _settingPageState();
}

class _settingPageState extends State<settingPage> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final Stream<QuerySnapshot> _userStream = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  final formKey = GlobalKey<FormState>();
  final firstNameTextController = TextEditingController();
  final secondNameTextController = TextEditingController();
  RegExp regex = RegExp(r'^[a-zA-z0-9 ]{3,50}$');

  @override
  void dispose() {
    firstNameTextController.dispose();
    secondNameTextController.dispose();
  }

  void clearTextController() {
    firstNameTextController.clear();
    secondNameTextController.clear();
  }

  Widget settingList(command) {
    return Card(
      child: InkWell(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(command == 'name'
                  ? Icons.account_circle
                  : command == 'email'
                      ? Icons.email
                      : Icons.password),
              title: Text(command == 'name'
                  ? 'Change My Name'
                  : command == 'email'
                      ? 'Change My Email'
                      : 'Change my password'),
              trailing: const Icon(Icons.arrow_right),
            ),
          ],
        ),
        onTap: command == 'name'
            ? () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const chgName()))
            : command == 'email'
                ? () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const chgEmail()))
                : () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const chgPassword())),
        splashColor: grey,
      ),
    );
  }

  Widget textFormTypeInput(data) {
    return TextFormField(
      autofocus: data == 'first' ? true : false,
      controller:
          data == 'first' ? firstNameTextController : secondNameTextController,
      keyboardType: TextInputType.name,
      validator: data == 'first'
          ? (value) {
              if (value!.isEmpty) {
                return ('First name cannot be empty');
              } else if (!regex.hasMatch(value)) {
                return ('First name must be between 3 to 50 letters');
              }
              return null;
            }
          : (value) {
              if (value!.isEmpty) {
                return ('Second name cannot be empty');
              } else if (!regex.hasMatch(value)) {
                return ('Second name must be between 3 to 50 letters');
              }
            },
      onSaved: data == 'first'
          ? (value) {
              firstNameTextController.text = value!;
            }
          : (value) {
              secondNameTextController.text = value!;
            },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: data == 'first' ? 'First Name' : 'Second Name',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder(
        future: users.doc(uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Something went wrong. Please try again.")));
            Navigator.pop(context);
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
              appBar: AppBar(title: const Text('Setting')),
              body: ListView(
                padding: const EdgeInsets.all(20),
                children: <Widget>[
                  Center(
                    child: Column(
                      children: <Widget>[
                        settingList('name'),
                        settingList('email'),
                        settingList('password'),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(),
          );
        });
  }
}
