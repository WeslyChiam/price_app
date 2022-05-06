import 'package:flutter/widgets.dart';
import 'package:price_app/const/getUser.dart';

Widget bottomMainTable(
  String name,
  String price,
  String distributor,
  String material,
  String category,
  bool fromProducts,
  String uid,
  String date,
) {
  return Table(
    children: [
      TableRow(children: [const Text("Product Name: "), Text(name)]),
      TableRow(children: [const Text("Price(RM): "), Text(price)]),
      TableRow(children: [const Text("Distributor: "), Text(distributor)]),
      TableRow(children: [const Text("Material: "), Text(material)]),
      TableRow(children: [const Text("Category: "), Text(category)]),
      TableRow(children: [
        Text(fromProducts ? "Last Written By: " : "Requested By: "),
        getUser("", uid, date)
      ]),
    ],
  );
}

Widget bottomOtherTable(String atrName, String atrDetail) {
  return Table(
    children: [
      TableRow(children: [Text(atrName), Text(atrDetail)])
    ],
  );
}
