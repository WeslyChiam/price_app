import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:price_app/const/color.dart';

class pendingTable extends StatefulWidget {
  const pendingTable({Key? key}) : super(key: key);

  @override
  State<pendingTable> createState() => _pendingTableState();
}

Widget pendingModal(stream) {
  return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong. Please try again');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasData) {
          return const Text('No pending in list now');
        }
        final data = snapshot.requireData;
        return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              return Card(
                child: InkWell(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text(data.docs[index]['productName']),
                        subtitle: Text(data.docs[index]['approve'] == true
                            ? 'Approved'
                            : 'Waiting for approve'),
                        trailing: Icon(
                            data.docs[index]['approve'] == true
                                ? Icons.assignment_turned_in
                                : Icons.autorenew,
                            color: data.docs[index]['approve'] == true
                                ? green
                                : red),
                      ),
                    ],
                  ),
                  splashColor: grey,
                  onTap: () {},
                ),
              );
            });
      });
}

class _pendingTableState extends State<pendingTable> {
  final Stream<QuerySnapshot> _trackStream = FirebaseFirestore.instance
      .collection('tracks')
      .snapshots(includeMetadataChanges: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending List'),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(child: pendingModal(_trackStream)),
      ),
    );
  }
}
