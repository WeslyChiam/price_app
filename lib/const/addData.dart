import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:price_app/const/text.dart';

class addData extends StatelessWidget {
  final idTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final companyTextController = TextEditingController();
  final descTextController = TextEditingController();
  final categoryTextController = TextEditingController();
  final nullTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final encodePasswordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(Icons.save),
      label: defaultText('SAVE', 25.0, false, true, false),
      onPressed: () {
        var now = DateTime.now();
        DateFormat date = DateFormat.yMd().add_jm();
        String str_date = date.toString();

        try {
          CollectionReference products =
              FirebaseFirestore.instance.collection('products');
          products.add({
            'Product Code': idTextController.text,
            'Product Name': nameTextController.text,
            'Price': priceTextController.text,
            'Company': companyTextController.text,
            'Category': 'MECH',
            'Last Modify': str_date
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: defaultText(
                  'Data Succesfully Added!', 10.0, false, false, false)));
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: defaultText('Error Happen! Please Try Again', 10.0,
                  false, false, false)));
        }
      },
    );
  }

  Widget textField(name, dataType) {
    return TextField(
      controller: dataType == 'Code'
          ? idTextController
          : dataType == 'Name'
              ? nameTextController
              : dataType == 'Price'
                  ? priceTextController
                  : dataType == 'Desc'
                      ? descTextController
                      : companyTextController,
      decoration: InputDecoration(
        prefix: dataType == 'Code'
            ? const Icon(Icons.code)
            : dataType == 'Name'
                ? const Icon(Icons.account_circle)
                : dataType == 'Price'
                    ? const Icon(Icons.price_change)
                    : dataType == 'Desc'
                        ? const Icon(Icons.text_fields)
                        : const Icon(Icons.abc),
        border: const OutlineInputBorder(),
        labelText: dataType == 'Code'
            ? '$name Code'
            : dataType == 'Name'
                ? '$name Name'
                : dataType == 'Price'
                    ? '$name Price'
                    : dataType == 'Desc'
                        ? 'Description'
                        : 'Company',
      ),
    );
  }
}
