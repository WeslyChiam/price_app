import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:price_app/const/color.dart';
import 'package:price_app/const/copy.dart';
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
        return Scaffold(
          appBar: AppBar(
            title: const Text('Require pending'),
          ),
          body: Scrollbar(
              child: ListView.builder(
                  itemCount: data.size,
                  itemBuilder: (context, index) {
                    var command = data.docs[index]['action'];
                    var id = data.docs[index]['id'];
                    var name = data.docs[index]['productName'];
                    var pid = data.docs[index]['pid'];
                    var price = data.docs[index]['price'];
                    var material = data.docs[index]['material'];
                    var uid = data.docs[index]['wroteBy'];
                    var date = data.docs[index]['writtenDate'];
                    var category = data.docs[index]['category'];
                    var distributor = data.docs[index]['distributor'];
                    // var other = data.docs[index]['otherAtr/$index/atrName'];
                    // var otherDetail =
                    //     data.docs[index]['otherAtr/$index/atrDetail'];

                    return Card(
                      child: InkWell(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Text(index.toString()),
                              title: Text(data.docs[index]['productName']),
                              subtitle: getUser(
                                  'Requested By:',
                                  data.docs[index]['wroteBy'],
                                  data.docs[index]['writtenDate']),
                              // subtitle: Text(
                              //     'Requested By $name (${data.docs[index]['writtenDate']})'),
                              trailing: Icon(
                                command == 'ADD'
                                    ? Icons.add_circle
                                    : command == 'DELETE'
                                        ? Icons.remove_circle
                                        : command == 'UPDATE'
                                            ? Icons.update
                                            : null,
                                color: command == 'ADD'
                                    ? green
                                    : command == 'DELETE'
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
                                                    data.docs[index]['wroteBy'],
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
                                                      copy(
                                                          id,
                                                          pid,
                                                          name,
                                                          price,
                                                          material,
                                                          category,
                                                          distributor,
                                                          uid,
                                                          date);
                                                    },
                                                    icon: const Icon(
                                                      Icons.check_outlined,
                                                      color: green,
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
                                                    onPressed: () =>
                                                        Navigator.pop(context),
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
                  })),
        );
      },
    );
  }
}
