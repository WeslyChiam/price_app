import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:price_app/const/color.dart';
import 'package:price_app/const/text.dart';
import 'package:price_app/pages/approvePage.dart';

class authPage extends StatelessWidget {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final Stream<QuerySnapshot> _userStream = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
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
          String auth = data['authority'];
          return Scaffold(
            appBar: AppBar(
              title: const Text('Authentication'),
            ),
            body:
                ListView(padding: const EdgeInsets.all(8.0), children: <Widget>[
              mainTitle("${data['firstName']}'s authority level: $auth"),
              content("The function you get access to:"),
              bulletList("1. ", "View the database at any time"),
              auth == 'Level-1'
                  ? bulletList("2. ",
                      "You are required approval to made changes of database")
                  : bulletList(
                      "2. ", "You can freely made changes of database"),
              content(
                  "In order to change your authority level, please contact the adminstrator"),
              Container(
                height: 50.0,
                width: 250.0,
                decoration: BoxDecoration(
                    color: blue, borderRadius: BorderRadius.circular(20.0)),
                child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => approvePage()));
                    },
                    icon: const Icon(
                      Icons.pending,
                      color: white,
                    ),
                    label: const Text(
                      "PENDING",
                      style: TextStyle(color: white),
                    )),
              ),
            ]),
          );
        }
        return Scaffold(
          appBar: AppBar(),
        );
      },
    );
  }
}
