import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:price_app/const/color.dart';

class bottomShowTrack extends StatefulWidget {
  String id;
  bottomShowTrack(this.id);
  @override
  State<bottomShowTrack> createState() => _bottomShowTrack();
}

class _bottomShowTrack extends State<bottomShowTrack> {
  CollectionReference tracks = FirebaseFirestore.instance.collection('tracks');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: tracks.doc(widget.id).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Container(
              height: 200,
              color: white,
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Table(
                        children: [
                          TableRow(children: [
                            const Text("Product Name: "),
                            Text(data['productName'])
                          ])
                        ],
                      )
                    ]),
              ),
            );
          }
          return Container();
        });
  }
}
