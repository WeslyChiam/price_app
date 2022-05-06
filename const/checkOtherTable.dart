import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:price_app/const/bottomTable.dart';
import 'package:price_app/const/text.dart';

class checkOtherTable extends StatefulWidget {
  final String id;
  checkOtherTable(this.id);

  @override
  State<checkOtherTable> createState() => _checkOtherTableState();
}

class _checkOtherTableState extends State<checkOtherTable> {
  CollectionReference tracks = FirebaseFirestore.instance.collection("tracks");
  @override
  Widget build(BuildContext context) {
    final id = widget.id;
    return FutureBuilder<DocumentSnapshot>(
      future: tracks.doc(id).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Unable to reach to database");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingText(20);
        }
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
        if (data.isEmpty) {
          return NoDataText(20);
        }
        return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return bottomOtherTable(
                  data[index]["${index.toString()}/atrName"],
                  data[index]["${index.toString()}/atrDetail"]);
            });
      },
    );
  }
}
