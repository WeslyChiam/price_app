import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class getUser extends StatelessWidget {
  final String constantText;
  final String uid;
  final String date;
  getUser(this.constantText, this.uid, this.date);

  CollectionReference users = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    // CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text('This uid is not yet registered');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
              "$constantText ${data['firstName']} ${data['secondName']} ($date)");
        }
        return const Text('Loading');
      },
    );
  }
}
