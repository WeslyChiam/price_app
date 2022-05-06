import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class getFirstName extends StatelessWidget {
  final String front;
  final String uid;
  final String back;
  getFirstName(this.front, this.uid, this.back);

  CollectionReference users = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Text("$front${data['firstName']}$back");
        }
        return Text("${front}anonymous${back}");
      },
    );
  }
}
