import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class addTrack extends StatelessWidget {
  final String pid;
  final String name;
  final double value;
  final String distributor;
  final String material;
  final String date;
  final String dateNtime;
  addTrack(this.pid, this.name, this.value, this.distributor, this.material,
      this.date, this.dateNtime);

  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    DocumentReference track_ref =
        FirebaseFirestore.instance.collection('tracks').doc(dateNtime);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(track_ref);
      if (!snapshot.exists) {
        track_ref.set({
          'pid': pid,
          'productName': name,
          'price': value,
          'distributor': distributor,
          'material': material,
          'wroteBy': uid,
          'writtenDate': date,
        });
      }
    });
    return Container();
  }
}
