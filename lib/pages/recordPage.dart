import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:price_app/const/color.dart';

class historyPage extends StatelessWidget {
  ScrollController listScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _trackStream = FirebaseFirestore.instance
        .collection('tracks')
        .snapshots(includeMetadataChanges: true);
    return Scaffold(
        appBar: AppBar(title: const Text('Record')),
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
            if (data.size > 0) {
              return DraggableScrollbar.semicircle(
                  controller: listScrollController,
                  child: ListView.builder(
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
                      }));
            } else {
              return const Center(
                child: Text('No track history found'),
              );
            }
          },
        ));
  }
}
