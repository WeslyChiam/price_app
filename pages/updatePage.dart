import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:price_app/const/color.dart';
import 'package:price_app/const/updateProductForm.dart';

class updatePage extends StatelessWidget {
  final String pid;
  final String uid;
  updatePage(this.pid, this.uid);

  @override
  Widget build(BuildContext context) {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');
    return FutureBuilder<DocumentSnapshot>(
      future: products.doc(pid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Something went wrong. Please try again!')));
          Navigator.pop(context);
        }
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.data!.exists) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('No such product')));
          Navigator.pop(context);
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text('Loading...'),
            ),
          );
        }
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
        return Scaffold(
          appBar: AppBar(
            title: Text('Make Changes - ${data['productName']}'),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                color: white,
                child: Padding(
                  padding: const EdgeInsets.all(36),
                  child: updateTextFormFieldInput(pid),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
