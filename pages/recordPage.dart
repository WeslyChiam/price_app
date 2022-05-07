import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:price_app/const/color.dart';
import 'package:price_app/const/text.dart';

class historyPage extends StatelessWidget {
  ScrollController listScrollController = ScrollController();

  Widget getBody() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("tracks")
            .snapshots(includeMetadataChanges: true),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong, please try again."),
            );
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Row(
                  children: <Widget>[
                    LoadingText(15),
                    const SpinKitFadingCircle(color: grey),
                  ],
                ),
              );

            default:
              final data = snapshot.requireData;
              if (data.size <= 0) {
                return const Center(
                  child: Text('No track history found'),
                );
              } else {
                return DraggableScrollbar.semicircle(
                    controller: listScrollController,
                    child: ListView.builder(
                        itemCount: data.size,
                        itemBuilder: (context, index) {
                          if (data.docs[index]['action'] == "DELETE") {
                            return Card(
                              child: ListTile(
                                title: Text(
                                    "${data.docs[index]['action']} ${data.docs[index]['productName']}"),
                                subtitle: Text(
                                    "Removed by ${data.docs[index]['writtenDate']}"),
                                trailing: const Icon(Icons.delete_forever),
                              ),
                            );
                          } else if (data.docs[index]['action'] == "UPDATE") {
                            return Card(
                              child: ListTile(
                                title: Text(
                                    "${data.docs[index]['action']} ${data.docs[index]['productName']}"),
                                subtitle: Text(
                                    "Update by ${data.docs[index]['writtenDate']}"),
                                trailing: const Icon(Icons.update),
                              ),
                            );
                          }
                          return Card(
                            child: ListTile(
                              title: Text(
                                  "${data.docs[index]['action']} ${data.docs[index]['productName']}"),
                              subtitle: Text(data.docs[index]['approve'] == true
                                  ? "Approved by ${data.docs[index]['writtenDate']}"
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
              }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _trackStream = FirebaseFirestore.instance
        .collection('tracks')
        .snapshots(includeMetadataChanges: true);
    return Scaffold(
      appBar: AppBar(title: const Text('Record')),
      body: getBody(),
    );
  }
}
