import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:price_app/const/text.dart';
import 'package:price_app/const/userInput.dart';

import 'package:price_app/const/color.dart';

class addProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');
    final succesSnackBar =
        SnackBar(content: const Text('Data Succesfully Added!'));
    final failureSnackBar = SnackBar(content: const Text('Unable to Added!'));
    Object addProduct() {
      try {
        products.add({
          'Product Code': 'MECH-COM02-Prod02',
          'Product Name': 'Product 02',
          'Price': '650',
          'Category': 'MECH',
          'Company': 'Company 02'
        });
        return succesSnackBar;
      } catch (e) {
        return failureSnackBar;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: defaultText('Add Product', 20.0, false, true, true),
            ),
            userInput('Product', 'Code'),
            userInput('Product', 'Name'),
            userInput('Product', 'Price'),
            userInput('Product', 'Company'),
            userInput('Product', '').addDataBtn(),
            Container(
              height: 50.0,
              width: 250.0,
              decoration: BoxDecoration(
                color: puprle,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: userInput('Product', '').addDataBtn(),
            )
          ],
        ),
      ),
    );
  }
}
