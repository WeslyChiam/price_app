import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:price_app/const/text.dart';
import 'package:price_app/const/userInput.dart';

import 'package:price_app/const/color.dart';
import 'package:price_app/model/product_model.dart';

class addProductPage extends StatefulWidget {
  @override
  State<addProductPage> createState() => _addProductPageState();
}

class _addProductPageState extends State<addProductPage> {
  final _formKey = GlobalKey<FormState>();
  final nameTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final companyTextController = TextEditingController();
  final materialTextController = TextEditingController();
  final otherTextController = TextEditingController();
  String productDDValue = 'AIR';
  DateTime now = DateTime.now();

  bool otherCategory = false;

  @override
  void dispose() {
    nameTextController.dispose();
    priceTextController.dispose();
    companyTextController.dispose();
    materialTextController.dispose();
    otherTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');
    final succesSnackBar = SnackBar(content: Text('Data Succesfully Added!'));
    final failureSnackBar = SnackBar(content: Text('Unable to Added!'));

    final nameField = TextFormField(
      autofocus: false,
      controller: nameTextController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty || value == null) {
          return ('Name cannot be empty');
        } else if (!regex.hasMatch(value)) {
          return ('Name must be longer than 3 characters');
        }
        return null;
      },
      onSaved: (value) {
        nameTextController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.code),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Product Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    final priceField = TextFormField(
      autofocus: false,
      controller: priceTextController,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty || value == null) {
          return ('Price cannot be empty');
        }
        return null;
      },
      onSaved: (value) {
        priceTextController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.price_change),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Price(RM)',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    final companyField = TextFormField(
      autofocus: false,
      controller: companyTextController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty || value == null) {
          return ('Company name cannot be empty');
        } else if (!regex.hasMatch(value)) {
          return ('Company name cannot be less than 3 characters');
        }
        return null;
      },
    );

    final materialField = TextFormField(
      autofocus: false,
      controller: materialTextController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty || value == null) {
          return ('Material name cannot be empty');
        } else if (!regex.hasMatch(value)) {
          return ('Material name cannot be kess than 3 charactets');
        }
        return null;
      },
    );

    final otherField = TextFormField(
      enabled: otherCategory,
      autofocus: false,
      controller: otherTextController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty || value == null) {
          return ('Specific type name cannot be empty');
        } else if (!regex.hasMatch(value)) {
          return ('Specific type name cannot be less than 3 characters');
        }
        return null;
      },
    );

    final productCategoryDD = DropdownButton<String>(
      value: productDDValue,
      icon: const Icon(Icons.arrow_drop_down),
      onChanged: (String? newValue) {
        productDDValue = newValue!;
      },
      items: <String>['AIR', 'ELEC', 'MECH', 'PIPE', 'Other']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(value: value, child: Text(value));
      }).toList(),
    );

    final chckBox = Checkbox(
        value: otherCategory,
        onChanged: (value) {
          setState(() {
            otherCategory = value ?? false;
          });
        });

    final addProductBtn;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 45.0),
                    nameField,
                    const SizedBox(height: 20.0),
                    priceField,
                    const SizedBox(height: 20.0),
                    productCategoryDD,
                    const SizedBox(height: 20.0),
                    companyField,
                    const SizedBox(height: 20.0),
                    materialField,
                    const SizedBox(height: 20.0),
                    chckBox,
                    const SizedBox(height: 20.0),
                    otherField,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  addProduct() async {
    String day = now.day.toString();
    String month = now.month.toString();
    String year = now.year.toString();
    String formattedDate = day + '/' + month + '/' + year;

    String hour = now.hour.toString();
    String min = now.minute.toString();
    String formattedTime = hour + ':' + min;

    String dateNtime = formattedTime + formattedDate;

    String pid = productDDValue + nameTextController.text;

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    ProductModel productModel = ProductModel();
    productModel.pid = pid;
    productModel.name = nameTextController.text;
    productModel.price = priceTextController.hashCode;
    productModel.category = productDDValue;
    productModel.company = companyTextController.text;
    productModel.date = dateNtime;

    await firebaseFirestore
        .collection('products')
        .doc(pid)
        .set(productModel.toMap());
  }
}
