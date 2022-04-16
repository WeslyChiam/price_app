import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:price_app/const/color.dart';

class recentTable extends StatelessWidget {
  // final dynamic reference;
  // recentTable(this.reference);
  final Stream<QuerySnapshot> _productStream =
      FirebaseFirestore.instance.collection('product').snapshots();
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _productStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Somehing Went Wrong, Please Try Again',
              style: TextStyle(color: lightBlack));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...', style: TextStyle(color: lightBlack));
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              leading: SvgPicture.asset(
                'assets/svg/air.svg',
                semanticsLabel: 'air',
              ),
              title: Text(data['productName']),
              subtitle: Text(data['price']),
              trailing: Icon(Icons.arrow_right),
              onTap: () {},
            );
          }).toList(),
        );
      },
    );

    // CollectionReference product =
    //     FirebaseFirestore.instance.collection('product');
    // return FutureBuilder<DocumentSnapshot>(
    //   future: product.doc(reference).get(),
    //   builder:
    //       (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    //     if (snapshot.hasError) {
    //       return const Text(
    //         'Something Went Wrong, Try Again!',
    //         style: TextStyle(color: lightBlack),
    //       );
    //     }
    //     if (snapshot.hasData && !snapshot.data!.exists) {
    //       return const Text(
    //         'Not Available Yet',
    //         style: TextStyle(color: lightBlack),
    //       );
    //     }
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       Map<String, dynamic> data =
    //           snapshot.data!.data() as Map<String, dynamic>;
    //       return Table(
    //         defaultColumnWidth: const FixedColumnWidth(100.0),
    //         border: TableBorder.all(
    //             color: black, style: BorderStyle.solid, width: 2.0),
    //         children: [
    //           TableRow(children: [
    //             Column(children: [
    //               Text('Date', style: TextStyle(color: black, fontSize: 15.0))
    //             ]),
    //             Column(children: [
    //               Text('Product Code',
    //                   style: TextStyle(color: black, fontSize: 15.0))
    //             ]),
    //             Column(children: [
    //               Text('Product Name',
    //                   style: TextStyle(color: black, fontSize: 15.0))
    //             ]),
    //             Column(children: [
    //               Text('Price', style: TextStyle(color: black, fontSize: 15.0))
    //             ]),
    //             Column(children: [
    //               Text('Distributor',
    //                   style: TextStyle(color: black, fontSize: 15.0))
    //             ]),
    //           ]),
    //         ],
    //       );
    //     }
    //     return const Text(
    //       'Connecting...',
    //       style: TextStyle(color: lightBlack),
    //     );
    //   },
    // );
  }
}
