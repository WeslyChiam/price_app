import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:price_app/const/color.dart';
import 'package:price_app/const/text.dart';

class userInput extends StatelessWidget {
  final String dataType;
  final String name;
  userInput(this.name, this.dataType);

  final idTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final companyTextController = TextEditingController();
  final descTextController = TextEditingController();
  final categoryTextController = TextEditingController();
  final nullTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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

  Widget addDataBtn() {
    return Container(
      height: 50.0,
      width: 250.0,
      decoration: BoxDecoration(
        color: puprle,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextButton.icon(
        onPressed: () {
          if (name == 'Product') {
            CollectionReference products =
                FirebaseFirestore.instance.collection('products');
            products.add({
              'Product Code': idTextController.text,
              'Product Name': nameTextController.text,
              'Price': priceTextController.text,
              'Company': companyTextController.text,
              'Category': 'MECH'
            });
          } else if (name == 'User') {
            CollectionReference users =
                FirebaseFirestore.instance.collection('users');
            users.add({});
          }
        },
        icon: const Icon(Icons.save),
        label: defaultText('SAVE', 25.0, false, true, false),
      ),
    );
  }
}
