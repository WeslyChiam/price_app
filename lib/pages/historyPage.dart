import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:price_app/const/color.dart';

class historyPage extends StatelessWidget {
  const historyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _trackStream =
        FirebaseFirestore.instance.collection('tracks').snapshots();
    return Scaffold(
        appBar: AppBar(title: const Text('History')),
        body: StreamBuilder<QuerySnapshot>(
          stream: _trackStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong. Please try again');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            }
            if (snapshot.connectionState == ConnectionState.done &&
                !snapshot.hasData) {
              return const Center(
                child: Text('No track record found'),
              );
            }
            final data = snapshot.requireData;
            return ListView.builder(
                itemCount: data.size,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
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
                  );
                });
          },
        ));
  }
}
