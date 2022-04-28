import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:price_app/const/color.dart';


class chgName extends StatelessWidget {
  const chgName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    final formKey = GlobalKey<FormState>();
    final firstNameTextController = TextEditingController();
    final secondNameTextController = TextEditingController();
    RegExp regex = RegExp(r'^[a-zA-Z ]{3,50}$');

    Widget nameRow(command) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(command == 'first' ? 'First Name:' : 'Second Name:'),
          TextFormField(
            autofocus: command == 'first' ? true : false,
            controller: command == 'first'
                ? firstNameTextController
                : secondNameTextController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value!.isEmpty) {
                return ('Name cannot be empty');
              } else if (!regex.hasMatch(value)) {
                return ('Name must be between 3 to 50 letters');
              }
            },
            onSaved: command == 'first'
                ? (value) {
                    firstNameTextController.text = value!;
                  }
                : (value) {
                    secondNameTextController.text = value!;
                  },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                hintText: command == 'first' ? 'First Name' : 'Second Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          )
        ],
      );
    }

    Future<void> updateName() {
      return users.doc(uid).update({
        'firstName': firstNameTextController.text,
        'secondName': secondNameTextController.text,
      }).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Succesfully Changed')));
        Navigator.pop(context);
      }).catchError((e) => ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to change name: $e'))));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Name'),
      ),
      body: FutureBuilder(
        future: users.doc(uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshoot) {
          if (snapshoot.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Something went wrong. Please try again')));
            Navigator.pop(context);
          }
          if (snapshoot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshoot.data!.data() as Map<String, dynamic>;
            return Form(
                child: Column(
              children: [
                nameRow('first'),
                nameRow('second'),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: blue, borderRadius: BorderRadius.circular(20)),
                  child: TextButton.icon(
                      onPressed: updateName,
                      icon: const Icon(
                        Icons.save,
                        color: white,
                      ),
                      label: const Text(
                        'Save Changes',
                        style: TextStyle(color: white),
                      )),
                ),


              ],
            ));
          }
          return Container();
        },
      ),
    );
  }
}
