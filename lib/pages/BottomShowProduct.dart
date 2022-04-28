import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:price_app/const/color.dart';

class bottomShowProduct extends StatefulWidget {
  String id;
  bottomShowProduct(this.id);
  @override
  State<bottomShowProduct> createState() => _bottomShowProductState();
}

class _bottomShowProductState extends State<bottomShowProduct> {
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  @override
  Widget build(BuildContext context) {
    final id = widget.id;
    return FutureBuilder(
      future: products.doc(id).get(),
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
                ),
              ],
            )),
          );
        }
        return Container();
      },
    );
  }
}
