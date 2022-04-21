import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class chgPassword extends StatelessWidget {
  const chgPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final user = FirebaseAuth.instance.currentUser;

    final formKey = GlobalKey<FormState>();
    final passwordTextController = TextEditingController();
    final confirmPasswordTextController = TextEditingController();
    RegExp regex = RegExp(r'^.{6,}$');

    Future<void> updatePassword() async {
      try {
        await user?.updatePassword((passwordTextController.text)).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Succesfully Changed')));
        }).catchError((e) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to change password: $e'))));
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }

    Widget passwordRow(command) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(command == 'password' ? 'New Password:' : 'Confirm Password'),
          TextFormField(
            autofocus: command == 'password' ? true : false,
            controller: command == 'password'
                ? passwordTextController
                : confirmPasswordTextController,
            keyboardType: TextInputType.name,
            obscureText: true,
            validator: command == 'password'
                ? (value) {
                    if (value!.isEmpty) {
                      return ('Password cannot be empty');
                    } else if (!regex.hasMatch(value)) {
                      return ('Password must be at least 6 characters');
                    }
                  }
                : (value) {
                    if (value!.isEmpty) {
                      return ('Password cannot be empty');
                    } else if (confirmPasswordTextController.text !=
                        passwordTextController.text) {
                      return ('Password do not match');
                    }
                  },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: command == 'password' ? 'Password' : 'Confirm Password',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: FutureBuilder(
        future: users.doc(uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Something went wrong. Please try again.')));
            Navigator.pop(context);
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Form(
              child: Column(
                children: [
                  passwordRow('password'),
                  passwordRow(''),
                  TextButton.icon(
                      onPressed: updatePassword,
                      icon: Icon(Icons.save),
                      label: const Text('Save Changes'))
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
