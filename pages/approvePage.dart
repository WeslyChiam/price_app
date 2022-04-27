import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:price_app/const/addRecord.dart';
import 'package:price_app/const/color.dart';
import 'package:price_app/const/deleteTrack.dart';
import 'package:price_app/const/getUser.dart';
import 'package:price_app/model/otherTableModel.dart';

class approvePage extends StatefulWidget {
  const approvePage({Key? key}) : super(key: key);

  @override
  State<approvePage> createState() => _approvePageState();
}

class _approvePageState extends State<approvePage> {
  final Stream<QuerySnapshot> _trackStream = FirebaseFirestore.instance
      .collection('tracks')
      // .where('approve', isGreaterThanOrEqualTo: true)
      // .get() as Stream<QuerySnapshot<Object?>>;
      .snapshots(includeMetadataChanges: true);
  ScrollController listScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _trackStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Something went wrong. Please try again')));
          Navigator.pop(context);
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text('Loading...'),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Require pending'),
            ),
            body: const Center(
              child: Text('No one is required anything yet'),
            ),
          );
        }
        final data = snapshot.requireData;
        ScrollController listScrollController = ScrollController();
        if (data.size > 0) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Require List'),
            ),
            body: DraggableScrollbar.semicircle(
                child: ListView.builder(
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      return Card(
                        child: InkWell(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Text((index + 1).toString()),
                                title: Text(
                                    "${data.docs[index]['action']} ${data.docs[index]['productName']}"),
                                subtitle: getUser(
                                    'Requested By:',
                                    data.docs[index]['wroteBy'],
                                    data.docs[index]['writtenDate']),
                                trailing: Icon(
                                  data.docs[index]['action'] == 'ADD'
                                      ? Icons.add_circle
                                      : data.docs[index]['action'] == 'DELETE'
                                          ? Icons.remove_circle
                                          : data.docs[index]['action'] ==
                                                  'UPDATE'
                                              ? Icons.update
                                              : null,
                                  color: data.docs[index]['action'] == 'ADD'
                                      ? green
                                      : data.docs[index]['action'] == 'DELETE'
                                          ? red
                                          : grey,
                                ),
                              ),
                            ],
                          ),
                          splashColor: grey,
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                      height: 200,
                                      color: white,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Table(
                                              children: [
                                                TableRow(children: [
                                                  const Text('Product Name: '),
                                                  Text(data.docs[index]
                                                      ['productName']),
                                                ]),
                                                TableRow(
                                                  children: [
                                                    const Text('Price:'),
                                                    Text(
                                                        'RM ${data.docs[index]['price']}'),
                                                  ],
                                                ),
                                                TableRow(children: [
                                                  const Text('Distributor:'),
                                                  Text(data.docs[index]
                                                      ['distributor']),
                                                ]),
                                                TableRow(children: [
                                                  const Text('Material:'),
                                                  Text(data.docs[index]
                                                      ['material']),
                                                ]),
                                                TableRow(children: [
                                                  const Text('Category:'),
                                                  Text(data.docs[index]
                                                      ['category']),
                                                ]),
                                                TableRow(children: [
                                                  const Text('Last Wrote By:'),
                                                  getUser(
                                                      'Requested By:',
                                                      data.docs[index]
                                                          ['wroteBy'],
                                                      data.docs[index]
                                                          ['writtenDate']),
                                                ]),
                                              ],
                                            ),
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
                                                        addRecord(
                                                                data.docs[index]
                                                                    ['id'])
                                                            .addProductFromTrack();
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
                                                        removeTrack(
                                                                data.docs[index]
                                                                    ['id'])
                                                            .Track();
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Icon(
                                                        Icons.cancel_outlined,
                                                        color: white,
                                                      ),
                                                      label: const Text(
                                                        'Deny',
                                                        style: TextStyle(
                                                            color: white),
                                                      )),
                                                ),
                                              ],
                                            ),
                                            const Text('Other:'),
                                            otherTrackTableModel(
                                                data.docs[index]['pid']),
                                          ],
                                        ),
                                      ));
                                });
                          },
                        ),
                      );
                    }),
                controller: listScrollController),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Require pending'),
          ),
          body: const Center(
            child: Text('There is no requirement yet.'),
          ),
        );
      },
    );
  }
}
