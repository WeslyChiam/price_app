import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:price_app/const/color.dart';

class otherTableModel extends StatelessWidget {
  String pid;
  otherTableModel(this.pid);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _otherStream = FirebaseFirestore.instance
        .collection('products/$pid/otherAtr')
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: _otherStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final data = snapshot.requireData;
            return ListView.builder(
                itemCount: data.size,
                itemBuilder: (context, index) {
                  return RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: data.docs[index]['${index.toString()}/atrName'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: black,
                            fontSize: 20)),
                    TextSpan(
                        text: data.docs[index]['${index.toString()}/atrDetail'],
                        style: const TextStyle(fontSize: 20))
                  ]));
                });
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }
          return const Text('No other attributes');
        });
  }
}

class otherTrackTableModel extends StatelessWidget {
  String pid;
  otherTrackTableModel(this.pid);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _otherStream = FirebaseFirestore.instance
        .collection('tracks/$pid/otherAtr')
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: _otherStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasData) {
            return const Text('No other attributes');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return const Text('Loading...');
          }
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final data = snapshot.requireData;
            return ListView.builder(
                itemCount: data.size,
                itemBuilder: (context, index) {
                  return RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: data.docs[index]['${index.toString()}/atrName'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: black,
                            fontSize: 20)),
                    TextSpan(
                        text: data.docs[index]['${index.toString()}/atrDetail'],
                        style: const TextStyle(fontSize: 20))
                  ]));
                });
          }
          return const Text('No other attributes');
        });
  }
}
