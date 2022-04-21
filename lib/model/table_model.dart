import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:price_app/const/color.dart';
import 'package:price_app/const/getUser.dart';

class recentTable extends StatefulWidget {
  @override
  State<recentTable> createState() => _recentTableState();
}

class _recentTableState extends State<recentTable> {
  // final dynamic reference;
  final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance
      .collection('products')
      .snapshots(includeMetadataChanges: true);

  DateTime now = DateTime.now();
  final uid = FirebaseAuth.instance.currentUser!.uid;
  ScrollController listScrollController = ScrollController();

  Widget productRow(dataType, data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(dataType == 'name'
            ? 'Product Name: '
            : dataType == 'price'
                ? 'Price: '
                : dataType == 'material'
                    ? 'Material: '
                    : dataType == 'distributor'
                        ? 'Distributor: '
                        : dataType == 'category'
                            ? 'Category: '
                            : dataType == 'uid'
                                ? 'Last Wrote By: '
                                : dataType == 'date'
                                    ? 'Last Written By: '
                                    : ''),
        dataType == 'uid'
            ? getUser(uid)
            : dataType == 'price'
                ? Text('RM $data')
                : Text(data)
      ],
    );
  }

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
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasData) {
          return const Center(
            child: Text('No data has found. Try add a new one by pressing ' +
                ' button'),
          );
        }

        final data = snapshot.requireData;
        const String airSVG = 'assets/svg/air.svg';
        const String otherSVG = 'assets/svg/other.svg';
        const String pipeSVG = 'assets/svg/pipe.svg';
        const String mechSVG = 'assets/svg/mech.svg';
        const String elecSVG = 'assets/svg/elec.svg';
        return ListView.builder(
          controller: listScrollController,
          itemCount: data.size,
          itemBuilder: (context, index) {
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                productRow(
                                    'name', data.docs[index]['productName']),
                                productRow('price', data.docs[index]['price']),
                                productRow('distributor',
                                    data.docs[index]['distributor']),
                                productRow(
                                    'material', data.docs[index]['material']),
                                productRow(
                                    'category', data.docs[index]['category']),
                                productRow('uid', data.docs[index]['wroteBy']),
                                productRow(
                                    'date', data.docs[index]['writtenDate']),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('Update')),
                                    ElevatedButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Close')),
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
          },
        );
      },
    );
  }
}
