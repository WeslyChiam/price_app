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
        FirebaseFirestore.instance.collection('tracks').doc(id).update({
          'approve': true,
        }).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Succesful add product from track')));
          Navigator.pop(context);
        }).catchError((e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Error: $e')));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Something went wrong. Maybe $name exists?")));
        Navigator.pop(context);
      }
    });
    return Container();
  }
}

class copyWthOther extends StatelessWidget {
  String id;
  String name;
  String pid;
  String price;
  String material;
  String uid;
  String category;
  String distributor;
  String otherAtrName;
  String otherAtrDetail;
  String counter;
  String date;
  copyWthOther(
    this.id,
    this.pid,
    this.name,
    this.price,
    this.material,
    this.category,
    this.distributor,
    this.otherAtrName,
    this.otherAtrDetail,
    this.counter,
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
        FirebaseFirestore.instance
            .collection('products/$pid/otherAtr/')
            .doc(counter)
            .set({
          'atrName': otherAtrName,
          'atrDetail': otherAtrDetail,
        });
        FirebaseFirestore.instance.collection('tracks').doc(id).update({
          'approve': true,
        }).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Succesful add product from track')));
          Navigator.pop(context);
        }).catchError((e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Error: $e')));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Something went wrong. Maybe $name exists?")));
        Navigator.pop(context);
      }
    });
    return Container();
  }
}
