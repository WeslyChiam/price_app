import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:price_app/const/addRecord.dart';
import 'package:price_app/const/bottomTable.dart';
import 'package:price_app/const/color.dart';
import 'package:price_app/const/deleteTrack.dart';
import 'package:price_app/const/getUser.dart';
import 'package:price_app/const/text.dart';

class approvePage extends StatefulWidget {
  const approvePage({Key? key}) : super(key: key);

  @override
  State<approvePage> createState() => _approvePageState();
}

class _approvePageState extends State<approvePage> {
  final Stream<QuerySnapshot> _trackStream = FirebaseFirestore.instance
      .collection("tracks")
      .snapshots(includeMetadataChanges: true);
  ScrollController listScrollController = ScrollController();
  String title = "Require Approval";

  Widget getBody() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("tracks")
            .where("approve", isEqualTo: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Something went wrong.")));
            Navigator.pop(context);
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Row(
                  children: <Widget>[
                    LoadingText(15),
                    const SpinKitFadingCircle(color: grey)
                  ],
                ),
              );
            default:
              final data = snapshot.requireData;
              if (data.size <= 0) {
                return Center(child: NoDataText(15));
              }
              return DraggableScrollbar.semicircle(
                  controller: listScrollController,
                  child: ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        int _tmpIndex = index;
                        String _strIndex = _tmpIndex.toString();
                        return Card(
                          child: InkWell(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: Text(_strIndex),
                                  title: Text(
                                      "${data.docs[index]['action']} ${data.docs[index]['productName']}"),
                                  subtitle: getUser(
                                      "Requested by:",
                                      data.docs[index]['wroteBy'],
                                      data.docs[index]['writtenDate']),
                                  trailing: const Icon(Icons.arrow_right),
                                )
                              ],
                            ),
                            splashColor: grey,
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 300,
                                      color: white,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            bottomMainTable(
                                                data.docs[index]['productName'],
                                                data.docs[index]['price'],
                                                data.docs[index]['distributor'],
                                                data.docs[index]['material'],
                                                data.docs[index]['category'],
                                                false,
                                                data.docs[index]['wroteBy'],
                                                data.docs[index]
                                                    ['writtenDate']),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Container(
                                                  height: 50,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      color: green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: TextButton.icon(
                                                      onPressed: () {
                                                        if (data.docs[index]
                                                                ['action'] ==
                                                            "ADD") {
                                                          addRecord(data.docs[
                                                                  index]['id'])
                                                              .addProductFromTrack();
                                                        } else if (data
                                                                    .docs[index]
                                                                ['action'] ==
                                                            "DELETE") {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "products")
                                                              .doc(data.docs[
                                                                  index]['id'])
                                                              .delete();
                                                        } else {
                                                          addRecord(data.docs[
                                                                  index]['id'])
                                                              .addProductFromTrack();
                                                        }
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "tracks")
                                                            .doc(
                                                                data.docs[index]
                                                                    ['id'])
                                                            .update({
                                                          'approve': true,
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Icon(
                                                        Icons.check_outlined,
                                                        color: white,
                                                      ),
                                                      label: const Text(
                                                        'Approve',
                                                        style: TextStyle(
                                                            color: white),
                                                      )),
                                                ),
                                                Container(
                                                  height: 50,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      color: red,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: TextButton.icon(
                                                      onPressed: () {
                                                        removeTrack(data
                                                            .docs[index]['id']
                                                            .Track());
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    'Remove ${data.docs[index]['productName']}')));
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Icon(
                                                        Icons.cancel_outlined,
                                                        color: white,
                                                      ),
                                                      label: const Text(
                                                        'Reject',
                                                        style: TextStyle(
                                                            color: white),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                        );
                      }));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: getBody(),
    );
  }
}
