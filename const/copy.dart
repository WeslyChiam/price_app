import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class copy extends StatelessWidget {
  String id;
  String name;
  String pid;
  String price;
  String material;
  String uid;
  String category;
  String distributor;
  String date;
  copy(
    this.id,
    this.pid,
    this.name,
    this.price,
    this.material,
    this.category,
    this.distributor,
    this.uid,
    this.date,
  );

  @override
  Widget build(BuildContext context) {
    DocumentReference product_ref =
        FirebaseFirestore.instance.collection('products').doc(pid);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(product_ref);
      if (!snapshot.exists) {
        product_ref.set({
          'pid': pid,
          'productName': name,
          'price': price,
          'distributor': distributor,
          'material': material,
          'category': category,
          'wroteBy': uid,
          'writtenDate': date,
        });
      } else {}
      FirebaseFirestore.instance.collection('tracks').doc(id).update({
        'approve': true,
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Succesful add product from track')));
      }).catchError((e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      });
    });
    return Container();
  }
}
