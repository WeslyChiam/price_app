import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:price_app/const/color.dart';
import 'package:price_app/const/addProductForm.dart';


class addProductPage extends StatelessWidget {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Something Went Wrong. Please Try Again!')));
          Navigator.pop(context);
        }
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add New Product'),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  color: white,
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: textFormFieldInput(uid),
                  ),
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
