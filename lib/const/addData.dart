import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<bool> addProduct(String pid, String name, int price, String distributor,
    String material, String category, String date) async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var value = price.toDouble();
    DocumentReference product_ref =
        FirebaseFirestore.instance.collection('products').doc(pid);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(product_ref);
      if (snapshot.exists) {
        const AlertDialog(
          title: Text('Duplicated Name Found!'),
          content: Text(
              'This name and category is been used. Please use other name and/or category. If there is still problem please contact adminstrator'),
        );
        return false;
      } else {
        product_ref.set({
          'pid': pid,
          'productName': name,
          'price': value,
          'distributor': distributor,
          'material': material,
          'wroteBy': uid,
          'writtenDate': date,
        });
        return true;
      }
    });
    return false;
  } catch (e) {
    return false;
  }
}

// Future<bool> addCoin(String id, String amount) async {
//   try {
//     String uid = FirebaseAuth.instance.currentUser.uid;
//     var value = double.parse(amount);
//     DocumentReference documentReference = FirebaseFirestore.instance
//         .collection('Users')
//         .doc(uid)
//         .collection('Coins')
//         .doc(id);
//     FirebaseFirestore.instance.runTransaction((transaction) async {
//       DocumentSnapshot snapshot = await transaction.get(documentReference);
//       if (!snapshot.exists) {
//         documentReference.set({'Amount': value});
//         return true;
//       }
//       double newAmount = snapshot.data()['Amount'] + value;
//       transaction.update(documentReference, {'Amount': newAmount});
//       return true;
//     });
//     return true;
//   } catch (e) {
//     return false;
//   }
// }
