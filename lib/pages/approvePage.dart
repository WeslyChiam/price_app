import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class approvePage extends StatefulWidget {
  const approvePage({Key? key}) : super(key: key);

  @override
  State<approvePage> createState() => _approvePageState();
}

class _approvePageState extends State<approvePage> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final Stream<QuerySnapshot> _userStream = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
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
              appBar: AppBar(
                title: const Text('Approve List'),
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text("Pending Approve"),
                    ],
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(),
          );
        });
  }
}
