import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:price_app/const/color.dart';
import 'package:price_app/const/getUser.dart';
import 'package:price_app/model/otherTableModel.dart';
import 'package:price_app/pages/deleteAlert.dart';
import 'package:price_app/pages/updatePage.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';

class recentTable extends StatefulWidget {
  @override
  State<recentTable> createState() => _recentTableState();
}

class _recentTableState extends State<recentTable> {
  final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance
      .collection('products')
      .snapshots(includeMetadataChanges: true);

  DateTime now = DateTime.now();
  final uid = FirebaseAuth.instance.currentUser!.uid;
  ScrollController listScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _productStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Somehing Went Wrong, Please Try Again',
              style: TextStyle(color: lightBlack, fontSize: 25.0));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...',
              style: TextStyle(color: lightBlack, fontSize: 25.0));
        }
        if (snapshot.data == null || snapshot.hasData) {
          return const Center(
            child: Text(
                "No data has found. Try add a new one by pressing '+' button"),
          );
        }
        final data = snapshot.requireData;
        const String airSVG = 'assets/svg/air.svg';
        const String otherSVG = 'assets/svg/other.svg';
        const String pipeSVG = 'assets/svg/pipe.svg';
        const String mechSVG = 'assets/svg/mech.svg';
        const String elecSVG = 'assets/svg/elec.svg';
        return DraggableScrollbar.semicircle(
          controller: listScrollController,
          child: ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              if (data.size > 0) {
                return Card(
                  child: InkWell(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: SvgPicture.asset(
                            data.docs[index]['category'] == 'AIR'
                                ? airSVG
                                : data.docs[index]['category'] == 'PIPE'
                                    ? pipeSVG
                                    : data.docs[index]['category'] == 'ELEC'
                                        ? elecSVG
                                        : data.docs[index]['category'] == 'MECH'
                                            ? mechSVG
                                            : otherSVG,
                            width: 20,
                            height: 20,
                          ),
                          title: Text(data.docs[index]['productName']),
                          subtitle: Text(
                              "Last updated: ${data.docs[index]['writtenDate']}"),
                          trailing: Text("RM ${data.docs[index]['price']}"),
                        ),
                      ],
                    ),
                    splashColor: grey,
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 200.0,
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
                                          const Text('Product Name:'),
                                          Text(data.docs[index]['productName']),
                                        ]),
                                        TableRow(children: [
                                          const Text('Price:'),
                                          Text(
                                              'RM ${data.docs[index]['price']}'),
                                        ]),
                                        TableRow(children: [
                                          const Text('Distributor:'),
                                          Text(data.docs[index]['distributor']),
                                        ]),
                                        TableRow(children: [
                                          const Text('Material:'),
                                          Text(data.docs[index]['material']),
                                        ]),
                                        TableRow(children: [
                                          const Text('Category:'),
                                          Text(data.docs[index]['category']),
                                        ]),
                                        TableRow(children: [
                                          const Text('Last Wrote By:'),
                                          getUser(
                                              "",
                                              data.docs[index]['wroteBy'],
                                              data.docs[index]['writtenDate']),
                                        ]),
                                      ],
                                    ),
                                    const Text('Other:'),
                                    otherTableModel(data.docs[index]['pid']),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          height: 50,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: blue,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: TextButton.icon(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            updatePage(
                                                                data.docs[index]
                                                                    ['pid'],
                                                                uid)));
                                              },
                                              icon: const Icon(
                                                Icons.update,
                                                color: white,
                                              ),
                                              label: const Text(
                                                'Update',
                                                style: TextStyle(color: white),
                                              )),
                                        ),
                                        Container(
                                          height: 50,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: clear,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: TextButton.icon(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              icon: const Icon(Icons.close,
                                                  color: black),
                                              label: const Text(
                                                'Close',
                                                style: TextStyle(color: black),
                                              )),
                                        ),
                                        Container(
                                          height: 50,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: red,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: TextButton.icon(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            deleteAlert(
                                                                data.docs[index]
                                                                    ['pid'],
                                                                data.docs[index]
                                                                    [
                                                                    'productName'])));
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: white,
                                              ),
                                              label: const Text(
                                                'Remove',
                                                style: TextStyle(color: white),
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
              }

              return const Center(
                child: Text(
                    "No data has found. Try add a new one by pressing '+' button"),
              );
            },
          ),
        );
      },
    );
  }
}
